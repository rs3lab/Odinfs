#!/usr/bin/env python3
import os
import sys
import signal
import subprocess
import datetime
import tempfile
import optparse
import time
import pdb
import cpupol
from os.path import join

CUR_DIR = os.path.abspath(os.path.dirname(__file__))

class FileBench(object):
    WORKLOAD_DIR = os.path.normpath(os.path.join(CUR_DIR, "filebench-workloads"))
    PRE_SCRIPT = os.path.normpath(os.path.join(CUR_DIR, "turnoff-aslr"))
    FILEBENCH_BIN = "filebench"
    PERF_STR = "IO Summary: "
    VIDEO_READ_STR = "vidreader"
    VIDEO_WRITE_STR = "newvid"

    def __init__(self, type_, ncore_, nsocket_, duration_, root_,
                 profbegin_, profend_, proflog_, dthreads_, delegate_):
        self.config = None
        self.bench_out = None
        # take configuration parameters
        self.workload = type_
        self.ncore = int(ncore_)
        self.nsocket = int(nsocket_)
        self.duration = int(duration_)
        self.root = root_
        self.profbegin = profbegin_
        self.profend = profend_
        self.proflog = proflog_
        self.profenv = ' '.join(["PERFMON_LEVEL=%s" %
                                 os.environ.get('PERFMON_LEVEL', "x"),
                                 "PERFMON_LDIR=%s"  %
                                 os.environ.get('PERFMON_LDIR',  "x"),
                                 "PERFMON_LFILE=%s" %
                                 os.environ.get('PERFMON_LFILE', "x")])
        self.perf_msg = None
        self.video_read_msg = None
        self.video_write_msg = None
        self.dthreads = dthreads_;
        self.delegate = bool(int(delegate_));

    def __del__(self):
        # clean up
        # try:
        #     if self.config:
        #         os.unlink(self.config.name)
        #     if self.bench_out:
        #         os.unlink(self.bench_out.name)
        # except:
        #     pass
        return

    def run(self):
        # set up benchmark configuration
        if not self.generate_config():
            return -1
        # run pre-script then sync
        self._exec_cmd("sudo %s; sync" % FileBench.PRE_SCRIPT).wait()
        # start performance profiling
        self._exec_cmd("%s %s" % (self.profenv, self.profbegin)).wait()
        # run filebench
        self._run_filebench()
        # stop performance profiling
        self._exec_cmd("%s %s" % (self.profenv, self.profend)).wait()
        return 0

    def _get_cpu_ranges(self):
        ret = ' '
        core_per_socket = cpupol.CORE_PER_CHIP;

        for i in range(1, int(self.nsocket) + 1):
            begin = core_per_socket * (i - 1) + int(self.dthreads);
            end = core_per_socket * i - 1;
            if (i > 1):
                ret = ret + ',';

            ret = ret + str(begin) + '-' + str(end)

        return ret;

    def _run_filebench(self):
        taskset_cmd= ' '
        if (self.delegate):
            taskset_cmd = 'taskset -a -c ' + self._get_cpu_ranges()
            print (taskset_cmd)

        with tempfile.NamedTemporaryFile(delete=False) as self.bench_out:
            cmd = "sudo %s %s -f %s" % (taskset_cmd, FileBench.FILEBENCH_BIN, 
                                        self.config.name)
            p = self._exec_cmd(cmd, subprocess.PIPE)
            while True:
                for l in p.stdout.readlines():
                    self.bench_out.write("#@ ".encode("utf-8"))
                    self.bench_out.write(l)
                    l_str = str(l)
                    if self.workload == "videoserver":
                        find_str = FileBench.VIDEO_WRITE_STR if self.video_read_msg else FileBench.VIDEO_READ_STR
                        idx = l_str.find(find_str)
                        if idx != -1:
                            if self.video_read_msg:
                                self.video_write_msg = l_str[idx+len(find_str):]
                            else:
                                self.video_read_msg = l_str[idx+len(find_str):]
                    else:
                        idx = l_str.find(FileBench.PERF_STR)
                        if idx != -1:
                            self.perf_msg = l_str[idx+len(FileBench.PERF_STR):]
                # if not p.poll():
                #    break
                if self.workload == "videoserver":
                    if self.video_read_msg and self.video_write_msg:
                        break
                else:
                    if self.perf_msg:
                        break
            self.bench_out.flush()

    def report(self):
        if self.workload == "videoserver":
            self.report_videoserver()
        else:
            self.report_filebench()

    def report_videoserver(self):
        read_bw, write_bw = 0, 0
        unit = 'mb/s'
        for item in self.video_read_msg.split(','):
            vk = item.strip().split()
            if vk[2].endswith(unit):
                read_bw = vk[2][:-len(unit)]
        for item in self.video_write_msg.split(','):
            vk = item.strip().split()
            if vk[2].endswith(unit):
                write_bw = vk[2][:-len(unit)]
        profile_name = ""
        profile_data = ""
        try:
            with open(self.proflog, "r") as fpl:
                l = fpl.readlines()
                if len(l) >= 2:
                    profile_name = l[0]
                    profile_data = l[1]
        except:
            pass
        print("# ncpu secs read_bw write_bw %s" % profile_name)
        print("%s %s %s %s %s" %
              (self.ncore, self.duration, read_bw, write_bw, profile_data))

    def report_filebench(self):
        # 32.027: IO Summary: 9524462 ops 317409.718 ops/s 28855/57715 rd/wr 7608.5mb/s 0.470ms/op
        work = 0
        work_sec = 0
        for item in self.perf_msg.split(','):
            # hard-code for now...
            vk = item.strip().split()
            if vk[1] == "ops":
                work = vk[0]
            if vk[3] == "ops/s":
                work_sec = vk[2]
        profile_name = ""
        profile_data = ""
        try:
            with open(self.proflog, "r") as fpl:
                l = fpl.readlines()
                if len(l) >= 2:
                    profile_name = l[0]
                    profile_data = l[1]
        except:
            pass
        print("# ncpu secs works works/sec %s" % profile_name)
        print("%s %s %s %s %s" %
              (self.ncore, self.duration, work, work_sec, profile_data))

    def generate_config(self):
        # check config template
        config_template = os.path.normpath(os.path.join(FileBench.WORKLOAD_DIR,
                                                        self.workload + ".f"))
        if not os.path.isfile(config_template):
            return False
        # create a configured workload file
        self.config = tempfile.NamedTemporaryFile(delete=False)
        self.config.write(b'# auto generated by fxmark\n')
        self.config.close()
        self.setup_workload_start()
        self._exec_cmd("cat %s >> %s" % (config_template, self.config.name)).wait()
        self.setup_workload_end()
        return True

    def setup_workload_start(self):
        # config number of workers
        if self.workload == "fileserver":
            self._append_to_config("set $nthreads=%d"   % (self.ncore))
        elif self.workload == "varmail":
            self._append_to_config("set $nthreads=%d"   % (self.ncore))
        elif self.workload == "videoserver":
            # make the number of write threads the same as the number of sockets
            # we use. So with less or equal than 28 cores, I have 1 writer
            # thread. And then, the number of writer threads increase as we
            # increase the number of sockets
            wthreads = self.nsocket
            rthreads = self.ncore - wthreads
            self._append_to_config("set $wthreads=%d"   % (wthreads))
            self._append_to_config("set $rthreads=%d"   % (rthreads))
        elif self.workload == "webserver":
            self._append_to_config("set $nthreads=%d"   % (self.ncore))
        else:
            return False
        # config target dir and benchmark time
        self._append_to_config("set $dir=%s"            % self.root)
        return True

    def setup_workload_end(self):
        self._append_to_config("run %d"                 % self.duration)
        return True

    def _append_to_config(self, config_str):
        self._exec_cmd("echo \'%s\' >> %s" % (config_str, self.config.name)).wait()

    def _exec_cmd(self, cmd, out=None):
        print(cmd)
        p = subprocess.Popen(cmd, shell=True, stdout=out, stderr=out)
        return p

if __name__ == "__main__":
    parser = optparse.OptionParser()
    parser.add_option("--type", help="workload name")
    parser.add_option("--ncore", help="number of core")
    parser.add_option("--nsocket", help="number of socket")
    parser.add_option("--duration", help="benchmark time in seconds")
    parser.add_option("--root", help="benchmark root directory")
    parser.add_option("--profbegin", help="profile begin command")
    parser.add_option("--profend", help="profile end command")
    parser.add_option("--proflog", help="profile log path")
    parser.add_option("--delegation_threads", help="delegation per socket")
    parser.add_option("--delegate", help="reserve CPUs for delegation threads"
                                            " or not")
    (opts, args) = parser.parse_args()

    # check options
    for opt in vars(opts):
        val = getattr(opts, opt)
        if val == None:
            print("Missing options: %s" % opt)
            parser.print_help()
            exit(1)

    # run benchmark
    filebench = FileBench(opts.type, opts.ncore, opts.nsocket, opts.duration, 
                          opts.root, opts.profbegin, opts.profend, opts.proflog,
                          opts.delegation_threads, opts.delegate)
    rc = filebench.run()
    filebench.report()
    exit(rc)


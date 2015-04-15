#!/usr/bin/python
import sys
import subprocess
import time
import os

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print "Usage: startMongoCluster.py <setup file> <path to binaries> [<extraoption> ...]"
        sys.exit(-1)

    setupFile = sys.argv[1]
    binDir = sys.argv[2] if len(sys.argv) > 2 else ""
    if binDir == ".":
        binDir = ""

    for line in open(setupFile):
        if line == "" or line.isspace():
            continue
        segments = line.rstrip('\n').split('|')
        if len(segments) < 3:
            print "Found only one '|' delimiter, most likely using old setup file"
            sys.exit(-1)
        (termName, binName, binArgs) = segments
        binPath = os.path.join(binDir, binName)
        termCommand = binPath + " " + binArgs
        for option in sys.argv[3:]:
            termCommand += " " + option
        bashCmd = "%s; echo -e '\\nCommand run:\\n%s'; bash;" % (termCommand, termCommand)
        if sys.platform == "linux" or sys.platform == "linux2":
            cmd = "gnome-terminal --geometry=50x15 -t %s -x bash -c \"%s\"" % (termName, bashCmd)
        elif sys.platform == "darwin":
            cmd = "xterm -title %s -e bash -c \"%s\"" % (termName, bashCmd)
        else:
            print "Unsupported platform: %s" % sys.platform
            sys.exit(-1)
        print cmd
        subprocess.Popen(cmd, shell=True)
        time.sleep(1)

#!/usr/bin/python
import sys
import subprocess
import time

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print "Usage: startMongoCluster.py <filepath> [<extraoption> ...]"
        sys.exit(-1)

    setupFile = sys.argv[1]

    for line in open(setupFile):
        if line == "" or line.isspace():
            continue
        (termName, termCommand) = line.rstrip('\n').split('|')
        for option in sys.argv[2:]:
            termCommand += " " + option
        cmd = "gnome-terminal --geometry=50x15 -t %s -x bash -c \"%s; echo -e '\\nCommand run:\\n%s'; bash;\"" % (termName, termCommand, termCommand)
        print cmd
        subprocess.Popen(cmd, shell=True)
        time.sleep(1)

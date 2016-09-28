#!/usr/bin/python
import sys
import re

if (len(sys.argv) < 2):
    print("Usage: which_tests_did_not_complete.py <task_logs.txt>")
    sys.exit(0)

filename = sys.argv[1]

started_tests = []
completed_tests = []

with open(filename) as f:
    content = f.readlines();

for line in content:
    m = re.search("Running .*\.js", line)
    if m:
        started_tests.append(m.group(0)[len("Running "):])

    m = re.search("0000 .* ran in", line)
    if m:
        completed_tests.append(m.group(0)[5:-7])

print("tests that started but did not complete:")
print(list(set(started_tests) - set(completed_tests)))

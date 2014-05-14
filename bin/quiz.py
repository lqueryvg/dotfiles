#!/usr/bin/env python

import argparse
# . /opt/rh/python33/enable

parser = argparse.ArgumentParser()
parser.add_argument("filename")
args = parser.parse_args()
print(args.filename)
exit(0)

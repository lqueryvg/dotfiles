#!/usr/bin/env python3

import argparse

parser = argparse.ArgumentParser(description='Generate some questions')
parser.add_argument('filename', nargs=1)
args = parser.parse_args()
print(args.filename)

file_content = open(args.filename)

exit(0)

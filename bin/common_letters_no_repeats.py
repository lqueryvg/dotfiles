#!/usr/bin/env python3

import argparse

parser = argparse.ArgumentParser(description='Generate some questions')
parser.add_argument('filename', nargs=1)
args = parser.parse_args()
#print(args.filename)

try:
    file_obj = open(*args.filename)
except IOError:
    print("failed to open file '" + args.filename[0] + "'")
    exit(-1)

def commonLetters(*strings):
        return set.intersection(*map(set,strings))

strings = file_obj.read().splitlines()

print("The following letters are common in all lines of the file:")
print("<" + "".join(sorted(commonLetters(*strings))) + ">")

exit(0)

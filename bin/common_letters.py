#!/usr/bin/env python3

import argparse
import collections

parser = argparse.ArgumentParser(description='''
    Reads list of strings from a file, one per line, and prints
    a list of characters that are common to all strings.
    Repeat characters are not condensed, so for example the two strings
    "abbccc", "abcczz" would have and "abcc" in common.
                                 ''')
parser.add_argument('filename', nargs=1)
args = parser.parse_args()

try:
    file_obj = open(*args.filename)
except IOError:
    print("failed to open file '" + args.filename[0] + "'")
    exit(-1)

def commonLetters(strings):
    result = collections.Counter(strings.pop(0))
    for str in strings:
        # intersection
        result = result & collections.Counter(str)
    return result.elements()

strings = file_obj.read().splitlines()

print("The following letters are common in all lines of the file:")
print("<" + "".join(sorted(commonLetters(strings))) + ">")

exit(0)

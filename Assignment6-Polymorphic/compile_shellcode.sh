#!/bin/bash

echo "Assembling the shellcode..."
nasm -f elf32 $1.nasm

echo "Linking the shellcode..."
ld -m elf_i386 $1.o -o $1

echo ""
echo "Prettified shellcode:"
objdump -d ./$1 |grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

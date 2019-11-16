#!/bin/bash

nasm -f elf32 bind.nasm
ld -m elf_i386 bind.o -o bind
objdump -d ./bind |grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

#!/bin/bash

nasm -f elf32 egghunter.nasm
ld -m elf_i386 egghunter.o -o egghunter
objdump -d ./egghunter |grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

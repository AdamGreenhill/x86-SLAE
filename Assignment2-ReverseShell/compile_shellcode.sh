#!/bin/bash

nasm -f elf32 linux_x86_reverse_shell.nasm
ld -m elf_i386 linux_x86_reverse_shell.o -o linux_x86_reverse_shell
objdump -d ./linux_x86_reverse_shell |grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

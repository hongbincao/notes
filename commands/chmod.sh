
There are four OCTAL (0..7) digits, which control the file permissions. But often, only three are used. If you use 600 it equals 0600. The 
missing digit is appended at the beginning of the number.

Each of three digits described permissions. Position in the number defines to which group permissions do apply!
Permissions:
1 – can execute
2 – can write
4 – can read

The octal number is the sum of those free permissions, i.e.
3 (1+2) – can execute and write
6 (2+4) – can write and read

Position of the digit in value:
1 – what owner can
2 – what users in the file group(class) can
3 – what users not in the file group(class) can

Examples:
chmod 600 file – owner can read and write
chmod 700 file – owner can read, write and execute
chmod 666 file – all can read and write
chmod 777 file – all can read, write and execute
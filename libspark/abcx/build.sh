#!/bin/sh

java -jar asc.jar -strict -warning -import builtin.abc -import toplevel.abc abcx.as
avmplus abcx.abc -- abcx.abc > abcx.abc.c
gcc -o abcx.abx abcx.abc.c
rm abcx.abc.c


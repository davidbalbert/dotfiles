#!/bin/sh

# plan9port stuff

9 fontsrv -m /mnt/font &
9 plumber
9 9pfuse $(9 namespace)/plumb /mnt/plumb

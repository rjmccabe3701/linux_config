#!/bin/bash
if [ -f /mnt/c/Windows/System32/paste.exe ]; then
   #Need this tool:
   #https://www.c3scripts.com/tutorials/msdos/paste.zip

   #Get rid of windows line endings
   /mnt/c/Windows/System32/paste.exe | sed 's/\r$//'
else
   echo "nvimPaste.sh not implemented for your platform" >&2
fi

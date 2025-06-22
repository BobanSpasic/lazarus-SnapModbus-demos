# Lazarus SnapModbus demos  
The [SnapModbus library](https://snapmodbus.sourceforge.io) contains WinBroker and WinDevice demos for Lazarus.  
I have extended the demos with some functions like:
- open/save configuration (device settings and registers/coils/inputs content)
- detecting COM ports available on the system and list just these in Settings (both Windows and Linux)
- hide/show rows


Directory ext contains compiled libraries for Windows 64-bit and Linux 64-bit.  
Windows DLL should be copied to the directory with the compiled EXE file.  
Linux SO file should be copied to /usr/lib/ directory. For detailed instructions, please referr to the linux_readme in doc directory.  
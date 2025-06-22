Installation
============

copy libsnapmb.so from ext directory to /usr/lib/

Navigate to /usr/lib/ and change the file permissions:
sudo chmod -o+rx libsnapmb.so


Using serial ports on Linux
===========================

To use serial ports on Linux, your user need to be added to dialout group.

find your user name:
whoami

add user to dialout group:
sudo usermod -a -G dialout your_username

check if the user is added to the dialout group:
getent group dialout

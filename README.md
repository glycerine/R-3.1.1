R-3.1.1
=======

R-3.1.1 with builtin (vendored) libraries for RProtoBuf, rzmq, Rserve, and shiny.

See also https://github.com/mailgun/pebblezgo for sample code using Protocol Buffers over ZeroMQ.


installation:

~~~
# linux pre-req, X11 dev headers
apt-get install libx11-dev libxt-dev libcairo2-dev 

# OSX pre-req, a working gfortran compiler (might also need XQuartz if not already)
brew reinstall gcc49 --disable-multilib --enable-fortran
cd /usr/local/bin
sudo ln -s gfortran-4.9 gfortran
# if you don't already have X11 on your mac, get XQuartz from here http://xquartz.macosforge.org
# e.g. wget http://xquartz.macosforge.org/downloads/SL/XQuartz-2.7.7.dmg


# install protocol buffers 2.6.0 and ZeroMQ 4.0.4 system wide.

#### zeromq
wget http://download.zeromq.org/zeromq-4.0.4.tar.gz
tar xf zeromq-4.0.4.tar.gz
cd zeromq-4.0.4
./configure
make && sudo make install

#### zeromq c++ header, now separate.
git clone https://github.com/zeromq/cppzmq
# backup, vendored location: git clone https://github.com/mailgun/cppzmq
cd cppzmq/
sudo cp -p zmq.hpp /usr/local/include/


#### protocol buffers
wget https://protobuf.googlecode.com/svn/rc/protobuf-2.6.0.tar.gz
tar xf protobuf-2.6.0.tar.gz
cd protobuf-2.6.0
./configure
make && sudo make install

#### then R-3.1.1
git clone git@github.com:mailgun/R-3.1.1
cd R-3.1.1
./configure --prefix=`pwd`/install --enable-R-static-lib  --enable-R-shlib
make -j 4
make install
echo "export PATH=`pwd`/install/bin:\$PATH" >> ~/.bashrc
. ~/.bashrc
~~~

Note: I had to delete the 'clients -> src/client' symlink from the Rserve_1.8-1.tar.gz package in
 order to get automatic installation during build. Hence the checksum will be different if you
re-download Rserve_1.8-1.tar.gz.

new checksum: 
~~~
d86b7f615988df08c6318ce7e572e4d6d74c7375  /home/jaten/nosymlink.Rserve_1.8-1.tar.gz
~~~


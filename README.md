R-3.1.1
=======

R-3.1.1 with builtin Rserve_1.8-1.tar.gz.

installation:

~~~
apt-get install libx11-dev libxt-dev
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


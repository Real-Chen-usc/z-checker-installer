#!/bin/bash

rootDir=`pwd`

#---------- download Z-checker --------------
git clone https://github.com/CODARcode/Z-checker.git
cd Z-checker
./configure --prefix=$rootDir/Z-checker/zc-install
make
make install
cp ../zc-patches/generateReport.sh ./examples/

#---------- download ZFP and set the configuration -----------
cd $rootDir

git clone https://github.com/LLNL/zfp.git
cd zfp
make

cd -
cp zfp-patches/zfp-zc.c zfp/utils
cp zfp-patches/*.sh zfp/utils

cd zfp/utils/
patch -p0 < ../../zfp-patches/Makefile-zc.patch
make

#---------- download SZ and set the configuration -----------
cd $rootDir
git clone https://github.com/disheng222/SZ

cd SZ/sz/src
patch -p1 < ../../../sz-patches/sz-src-hacc.patch

cd ../..
./configure --prefix=$rootDir/SZ/sz-install
make
make install

cd example
patch -p0 < ../../sz-patches/Makefile-zc.bk.patch
make -f Makefile.bk
cp ../../Z-checker/examples/zc.config .
patch -p0 < ../../zc-patches/zc-probe.config.patch

cp ../../sz-patches/sz-zc-ratedistortion.sh .
cp ../../sz-patches/testfloat_CompDecomp.sh .

#----------- download latexmk --------------------------------
cd $rootDir
latexmk_url=http://ctan.math.utah.edu/ctan/tex-archive/support/latexmk.zip
latexmk_dir=latexmk
if [ ! -d "$latexmk_dir" ]; then
	curl -O $latexmk_url
	unzip latexmk.zip
	cd $latexmk_dir
	ln -s "$rootDir/$latexmk_dir/latexmk.pl" latexmk
	if [ -f ~/.zshrc ]; then
		echo "export PATH=$rootDir/$latexmk_dir:\$PATH" >> ~/.zshrc
		source ~/.zshrc
	elif [ -f ~/.bashrc ]; then
		echo "export PATH=$rootDir/$latexmk_dir:\$PATH" >> ~/.bashrc
		source ~/.bashrc
	else
		echo "Note: cannot find ~/.bashrc or ~/.zshrc"
		echo "Please add \"export PATH=$rootDir/$latexmk_dir:\$PATH\" to your reboot-environment-variable list."
	fi
fi

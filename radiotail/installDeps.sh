#!/usr/bin/bash
set -e
sudo apt update

sudo apt install -y tree rtl-sdr libao4 libasound2 libfftw3-single3 libsndfile1 multimon-ng

set +e
sudo apt install -y libliquid1d || sudo apt install -y libliquid2d
git clone https://github.com/szpajder/libacars || git --git-dir ./libacars/.git pull
set -e

cd libacars
THREADS=$(grep processor /proc/cpuinfo|wc -l)
cmake ./ && make -j${THREADS} && sudo make -j${THREADS} install
cd ../ ; rm -rf libacars

echo -e "Done.\nRun ./radiotail"

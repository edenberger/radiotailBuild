#!/usr/bin/env bash
set -ex

  # Init
VERSION=0.1
export THREADS=$(grep processor /proc/cpuinfo |wc -l)
RELEASE=stable
echo $@|grep -q -- '--dev' && RELEASE=dev
echo $@|grep -q -- '--help' && echo "usage: $0 [--dev]" && exit 0
mkdir -p build
cd build

  # Cleanup
#rm -rf am433-0.0.5 am433-0.0.5.tar.gz

sudo apt update
sudo apt install -y tree libasound2-dev pandoc golang libboost-all-dev libboost-dev gcc make cmake pkg-config git build-essential autoconf libtool libao-dev libfftw3-dev librtlsdr-dev rtl-sdr libsndfile1-dev libliquid-dev automake libglib2.0-dev multimon-ng
set +e
sudo apt install -y gr-gsm && (grep -q gsm lists/bin.list || echo gsm >> lists/bin.list)
set -e

  # Installing rtlamr in case `go` in the right version, no decoder script implemented.
#which go &>/dev/null && if [[ $(echo "$(go version|egrep -o go[0-9].+" "|cut -d"o" -f2|cut -d"." -f1,2) >= 1.13" |bc -l) ]]
#then
#  GO_ENV=$(go env GOPATH)
#  go env -w GOPATH=$(dirname $(realpath $0))/.go
#  set +e
#  go get github.com/bemasher/rtlamr
#  set -e
#  go env -w GOPATH=${GO_ENV}
#fi

export CMAKE_VARS=" "

  # Fetching repositories
cat ../lists/repo.list | while read repo; do
  repoName=$(basename $(echo $repo|cut -d" " -f1))
  repoLink=$(echo $repo|cut -d" " -f1)
  versionLink=$(echo $repo|cut -d" " -f2)

  if [[ $RELEASE == stable ]]; then
    if [[ $(echo $versionLink|grep http -q ; echo $?) == 0 ]];then
      wget $versionLink -O - | tar xz
    else
      set +e
      git clone $repoLink
      set -e
    fi
  else # $RELEASE = dev
    if [[ $(grep ^${repoName} <(ls -A) &>/dev/null; echo $?) != 0 ]];then
      git clone $repoLink
    else
      git -C $repoName remote update
    fi
  fi
done

  # All libraries and source to install should be called [0-9]libname
set +e
mv -f libacars 1libacars
set -e

#for release in $(find * -maxdepth 0 -type f -iname "*.tar.gz") ; do
#  tar xf $release
#done
  # Compile and install libraries
for repo in $(find * -maxdepth 0 -type d -regex '^[0-9].*'); do
  cd $repo
  ../../scripts/compileAndInstall.sh
  cd ..
done

  # Compile the repositories
for repo in $(find * -maxdepth 0 -type d -not \( -regex '^[0-9].*' -o -iname "bin" \) ); do
  CMAKE_VARS=" "
  cd $repo
  test $repo = nrf && cd unit/range/nrf905_decoder/ && ./build.sh && cd ../../../../ && continue
#  test $repo = vdlm2dec && CMAKE_VARS="-Drtl=ON"
#  test $repo = vortrack && (set +e ; mv Makefile.rtl Makefile ; set -e)
  test $repo = nrsc5 && CMAKE_VARS="-DUSE_COLOR=ON"
  ../../scripts/compile.sh
  cd ..
done

  # Installing am433-capture
#wget 'https://web.archive.org/web/20190426175131/https://www.tablix.org/~avian/am433/am433-0.0.5.tar.gz'
#tar xf am433-0.0.5.tar.gz
#cd am433-0.0.5/am433
#sed -i 's|ound|ound -lm|' Makefile
#make -j $THREADS
#sudo make -j $THREADS install
#cd ../../

  # Move all binaries
FIND="find . -type f -perm -u+x \( -iname $(head -1 ../lists/bin.list) "
for i in $(tail -n+2 ../lists/bin.list);do
  FIND="$FIND -o -iname $i"
done
FIND="$FIND \) |xargs -I % cp -f % ../../radiotail/bin/"
eval $FIND
#mv ../../radiotail/bin/capture ../../radiotail/bin/am433capture

  # Make a tarball
tar cf ../../radiotail-${VERSION}.tar.gz ../../radiotail

echo Done...

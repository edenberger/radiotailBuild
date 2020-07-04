#!/usr/bin/env bash
set -eux

ls | grep -q autogen.sh && ./autogen.sh ; echo $?
ls | grep -iq cmake && rm -rf build && mkdir -p build && cd build && cmake -j$THREADS ../ $CMAKE_VARS ; echo $?
test -f ./configure && (./configure ; echo $?)
make -j$THREADS ; echo $?

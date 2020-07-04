# Radiotail

Metasploit-like framework for recording and decoding radio signals

The framework lets you combain between -
1. Source input: DVB-T antenna or an IQ file
2. Demodulators: AM/FM
3. Decoders: rtl_443, dump1090, nrf905, etc
4. (Optional) Descrumblers: deinvert

The purpose is to automate and ease the identification stage of raw encoded data

The autopwn module works only on recorded files for now, it `cat` the file to all supported decoders

# Demo

![GIF demo](radiotail/art/radiotail.gif)

# Installation

installDeps.sh and build.sh was built for Ubuntu 20.04.

Easiest way:
1. Download the release -
```console
$ wget 
```
2. Unpack -
```console
$ tar xf ./radiotail*
```
3. Enter the direcory -
```console
$ cd ./radiotail*
```
4. Install the dependencies -
```console
$ ./installDeps.sh
```
5. Run radiotail -
```console
$ ./radiotail
```

Build mostly from source:

1. Clone this repository -
```console
$ git clone https://github.com/edenberger/radiotailBuild.git
```
2. Enter the build directory -
```console
$ cd radiotailBuild/build
```
3. Run the build script -
```console
$ ./build.sh
```
4. Go to the main radiotail directory -
```console
$ cd ../radiotail
```
5. Run radiotail -
```console
$ ./radiotail
```

# Developers

The framework wrapper written in bash keeping KIS(S) in mind.

Main file is .source.

When implementing a new function you can choose between letting help() parse it or not.
For help() to parse it syntax must be:  
fucntion foo  
Description: bar  
{  
  main_code  
}  
  
To keep it hidden from help(), use something like:  
foo () { # Description  
  main_code  
}  

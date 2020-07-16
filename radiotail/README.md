# RADIOTAIL

Metasploit-like framework for recording and decoding radio signals

The framework lets you combain between -
1. Source input: DVB-T antenna or an IQ file
2. Demodulators: AM/FM
3. Decoders: rtl_443, dump1090, nrf905, etc
4. (Optional) Descrumblers: deinvert

The purpose is to automate and ease the identification stage of raw encoded data

The autopwn module works only on recorded files for now, it `cat` the file to all supported decoders

# Installation

Install dependencies and run:
```console
./installDeps.sh
./radiotail
```

# Demo

![GIF demo](art/radiotail.gif)

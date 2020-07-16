# RADIOTAIL

Metasploit-like framework for recording and decoding radio signals

The framework lets you combain between -
1. Source input: DVB-T antenna or an IQ file
2. Demodulators: AM/FM
3. Decoders: rtl_443, dump1090, nrf905, etc
4. (Optional) Descrumblers: deinvert

The purpose is to automate and ease the identification stage of raw encoded data

The autopwn module works only on recorded files for now, it `cat` the file to all supported decoders


# Developers

The framework wrapper written in bash keeping KIS(S) in mind.

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

* Main file is .source  

# Radiotail Build Script

├── install.sh # Main script to build and install Radiotail
├── lists
│   ├── bin.list # Compiled binary list to populate ../radiotail/bin/ directory
│   └── repo.list # List of repositories and tarballs to fetch
├── radiotail # Scripts to be added in case gsm is supported by `apt`
│   ├── decoders
│   │   ├── example
│   │   └── gsm
│   └── demodulators
│       └── gsm
├── README.md # This file
└── scripts
    ├── clean.sh # Cleaning script for recompilation - run from the main directory
    ├── compileAndInstall.sh # "Generic" compile and install script
    └── compile.sh # "Generic" compile script

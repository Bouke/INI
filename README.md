# Swift INI Parser

[![Build Status](https://travis-ci.com/Bouke/INI.svg?branch=master)](https://travis-ci.com/Bouke/INI)

## Usage

    // INI file looking like this;
    // [Header]
    // Key=Value

    let config = try parseINI(filename: "config.ini")
    print(config["Header"]?["Key"]) // prints Optional("Value")

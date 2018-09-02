# Swift INI Parser

[![Build Status](https://travis-ci.com/Bouke/INI.svg?branch=master)](https://travis-ci.com/Bouke/INI)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=Bouke_INI&metric=alert_status)](https://sonarcloud.io/dashboard?id=Bouke_INI)

## Usage

INI file looking like this:

```ini
[Header]
Key=Value
; some comment
```

Parse it like this:

```swift
let config = try parseINI(filename: "config.ini")
print(config["Header"]?["Key"]) // prints Optional("Value")
```

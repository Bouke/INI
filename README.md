# Swift INI Parser

## Usage

    // INI file looking like this;
    // [Header]
    // Key=Value

    let config = try parseINI(filename: "config.ini")
    print(config["Header"]?["Key"]) // prints Optional("Value")

import Foundation

public struct Config {
    public let sections: [Section]

    public subscript(key: String) -> Section? {
        return sections.filter { $0.name == key }.first
    }
}

public struct Section {
    public let name: String
    public let settings: [String: String]

    init(name: String, settings: [String: String]) {
        self.name = name
        self.settings = settings
    }

    public subscript(key: String) -> String? {
        return settings[key]
    }

    public func bool(_ key: String) -> Bool {
        return ["1", "true", "yes"].contains(settings[key] ?? "")
    }
}

func scanSection(_ scanner: Scanner) throws -> Section {
    scanner.charactersToBeSkipped = .whitespacesAndNewlines
    guard scanner.scanString("[", into: nil) else { throw ScanError.NoMatch }
    guard let name = scanner.scanUpTo("]") else { throw ParseError.InvalidSyntax(scanner.position) }
    scanner.scanString("]", into: nil)
    var settings = [String: String]()
    while true {
        if var key = scanner.scanCharacters(from: .alphanumerics) {
            key += scanner.scanUpTo("=") ?? ""
            guard scanner.scanString("=", into: nil) else { throw ParseError.InvalidSyntax(scanner.position) }
            scanner.scanString(" ", into: nil)
            guard let value = scanner.scanUpToCharacters(from: .newlines) else { throw ParseError.InvalidSyntax(scanner.position) }
            settings[key] = value
            continue
        }
        do {
            try scanNote(scanner)
            continue
        } catch ScanError.NoMatch { }
        break
    }
    return Section(name: name, settings: settings)
}

func scanNote(_ scanner: Scanner) throws {
    guard scanner.scanString(";", into: nil) else { throw ScanError.NoMatch }
    scanner.scanUpToCharacters(from: .newlines, into: nil)
}

public func parseINI(filename: String) throws -> Config {
    let input = try String(contentsOfFile: filename)
    return try parseINI(string: input)
}

public func parseINI(string: String) throws -> Config {
    let scanner = Scanner(string: string)
    var sections = [Section]()
    while !scanner.isAtEnd {
        do {
            sections.append(try scanSection(scanner))
            continue
        } catch ScanError.NoMatch { }
        do {
            try scanNote(scanner)
            continue
        } catch ScanError.NoMatch { }
        throw ParseError.UnsupportedToken(scanner.position)
    }
    return Config(sections: sections)
}

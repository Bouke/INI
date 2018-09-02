import Foundation

enum ScanError: Error {
    case noMatch
}
enum ParseError: Error {
    case invalidSyntax(Scanner.Position)
    case unsupportedToken(Scanner.Position)
}

extension ParseError: CustomStringConvertible {
    var description: String {
        switch self {
        case let .invalidSyntax(_, row, pos): return "Invalid syntax at row \(row), position \(pos)"
        case let .unsupportedToken(_, row, pos): return "Unsupported token at row \(row), position \(pos)"
        }
    }
}

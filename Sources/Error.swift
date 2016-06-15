import Foundation

enum ScanError: ErrorProtocol {
    case NoMatch
}
enum ParseError: ErrorProtocol {
    case InvalidSyntax(Scanner.Position)
    case UnsupportedToken(Scanner.Position)
}

extension ParseError: CustomStringConvertible {
    var description: String {
        switch self {
        case let .InvalidSyntax(_, row, pos): return "Invalid syntax at row \(row), position \(pos)"
        case let .UnsupportedToken(_, row, pos): return "Unsupported token at row \(row), position \(pos)"
        }
    }
}

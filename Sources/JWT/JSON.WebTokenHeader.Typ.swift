public import JSON

extension JSON.WebTokenHeader {
    @frozen public enum Typ: String, Sendable, JSONEncodable, JSONDecodable {
        case JWT
    }
}

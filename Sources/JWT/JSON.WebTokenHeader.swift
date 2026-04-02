public import JSON
public import Base64

extension JSON {
    @frozen public struct WebTokenHeader: Equatable, Sendable {
        public let alg: Alg
        public let typ: Typ

        @inlinable public init(alg: Alg, typ: Typ = .JWT) {
            self.alg = alg
            self.typ = typ
        }
    }
}
extension JSON.WebTokenHeader {
    @frozen public enum CodingKey: String, Sendable {
        case alg
        case typ
    }
}
extension JSON.WebTokenHeader: JSONObjectEncodable {
    @inlinable public func encode(to json: inout JSON.ObjectEncoder<CodingKey>) {
        json[.alg] = self.alg
        json[.typ] = self.typ
    }
}
extension JSON.WebTokenHeader: JSONObjectDecodable {
    @inlinable public init(json: JSON.ObjectDecoder<CodingKey>) throws {
        self.init(alg: try json[.alg].decode(), typ: try json[.typ].decode())
    }
}
extension JSON.WebTokenHeader {
    @inlinable public func sign(
        encoding payload: some JSONEncodable,
        by signature: (_ affadavit: String) throws -> some Sequence<UInt8>
    ) rethrows -> String {
        let payload: JSON = .encode(payload)
        return try self.sign(payload: payload.utf8, by: signature)
    }

    /// This is currently `@inlinable` because the closure return type is generic, in order to
    /// account for ``Data`` without linking Foundation.
    @inlinable public func sign(
        payload: ArraySlice<UInt8>,
        by signature: (_ affadavit: String) throws -> some Sequence<UInt8>
    ) rethrows -> String {
        let header: JSON = .encode(self)
        var token: String = Base64.encode(
            header.utf8,
            padding: false,
            with: Base64.SafeDigits.self
        )

        token.append(".")
        token += Base64.encode(
            payload,
            padding: false,
            with: Base64.SafeDigits.self
        )

        let signature: String = Base64.encode(
            try signature(token),
            padding: false,
            with: Base64.SafeDigits.self
        )

        token.append(".")
        token += signature

        return token
    }
}

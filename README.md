<div align="center">

🎫 &nbsp; **swift-jwt** &nbsp; 🎫

pure swift jwt types with bring-your-own-crypto (byoc)

[documentation and api reference](https://swiftinit.org/docs/swift-jwt/jwt)

</div>


## Requirements

The swift-jwt library requires Swift 6.2 or later.

<!-- DO NOT EDIT BELOW! AUTOSYNC CONTENT [STATUS TABLE] -->
| Platform | Status |
| -------- | ------|
<!-- DO NOT EDIT ABOVE! AUTOSYNC CONTENT [STATUS TABLE] -->

[Check deployment minimums](https://swiftinit.org/docs/swift-jwt#ss:platform-requirements)


## Getting started

You can use swift-jwt with any cryptography library you like! One such library is [swift-cryptography](https://github.com/rarestype/swift-cryptography). If you do choose to use swift-cryptography, here’s how you would sign `some JSONEncodable` payload, using that library’s `RSA.PrivateKey` type:

```swift
import Cryptography
import JSON

extension RSA.PrivateKey {
    func jwt(signing claims: some JSONEncodable) throws -> String {
        let header: JSON.WebTokenHeader = .init(alg: .rs256)
        return try header.sign(encoding: claims) {
            try self.sign(hashing: $0, padding: .pkcs1_legacy, algorithm: .sha256)
        }
    }
}
```

But really, you could use any cryptography library you like, as long as it can sign a `String`.

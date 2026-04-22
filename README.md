<div align="center">

🎫 &nbsp; **swift-jwt** &nbsp; 🎫

pure swift jwt types with bring-your-own-crypto (byoc)

[documentation and api reference](https://swiftinit.org/docs/swift-jwt/jwt)

</div>


## Requirements

The swift-jwt library requires Swift 6.2 or later.

<!-- DO NOT EDIT BELOW! AUTOSYNC CONTENT [STATUS TABLE] -->
| Platform | Status |
| -------- | ------ |
| 💬 Documentation | [![Status](https://raw.githubusercontent.com/rarestype/swift-jwt/refs/badges/ci/Documentation/_all/status.svg)](https://github.com/rarestype/swift-jwt/actions/workflows/Documentation.yml) |
| 🐧 Linux | [![Status](https://raw.githubusercontent.com/rarestype/swift-jwt/refs/badges/ci/Tests/Linux/status.svg)](https://github.com/rarestype/swift-jwt/actions/workflows/Tests.yml) |
| 🍏 Darwin | [![Status](https://raw.githubusercontent.com/rarestype/swift-jwt/refs/badges/ci/Tests/macOS/status.svg)](https://github.com/rarestype/swift-jwt/actions/workflows/Tests.yml) |
| 🍏 Darwin (iOS) | [![Status](https://raw.githubusercontent.com/rarestype/swift-jwt/refs/badges/ci/Tests/iOS/status.svg)](https://github.com/rarestype/swift-jwt/actions/workflows/Tests.yml) |
| 🍏 Darwin (tvOS) | [![Status](https://raw.githubusercontent.com/rarestype/swift-jwt/refs/badges/ci/Tests/tvOS/status.svg)](https://github.com/rarestype/swift-jwt/actions/workflows/Tests.yml) |
| 🍏 Darwin (visionOS) | [![Status](https://raw.githubusercontent.com/rarestype/swift-jwt/refs/badges/ci/Tests/visionOS/status.svg)](https://github.com/rarestype/swift-jwt/actions/workflows/Tests.yml) |
| 🍏 Darwin (watchOS) | [![Status](https://raw.githubusercontent.com/rarestype/swift-jwt/refs/badges/ci/Tests/watchOS/status.svg)](https://github.com/rarestype/swift-jwt/actions/workflows/Tests.yml) |
<!-- DO NOT EDIT ABOVE! AUTOSYNC CONTENT [STATUS TABLE] -->

[Check deployment minimums](https://swiftinit.org/docs/swift-jwt#ss:platform-requirements)


## Getting started

You can use swift-jwt with any cryptography library you like! One such library is [swift-cryptography](https://github.com/rarestype/swift-cryptography). If you do choose to use swift-cryptography, here’s how you would sign `some JSONEncodable` payload, using that library’s [`RSA.PrivateKey`](https://swiftinit.org/docs/swift-cryptography/cryptography/rsa/privatekey) type:

```swift
import Cryptography
import JSON
import JWT

extension RSA.PrivateKey {
    func jwt(signing claims: some JSONEncodable) throws -> String {
        let header: JSON.WebTokenHeader = .init(alg: .rs256)
        return try header.sign(encoding: claims) {
            try self.sign(hashing: $0[...], padding: .pkcs1_legacy, algorithm: .sha256)
        }
    }
}
```

But really, you could use any cryptography library you like, as long as it can sign a `String`.

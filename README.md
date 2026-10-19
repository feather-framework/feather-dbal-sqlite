# FeatherDBALSQLite

FeatherDBALSQLite provides SQLite support for
[Feather DBAL](https://github.com/feather-framework/feather-dbal) by combining
the SQLite database driver and SQL dialect. It contains no application
runtime and does not change the driver-independent DBAL API.

[![Release: 1.0.0-alpha.1](https://img.shields.io/badge/Release-1.0.0--alpha.1-F05138)](https://github.com/feather-framework/feather-dbal-sqlite/releases/tag/1.0.0-alpha.1)
![Swift 6.3+](https://img.shields.io/badge/Swift-6.3%2B-F05138)

This is an alpha release; APIs may change before the stable `1.0.0` release.

## Requirements

- Swift 6.3 or later
- macOS 15+, iOS 18+, tvOS 18+, watchOS 11+, or visionOS 2+
- Linux

## Installation

Add the package to your dependencies:

```swift
.package(url: "https://github.com/feather-framework/feather-dbal-sqlite", exact: "1.0.0-alpha.1"),
```

Then add the product to your target:

```swift
.product(name: "FeatherDBALSQLite", package: "feather-dbal-sqlite"),
```

The package pins Feather DBAL and the SQLite database and SQL packages to
their compatible published releases.

## Usage

Import the package to make the SQLite platform implementation available:

```swift
import FeatherDBAL
import FeatherDBALSQLite

let platform = SQLiteDatabasePlatform()
```

Use `platform` with the DBAL access layer and a SQLite database client.

## Development

```sh
swift build
swift test
swift format lint --strict --recursive Sources Tests
```

Pull requests run soundness checks and tests on Linux with Swift 6.3 and 6.4.
Tagged releases and manual workflow runs publish DocC documentation to GitHub
Pages.

## License

FeatherDBALSQLite is distributed under the MIT License. See [LICENSE](LICENSE).

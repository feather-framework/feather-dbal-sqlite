// swift-tools-version:6.3
import PackageDescription

let swiftSettings: [SwiftSetting] = [
    .swiftLanguageMode(.v6),
    .strictMemorySafety(),
    .treatAllWarnings(as: .error),
    .enableUpcomingFeature("InternalImportsByDefault"),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("MemberImportVisibility"),
    .enableUpcomingFeature("InferIsolatedConformances"),
    .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
    .enableUpcomingFeature("ImmutableWeakCaptures"),
    .enableUpcomingFeature("StrictConcurrency"),
    .enableExperimentalFeature("SuppressedAssociatedTypes"),
    .enableExperimentalFeature("LifetimeDependence"),
    .enableExperimentalFeature("Lifetimes"),
]

let package = Package(
    name: "feather-dbal-sqlite",
    platforms: [
        .macOS(.v15),
        .iOS(.v18),
        .tvOS(.v18),
        .watchOS(.v11),
        .visionOS(.v2),
    ],
    products: [
        .library(name: "FeatherDBALSQLite", targets: ["FeatherDBALSQLite"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/feather-framework/feather-dbal",
            exact: "1.0.0-alpha.1"
        ),
        .package(
            url: "https://github.com/feather-framework/feather-database-sqlite",
            exact: "1.0.0-rc.3"
        ),
        .package(
            url: "https://github.com/feather-framework/feather-sql",
            exact: "1.0.0-alpha.1"
        ),
        .package(
            url: "https://github.com/feather-framework/feather-sql-sqlite",
            exact: "1.0.0-alpha.1"
        ),
    ],
    targets: [
        .target(
            name: "FeatherDBALSQLite",
            dependencies: [
                .product(name: "FeatherDBAL", package: "feather-dbal"),
                .product(name: "FeatherDatabaseSQLite", package: "feather-database-sqlite"),
                .product(name: "FeatherSQLSQLite", package: "feather-sql-sqlite"),
            ],
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "FeatherDBALSQLiteTests",
            dependencies: [
                .target(name: "FeatherDBALSQLite"),
                .product(name: "FeatherDBAL", package: "feather-dbal"),
                .product(name: "FeatherSQL", package: "feather-sql"),
                .product(name: "FeatherSQLSQLite", package: "feather-sql-sqlite"),
            ],
            swiftSettings: swiftSettings
        ),
    ]
)

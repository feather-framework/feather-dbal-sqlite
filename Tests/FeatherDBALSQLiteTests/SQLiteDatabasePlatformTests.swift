import FeatherDBAL
import FeatherDBALSQLite
import FeatherSQL
import Testing

@Suite("SQLite DBAL platform")
struct SQLiteDatabasePlatformTests {

  @Test("maps every schema column type to SQLite SQL types")
  func mapsColumnTypes() {
    let platform = SQLiteDatabasePlatform()
    let mappings: [(DatabaseTableColumnTypeSchema, String)] = [
      (.uuid, "TEXT"),
      (.string, "TEXT"),
      (.text, "TEXT"),
      (.int, "INTEGER"),
      (.int32, "INTEGER"),
      (.integer, "INTEGER"),
      (.double, "REAL"),
      (.float, "REAL"),
      (.boolean, "INTEGER"),
      (.timestamp, "TEXT"),
      (.datetime, "TEXT"),
      (.time, "TEXT"),
      (.data, "BLOB"),
      (.blob, "BLOB"),
      (.json, "TEXT"),
    ]

    for (columnType, expectedSQLType) in mappings {
      #expect(platform.sqlBuilder.build(platform.sqlType(for: columnType)).sql == expectedSQLType)
    }
  }

  @Test("exposes capabilities and SQLite LIKE/GLOB search comparisons")
  func capabilitiesAndTextSearch() {
    let platform = SQLiteDatabasePlatform()
    #expect(
      platform.capabilities
        == DatabasePlatformCapabilities(
          supportsCreateIndexIfNotExists: true,
          supportsTransactionalDDL: true,
          supportsTruncateTable: false
        ))

    for (sensitivity, expectedOperator, expectedPattern) in [
      (DatabaseQueryTextSearchCaseSensitivity.sensitive, " GLOB ", "*abc*"),
      (DatabaseQueryTextSearchCaseSensitivity.insensitive, " LIKE ", "%abc%"),
    ] {
      let result = platform.sqlBuilder.build(
        platform.textSearchExpression(
          columnName: "name",
          searchText: "abc",
          matching: .contains,
          caseSensitivity: sensitivity
        ))
      #expect(result.sql.contains(expectedOperator))
      #expect(result.bindings.first as? String == expectedPattern)
    }
  }
}

public import FeatherDBAL
public import FeatherSQL
import FeatherSQLSQLite

public struct SQLiteDatabasePlatform: DatabasePlatform {
  public let sqlBuilder: SQLBuilder
  public let capabilities = DatabasePlatformCapabilities(
    supportsCreateIndexIfNotExists: true,
    supportsTransactionalDDL: true,
    supportsTruncateTable: false
  )

  public init() {
    self.sqlBuilder = SQLBuilder(dialect: SQLiteDialect())
  }

  public func sqlType(
    for columnType: DatabaseTableColumnTypeSchema
  ) -> SQLDataType {
    let type: String
    switch columnType {
    case .uuid, .string, .text, .timestamp, .datetime, .time, .json: type = "TEXT"
    case .int, .int32, .integer, .boolean: type = "INTEGER"
    case .double, .float: type = "REAL"
    case .data, .blob: type = "BLOB"
    }
    return .custom(SQLRaw(type))
  }

  public func textSearchExpression(
    columnName: String,
    searchText: String,
    matching: DatabaseQueryTextSearchMatch,
    caseSensitivity: DatabaseQueryTextSearchCaseSensitivity
  ) -> any SQLExpression {
    DatabaseQueryTextSearchExpression(
      columnName: columnName,
      searchText: searchText,
      matching: matching,
      comparison: caseSensitivity == .sensitive ? .glob : .like
    )
  }
}

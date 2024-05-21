import 'package:mvs_database/mvs_database.dart';
import 'package:drift/drift.dart';
import 'package:mvs_database/src/data/data_source/database/table/news_database_table.dart';

part '../../../../generated/src/data/data_source/database/mvs_database.g.dart';

@DriftDatabase(
  tables: [
    MVSFactDatabaseTable,
    NewsDatabaseTable,
  ],
)
class MVSDatabase extends _$MVSDatabase {
  MVSDatabase({
    required String databaseName,
  }) : super(
          MVSDatabaseOpener.openDatabase(
            name: databaseName,
          ),
        );

  @override
  int get schemaVersion => 1;
}

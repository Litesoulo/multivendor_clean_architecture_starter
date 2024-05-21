import 'package:mvs_database/mvs_database.dart';
import 'package:drift/drift.dart';

class NewsDAO implements IMVSDAO<NewsDatabaseTableData> {
  const NewsDAO({
    required this.database,
  });

  final MVSDatabase database;

  @override
  Future<List<NewsDatabaseTableData>> get() => database.select(database.newsDatabaseTable).get();

  @override
  Stream<List<NewsDatabaseTableData>> watch() => database.select(database.newsDatabaseTable).watch();

  @override
  Future<int> insert({
    required UpdateCompanion<NewsDatabaseTableData> companion,
  }) =>
      database.into(database.newsDatabaseTable).insert(companion);

  @override
  Future<bool> update({
    required UpdateCompanion<NewsDatabaseTableData> companion,
  }) =>
      database.update(database.newsDatabaseTable).replace(companion);

  @override
  Future<int> delete({
    required UpdateCompanion<NewsDatabaseTableData> companion,
  }) =>
      database.delete(database.newsDatabaseTable).delete(companion);
}

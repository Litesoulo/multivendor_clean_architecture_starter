import 'package:drift/drift.dart';

class NewsDatabaseTable extends Table {
  const NewsDatabaseTable();

  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();
  TextColumn get titleTm => text()();
  TextColumn get description => text()();
  TextColumn get descriptionTm => text()();

  DateTimeColumn get date => dateTime()();

  IntColumn get viewsCount => integer()();
  IntColumn get likesCount => integer()();

  IntColumn get priority => integer()();

  // BoolColumn get likedByMe => boolean()();
}

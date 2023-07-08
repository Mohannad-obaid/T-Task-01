// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

part 'dbController.g.dart';

// The UserTable table.
class UserTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().nullable()();
  TextColumn get lastName => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get password => text().nullable()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}


@DriftDatabase(tables: [UserTable])
class MyDatabase extends _$MyDatabase {
  static MyDatabase _instance = MyDatabase();

  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // We create a static getter for the database instance.
  static MyDatabase get instance {
    return _instance;
  }



  // We create a private variable to store the database instance.


  // we add the getAllUsers method
  Future<List<UserTableData>> getAllUsers() => select(userTable).get();

  // we add the insertUser method
  Future insertUser(UserTableCompanion user) => into(userTable).insert(user);

  // we add the updateUser method
  Future updateUser(UserTableData user) => update(userTable).replace(user);

  // we add the deleteUser method
  Future deleteUser(UserTableData user) => delete(userTable).delete(user);

  // we add the deleteAllUsers method
  Future deleteAllUsers() => delete(userTable).go();

  // we add the getUserById method
  Future<UserTableData> getUserById(int id) {
    return (select(userTable)..where((u) => u.id.equals(id))).getSingle();
  }

  // we add the getUserByEmail method
  Future<List<UserTableData>> getUserByEmail(String email) {
    return (select(userTable)..where((u) => u.email.equals(email))).get();
  }

  // we add the getUserByEmailAndPassword method
  Future<UserTableData?> getUserByEmailAndPassword(String email, String password) {
    return (select(userTable)..where((u) => u.email.equals(email) & u.password.equals(password))).getSingleOrNull();
  }

}


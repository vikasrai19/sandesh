import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sandesh/models/UserModel.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseController extends GetxController {
  Future<void> userDatabase;
  Future<void> messageTable;
  var sqlDatabase;

  @override
  void onInit() {
    createDatabase();
    super.onInit();
  }

  // Create a database
  createDatabase() async {
    String databasePath = await getDatabasesPath();
    String dbPath = join(databasePath, "sandesh.db");

    sqlDatabase = await openDatabase(dbPath, version: 1, onCreate: populateDB);
  }

  // Creating tables in the sandesh database
  void populateDB(Database sqlDatabase, int version) async {
    // Table to store the user values
    await sqlDatabase.execute(
      "CREATE TABLE User(userUid TEXT NOT NULL, name TEXT, phoneNo TEXT NOT NULL, dob TEXT, profileImg TEXT)",
    );

    // Table to store messages for the user
    await sqlDatabase.execute(
      "CREATE TABLE message(sender TEXT NOT NULL, msg TEXT NOT NULL, msgType TEXT, isMessageDel INTEGER, isMessageRead INTEGER, messageSentTime TEXT, messageDelTime TEXT, messageReadTime TEXT)",
    );
  }

  //  Method to add user data into the local database
  addUserData(UserModel user) async {
    try {
      List<Map> val = await getUserData();
      if (val.length == 0) {
        var result = await sqlDatabase.rawInsert(
          "INSERT INTO User(userUid, name, phoneNo, dob, profileImg) "
          "VALUES('${user.userUid}', '${user.name}', '${user.phoneNo}', '${user.dob}', '${user.profileImg}');",
        );
        print("[USER LIST IN DATABASE]" + getUserData().toString());
        return result;
      }
    } catch (e) {
      print("[EXCEPTION] " + e.toString());
    }
  }

  // Method to get user data from the database
  Future<List> getUserData() async {
    try {
      List<Map> result = await sqlDatabase.rawQuery('SELECT * FROM User');
      print("[DATABASE VALUE]" + result.toString());
      print("[DATABASE VALUE LENGTH] " + result.length.toString());
      return result;
    } catch (e) {
      print("[EXCEPTION] " + e.toString());
    }
  }

  // Delete records from the table
  deleteUserData({String userUid}) async {
    try {
      return await sqlDatabase
          .rawQuery("DELETE FROM User WHERE userUid = '$userUid'");
    } catch (e) {
      print("[EXCEPTION] " + e.toString());
    }
  }
}

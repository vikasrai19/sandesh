import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sandesh/models/ContactModel.dart';
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

    // Table to store contacts from mobile contacts in sqflite database
    await sqlDatabase.execute(
        "CREATE TABLE contacts(name TEXT NOT NULL, phoneNo TEXT PRIMARY KEY)");
  }

  //  Method to add user data into the local database
  addUserData(UserModel user) async {
    print("[ADD USER DATA] called");
    try {
      List<UserModel> val = await getUserData();
      print("[VAL] from adduserData" + val.toString());
      if (val.length == 0) {
        var result = await sqlDatabase.insert('User', user.toJson());
        print("[ADDUSERDATA]: " + result.toString());
        print("[USER LIST IN DATABASE]" + getUserData().toString());
        return result;
      }
    } catch (e) {
      print("[EXCEPTION] " + e.toString());
    }
  }

  // Method to get user data from the database
  Future<List> getUserData() async {
    print("Called getUserData ");
    try {
      List res = await sqlDatabase.query('User');
      return res;
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

  // Get contacts data from sqflite database
  Future<List> getContactList() async {
    try {
      // return await sqlDatabase.rawQuery("SELECT * from contacts");
      var res = await sqlDatabase.query('contacts');
      print("[FROM GETCONTACTLIST FUNCTION]");
      print("[RES]: " + res.toString());
      List<ContactModel> contacts = res.isNotEpty
          ? res.map((contact) => ContactModel.fromJson(contact)).toList()
          : [];
      return contacts;
    } catch (e) {
      print("[EXCEPTION]: " + e.toString());
    }
  }

  // Add new contacts to localdatabase
  addContactsToDB() async {
    try {
      Future<List<Map>> ct = getContactList();
      List<Map> ctList = await ct;
      if (ctList.length == 0) {
        // TODO: No data is present. So add all the values into the table
      } else {
        // TODO: Some data is present. Compare and add data which are not present
      }
    } catch (e) {
      print("[EXCEPTION]: " + e.toString());
    }
  }

  // Delete all the contacts from db
  deleteContactsFromDB() async {
    try {
      var res = await sqlDatabase.rawQuery("DELETE FROM contacts");
    } catch (e) {
      print("[EXCEPTION] " + e.toString());
    }
  }
}

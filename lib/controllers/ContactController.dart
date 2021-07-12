import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sandesh/controllers/LocalDatabaseController.dart';
import 'package:sandesh/helper/FirebaseDatabase.dart';

class ContactController extends GetxController {
  Iterable<Contact> contacts = [];
  QuerySnapshot firebaseContacts;
  TextEditingController contactSearchController = new TextEditingController();
  List<Map<String, dynamic>> userFriends;
  var contactList = <Contact>[].obs;
  var searchList = <Contact>[].obs;

  // Getting the contact list from the user's phone
  getContacts() async {
    LocalDatabaseController dbController = Get.find();
    contacts = await ContactsService.getContacts(withThumbnails: false);
    print("[CONTACTS]" + contacts.toString());
  }

  // Getting the list of all the users from the sandesh app
  getContactsFromFirebase() async {
    await FirebaseDatabase().getUsers().then((value) {
      print("[VALUE]: " + value.toString());
      firebaseContacts = value;
    });
  }

  // Comparing the contacts and adding it into the local database
  checkContacts() {
    print("FROM CHECKCONTACTS METHOD");
    if (firebaseContacts != null && contacts != null) {
      // print("[FIREBASECONTACTS] " + firebaseContacts.docs[0].get('phoneNo').toString());
      // print("[CONTACTS] " + contacts.elementAt(0).toString());
      // print("[CONTACTS LENGTH] " + contacts.length.toString());
      // print("SUCCESSFULLY GOT THE VALUES");
      //  Todo: compare and add contacts into the database
      for (var contact in contacts) {
        if (contact.displayName != null && contact.phones.length > 0) {
          var pNo = contact.phones.elementAt(0).value.replaceAll("+91", "");
          for (int i = 0; i < firebaseContacts.docs.length; i++) {
            if (firebaseContacts.docs[i].get('phoneNo') == pNo) {
              // print("Account found");
              // print(firebaseContacts.docs[i].get('phoneNo'));
              if (!contactList.contains(contact)) {
                contactList.add(contact);
              }
            }
          }
        }
      }
    } else {
      print("NULL VALUE EITHER IN FIREBASECONTACTS OR CONTACTS");
      Future.delayed(Duration(seconds: 2), () {
        checkContacts();
      });
    }
  }

  // Search for contacts and display the users
  searchContacts(String val) {
    for (var contact in contacts) {
      if (contact.displayName.contains(val)) {
        searchList.add(contact);
      }
    }
  }

  // Clear the results from the search list
  clearSearch() {
    searchList.clear();
  }

  // Initializing some data on the startup
  @override
  void onInit() {
    askPermission();
    super.onInit();
  }

  // Asking permission to read contacts
  Future<void> askPermission() async {
    PermissionStatus permissionStatus = await getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      print("Permission Granted");
      getContacts();
      getContactsFromFirebase();
      checkContacts();
    } else if (permissionStatus != PermissionStatus.granted) {
      handleInvalidPermission(permissionStatus);
    }
  }

  Future<PermissionStatus> getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.denied) {
      Map<Permission, PermissionStatus> permissionStatus = await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  // Handling invalid permissions
  void handleInvalidPermission(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
        code: "PERMISSION DENIED",
        message: "Access denied",
        details: null,
      );
    }
  }

  Widget searchChild(BuildContext context) {
    // return contactSearchController.text.length == 0 ? Container() : Container();
    return ListView.builder(
      itemCount: contactSearchController.text.length == 0 ? contactList.length : searchList.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contactSearchController.text.length == 0
                    ? contactList[index].displayName
                    : searchList[index].displayName,
              ),
              Text(
                contactSearchController.text.length == 0
                    ? contactList[index].phones.elementAt(0).value
                    : searchList[index].phones.elementAt(0).value,
              ),
            ],
          ),
        );
      },
    );
  }
}

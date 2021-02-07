import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sandesh/Helper/Database.dart';

class ContactListController extends GetxController {
  List<Map<String, dynamic>> contactList = [];
  bool isLoadedFinished;
  Iterable<Contact> contacts;
  QuerySnapshot userSnapshot;
  bool isContactLoaded = false;

  @override
  onInit() {
    print("From onInit function");
    getUsersList();
    getContactPermission();
    super.onInit();
  }

  // Get contat list from phones contact
  Future<void> getContactPermission() async {
    PermissionStatus permissionStatus = await getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      print("Permission granted");
      getContacts();
    }
  }

  // Check and get for contacts permission
  Future<PermissionStatus> getPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  Future<void> getContacts() async {
    contacts = await ContactsService.getContacts();
    print("contacts value from getContacts function ${contacts}");
    checkPhoneNumber();
  }

  // getting users list from firebase
  getUsersList() {
    DatabaseMethods().getUsersList().then((value) {
      print("Successful");
      userSnapshot = value;
      print(userSnapshot.docs.length.toString());
      print(userSnapshot.docs[0].get('phoneNo') + " value from firestore");
      update();
    });
  }

  // Checking and getting the required phone number
  checkPhoneNumber() {
    String numb;
    if (userSnapshot != null &&
        contacts != null &&
        userSnapshot.docs.length != 0) {
      for (int i = 0; i < contacts.length; i++) {
        Contact contact = contacts?.elementAt(i);
        if (contact.phones.length != 0) {
          if (contact.phones.elementAt(0).value.length == 10) {
            numb = "+91" + contact.phones.elementAt(0).value.trim();
          } else {
            numb = contact.phones.elementAt(0).value.trim();
          }
          for (int j = 0; j < userSnapshot.docs.length; j++) {
            if (userSnapshot.docs[j].get('phoneNo') == numb) {
              contactList.add({"name": contact.displayName, "phoneNo": numb});
              isContactLoaded = true;
              update();
            }
          }
        }
      }
    }
    print("Contact List value ${contactList}");
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sandesh/Helper/Database.dart';
import 'package:sandesh/Helper/HelperFunctions.dart';
import 'package:sandesh/Helper/ProvidersList.dart';
import 'package:sandesh/Pages/MessagePage.dart';
import 'package:sandesh/Pages/ProfilePage.dart';
import 'package:sandesh/Pages/StatusPage.dart';

class HomePage extends StatefulWidget {
  final String userUid;
  HomePage({this.userUid});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Iterable<Contact> _contacts;
  Iterable<Item> phoneNo = [];
  QuerySnapshot userSnapshot;
  QuerySnapshot chatRoomSnapshot;
  String numb;
  List<Map<String, dynamic>> phoneList = [];
  List chatRoomList = [];
  bool isLoaded = false;
  Stream<QuerySnapshot> lastMessageSnapshot;

  @override
  void initState() {
    storeValues(context);
    getPermission();
    getUsersList();
    super.initState();
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
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

  getPermission() async {
    final PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus == PermissionStatus.granted) {
      print("Permission granted");
      getContacts();
    }
  }

  getFirebaseChatRooms({@required String phoneNo}) {
    DatabaseMethods().getChatRooms(phoneNo: phoneNo).then((value) {
      setState(() {
        chatRoomSnapshot = value;
      });
      print("From getFirebaseChatRoom function.");
      if (chatRoomSnapshot.docs.length != 0) {
        for (int i = 0; i < chatRoomSnapshot.docs.length; i++) {
          chatRoomList.add(chatRoomSnapshot.docs[i].get('name'));
        }
      }
      print("ChatRoomList Value " + chatRoomList.toString());
    });
  }

  getUsersList() {
    DatabaseMethods().getUsersList().then((value) {
      print("Successful");
      setState(() {
        userSnapshot = value;
      });
      print(userSnapshot.docs.length.toString());
      print(userSnapshot.docs[0].get('phoneNo') + " value from firestore");
    });
  }

  checkPhoneNumber() {
    print("Check PhoneNumber Called");
    phoneList = [];
    if (userSnapshot != null &&
        context.read(contactListProvider).contacts != null &&
        userSnapshot.docs.length != 0) {
      print("Contact Length " +
          context.read(contactListProvider).contacts.length.toString());
      print("userSnapshot length " + userSnapshot.docs.length.toString());
      for (int i = 0;
          i < context.read(contactListProvider).contacts.length;
          i++) {
        Contact contact =
            context.read(contactListProvider).contacts?.elementAt(i);
        if (contact.phones.length != 0) {
          if (contact.phones.elementAt(0).value.length == 10) {
            numb = "+91" + contact.phones.elementAt(0).value.trim();
          } else {
            numb = contact.phones.elementAt(0).value.trim();
          }
          for (int j = 0; j < userSnapshot.docs.length; j++) {
            if (userSnapshot.docs[j].get('phoneNo') == numb) {
              phoneList.add({"name": contact.displayName, "phoneNo": numb});
            }
          }
        }
      }
      print(phoneList.toString());
      context
          .read(contactListProvider)
          .setValue(phoneList: phoneList, isLoaded: true);
    }
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    context.read(contactListProvider).contacts = contacts;
    if (userSnapshot != null &&
        context.read(contactListProvider).contacts != null) {
      checkPhoneNumber();
    }
  }

  Future<bool> storeValues(BuildContext context) async {
    HelperFunction.getUserName().then((value) {
      print(value.toString() + " Got value now");
      context.read(userProvider).userName = value;
    });
    HelperFunction.getUserUid().then((value) {
      context.read(userProvider).uid = value;
    });
    HelperFunction.getUserPhoneNumber().then((value) {
      context.read(userProvider).phoneNo = value;
    });
    print("Got values from shared preferences");
    getFirebaseChatRooms(phoneNo: context.read(userProvider).phoneNo);
    return true;
  }

  List<Widget> _children({String phone}) => [
        MessagePage(
          phoneNumber: phone,
        ),
        StatusPage(),
        ProfilePage()
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, watch, child) {
        final indexValue = watch(homeScreenProvider);
        return _children(phone: context.read(userProvider).phoneNo.toString())[
            indexValue.currentIndex];
      }),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.camera,
                ),
                label: "Status"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "Profile")
          ],
          showUnselectedLabels: false,
          elevation: 5,
          iconSize: 30.0,
          onTap: (index) {
            context.read(homeScreenProvider).setCurrentIndexValue(index);
          },
          currentIndex: context.read(homeScreenProvider).currentIndex,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.5)),
    );
  }
}

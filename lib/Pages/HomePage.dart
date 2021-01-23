import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sandesh/Helper/ContactList.dart';
import 'package:sandesh/Helper/Database.dart';
import 'package:sandesh/Helper/HelperFunctions.dart';
import 'package:sandesh/Helper/User.dart';
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
  int _currentIndex = 0;
  String userUid;
  String userName;
  String phoneNumber;
  Iterable<Contact> _contacts;
  Iterable<Item> phoneNo = [];
  QuerySnapshot userSnapshot;
  QuerySnapshot chatRoomSnapshot;
  String numb;
  List<Map<String, dynamic>> phoneList = [];
  List chatRoomList = [];
  bool isLoaded = false;
  UserData user;
  Stream<QuerySnapshot> lastMessageSnapshot;

  @override
  void initState() {
    storeValues();
    getPermission();
    getUsersList();
    // getUsersList();
    // getContacts();
    // storeValues();
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
      // getUsersList();
      // checkPhoneNumber();
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
    });
  }

  getUsersList() {
    DatabaseMethods().getUsersList().then((value) {
      print("Successful");
      setState(() {
        userSnapshot = value;
      });
      // print(userSnapshot.docs[0].get('phoneNo') + " value from firestore");
    });
  }

  checkPhoneNumber() {
    if (userSnapshot != null &&
        _contacts != null &&
        userSnapshot.docs.length != 0) {
      print("Contact Length " + _contacts.length.toString());
      print("userSnapshot length " + userSnapshot.docs.length.toString());
      for (int i = 0; i < _contacts.length; i++) {
        Contact contact = _contacts?.elementAt(i);
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
      setState(() {
        isLoaded = true;
      });
    }
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
    phoneList = [];
    if (userSnapshot != null && _contacts != null) {
      checkPhoneNumber();
    }
  }

  Future<bool> storeValues() async {
    HelperFunction.getUserName().then((value) {
      print(value.toString() + " Got value now");
      print("USERNAME : " + userName.toString());
      setState(() {
        userName = value;
      });
      print("USERNAME : " + userName);
    });
    HelperFunction.getUserUid().then((value) {
      setState(() {
        userUid = value;
      });
      print("User uid from shared Preferences : " + userUid);
    });
    HelperFunction.getUserPhoneNumber().then((value) {
      setState(() {
        phoneNumber = value;
      });
      print(phoneNumber.toString());
    });
    print("Got values from shared preferences");
    getFirebaseChatRooms(phoneNo: phoneNumber);
    return true;
  }

  List<Widget> _children({String phoneNo}) => [
        MessagePage(
          phoneNumber: phoneNo,
        ),
        StatusPage(),
        ProfilePage()
      ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    user = Provider.of<UserData>(context);
    Future.delayed(Duration(seconds: 1), () {
      Provider.of<UserData>(context, listen: false).setValue(
          userUid: userUid,
          name: userName,
          phoneNumber: phoneNumber.toString(),
          chatRoomListData: chatRoomList);
      // Provider.of<ChatRoomList>(context, listen: false).setChatRoomList(chatRoomSnapshot: chatRoomSnapshot);
      Provider.of<ContactList>(context, listen: false)
          .setValue(phoneList: phoneList, isLoaded: isLoaded);
    });
    return Scaffold(
      body: _children(phoneNo: phoneNumber.toString())[_currentIndex],
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
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.5)),
    );
  }
}

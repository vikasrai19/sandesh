import 'package:flutter_riverpod/all.dart';
import 'package:sandesh/Helper/ContactList.dart';
import 'package:sandesh/Helper/DatabaseHelper.dart';
import 'package:sandesh/Helper/SnapshotProviders.dart';
import 'package:sandesh/Helper/User.dart';
import 'package:sandesh/Provider/HomeScreenProvider.dart';

final homeScreenProvider = ChangeNotifierProvider((ref) => HomeScreenManager());
final userProvider = ChangeNotifierProvider((ref) => UserData());
final contactListProvider = ChangeNotifierProvider((ref) => ContactList());
final snapshotProviders = ChangeNotifierProvider((ref) => SnapshotProviders());
final databaseProviders = ChangeNotifierProvider((ref) => DatabaseHelper());

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sandesh/controllers/AccountCreationController.dart';
import 'package:sandesh/widgets/AccountCreationBackground.dart';

class DetailsPage extends StatelessWidget {
  AccountCreationController accountController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AccountCreationBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: accountController.nameController,
              decoration: InputDecoration(
                hintText: "Enter Name",
                labelText: "Name",
                hintStyle: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 16.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              controller: accountController.dobController,
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  onPressed: () => accountController.selectDate(context),
                  icon: Icon(Icons.calendar_today_rounded),
                ),
                hintText: "Enter DOB [yyyy-mm-dd]",
                labelText: "DOB",
                hintStyle: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 16.0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () => accountController.storeUser(),
              child: Text("Finish"),
            ),
          ],
        ),
      ),
    );
  }
}

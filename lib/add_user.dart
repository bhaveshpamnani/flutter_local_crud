import 'package:flutter/material.dart';
import 'package:local_database/list_of_user.dart';
import 'package:local_database/mydatabase.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var phoneController = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
        actions: [
          InkWell(
            onTap: () {
              return _navigateToListOfUser();
            },
            child: Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text('List')),
            ),
          ),
        ],
      ),
      body: Form(
        key: _globalKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Enter Name'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: phoneController,
                decoration: InputDecoration(hintText: 'Enter Phone'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: ageController,
                decoration: InputDecoration(hintText: 'Enter Age'),
              ),
            ),
            InkWell(
              onTap : ()   async {
                  if (_globalKey.currentState!.validate()) {
                    await MyDatabase().insertRecordIntoTbl_User(
                        nameController.text.toString(),
                        phoneController.text.toString(),
                        ageController.text.toString());
                    _navigateToListOfUser();
                  }
                },
              child: Container(
                width: 60,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                    BorderRadius.circular(10)),
                child: Center(child: Text('Cancel')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToListOfUser() async {
    // Perform asynchronous operations here if needed

    // Navigate to ListOfUser
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ListOfUser();
    }));
  }
}

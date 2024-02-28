import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_database/mydatabase.dart';

import 'add_user.dart';

class ListOfUser extends StatefulWidget {
  const ListOfUser({super.key});

  @override
  State<ListOfUser> createState() => _ListOfUserState();
}

class _ListOfUserState extends State<ListOfUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login List"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                return _navigateToListOfUser();
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(Icons.add),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: MyDatabase().copyPasteAssetFileToRoot(),
          builder: (context, snapshot1) {
            if (snapshot1.hasData) {
              return FutureBuilder(
                future: MyDatabase().getUserListFromTbl_User(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        var newnameController = TextEditingController(
                            text: snapshot.data![index]['Name']);
                        var newageController = TextEditingController(
                            text: snapshot.data![index]['Age'].toString());
                        var newphoneController = TextEditingController(
                            text: snapshot.data![index]['Phone'].toString());
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            child: Card(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text(
                                        "Name : ${snapshot.data![index]['Name'].toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text(
                                        "Phone : ${snapshot.data![index]['Phone'].toString()}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text(
                                        "Age :  ${snapshot.data![index]['Age'].toString()}"),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: TextField(
                                                      controller:
                                                          newnameController,
                                                      decoration: InputDecoration(
                                                          hintText: 'Enter Name',labelText: 'Enter Name',),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: TextField(
                                                      controller:
                                                          newageController,
                                                      decoration: InputDecoration(
                                                          hintText: 'Enter Age',labelText: 'Enter Age',),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: TextField(
                                                      controller:
                                                          newphoneController,
                                                      decoration: InputDecoration(
                                                        hintText: 'Enter Phone',
                                                        labelText: 'Enter Phone',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      InkWell(
                                                        onTap:(){
                                                          MyDatabase().updateUser(snapshot.data![index]['UserId'],newnameController.text , newphoneController.text,newageController.text);
                                                          setState(() {});
                                                          Navigator.pop(context);
                                                        },
                                                        child: Container(
                                                          width: 60,
                                                          height: 40,
                                                          decoration: BoxDecoration(
                                                              color: Colors.blue,
                                                              borderRadius:
                                                              BorderRadius.circular(10)),
                                                          child: Center(child: Text('Edit'),),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap:(){
                                                          return Navigator.pop(context);
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
                                                  )
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(child: Text('Edit')),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          return _showAlertDialog(context,snapshot.data![index]['UserId']);
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(child: Text('Delete')),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            }
            return Text("data Copy");
          },
        ),
      ),
    );
  }

  void _navigateToListOfUser() async {
    // Perform asynchronous operations here if needed

    // Navigate to ListOfUser
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return AddUser();
    }));
  }
  void _showAlertDialog(BuildContext context,userId) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Are you sure you want to delete?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () async {
              Navigator.pop(context);
              await MyDatabase().deleteuser(userId);
              setState(() {
              });
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}

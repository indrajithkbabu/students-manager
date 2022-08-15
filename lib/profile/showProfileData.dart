// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:studentsportal/db/functions/db_functions.dart';
import 'package:studentsportal/db/model/datamodel.dart';
import 'package:studentsportal/profile/addProfile.dart';
import 'package:studentsportal/profile/listProfileData.dart';
import 'package:studentsportal/profile/updateProfile.dart';

class showProfileData extends StatelessWidget {

// final String name;
// final String age;
// final String branch;
// final String phone;
//var pic;
StudentModel data;
final int index;


  showProfileData({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(color: Color.fromARGB(255, 16, 65, 76))),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: ValueListenableBuilder(
                  valueListenable: studentListNotifier,
                  builder: (context, List<StudentModel>updatedList, child) {
                    return  updatedList.isEmpty? 
                    Container():
                    Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 10,
                          blurRadius: 10,
                          offset: Offset(5, 5))
                    ]),
                    width: size.width * 0.9,
                    height: size.height * 0.6,
                    child: Card(
                      color: Color.fromARGB(255, 16, 65, 76),
                      elevation: 12,
                      child: Center(
                          child: Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 15.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Student details",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 27, 32, 33)),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                              height: 130.0,
                              width: 130.0,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                image: DecorationImage(
                                  image: FileImage(File(updatedList[index].img)),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          // ListView.builder(
                
                          // )
                          SizedBox(height: 30,),
                          Container(
                            width: size.width * 0.7,
                            height: size.height * 0.25,
                           // color: Color.fromARGB(250, 20, 50, 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Name     : ${updatedList[index].name}',
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                                ),
                                 SizedBox(height: 25,),
                                Text('Age         : ${updatedList[index].age}',
                                 style: TextStyle(
                                  fontSize: 25,
                                ),),
                                    SizedBox(height: 25,),
                                Text('Branch    :  ${updatedList[index].branch}',
                                 style: TextStyle(
                                  fontSize: 25,
                                ),),
                                  SizedBox(height: 25,),
                                Text('Phone     : ${updatedList[index].phone}',
                                 style: TextStyle(
                                  fontSize: 25,
                                ),),
                              ],
                            ),
                          ),
                           SizedBox(height: 15,),
                          Container(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 5, 9, 10)),
                          ),
                          icon: Icon(
                            Icons.edit,
                            color: Color.fromARGB(255, 32, 57, 61),
                            size: 10.0,
                          ),
                          label: Text('Edit details', style: TextStyle(color:Colors.blueGrey ),),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>updateProfile(index:index, data: data)));
                          }),
                          ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 5, 9, 10)),
                          ),
                          icon: Icon(
                            Icons.delete_forever,
                            color: Color.fromARGB(255, 32, 57, 61),
                            size: 10.0,
                          ),
                          label: Text('Delete student', style: TextStyle(color:Colors.blueGrey ),),
                          onPressed: ()async {
                       // await    deleteStudent(index);
                        await showAlertDialog(context,index);
                          }),
                            ],
                          ),),
                        ],
                      )),
                    ),
                  ) ;
                  }),
                  
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}
showAlertDialog(BuildContext context,index) {

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: Text("Delete"),
    onPressed:  () async {
    

//Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>listProfileData()));
Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>listProfileData() ), (route) => false);

await deleteStudent(index);

    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete profile?"),
   
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


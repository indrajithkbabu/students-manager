import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studentsportal/db/functions/db_functions.dart';
import 'package:studentsportal/db/model/datamodel.dart';
import 'package:studentsportal/profile/addProfile.dart';
import 'package:studentsportal/profile/showProfileData.dart';

//ValueNotifier<List<String>> enteredDataList =ValueNotifier([]);

class listProfileData extends StatelessWidget {
   listProfileData({Key? key, }) : super(key: key);




  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
         automaticallyImplyLeading: false, 
         title: Text("Student's portal",style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w400
         ),),
         centerTitle: true,
          actions: <Widget>[

            // IconButton(onPressed: (){

            // }, icon: Icon(Icons.menu),
            // )
            //  IconButton(onPressed: (){

            // }, icon: Icon(Icons.person_search)
            // ),



            IconButton(
              onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> addProfile()) ) ;
              },
              icon: Icon(Icons.add),
              
            ),
            // IconButton(onPressed: (){

            // }, icon: Icon(Icons.delete)
            // )

          ],
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color.fromARGB(255, 16, 65, 76),
            child: Column(
              children: [
            //     Container(
            //         width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height*.05,
            // color: Color.fromARGB(255, 130, 70, 70),
            //     ),
                Expanded(
                  child:
                  ValueListenableBuilder (
                   valueListenable: studentListNotifier,
                   builder: (context , List<StudentModel>studentList,child) {
                      return studentList.isEmpty ? Center(child: Text('Student list is not added',style: TextStyle(fontSize:20,fontWeight: FontWeight.w800))) :
                      
                       ListView.separated(
                     
                         shrinkWrap: true,
                        itemCount: studentList.length,
                        itemBuilder: (context, index) {
                             final data =studentList[index];
                          return ListTile(
                            title: Text(data.name),
                            trailing: IconButton(onPressed: (){

                              deleteStudent(index);


                             



                            }, icon: Icon(Icons.delete)),
                           // subtitle: Text(data.age),

                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (ctx) => showProfileData(name: data.name, age:data.age, branch:data.branch, phone: data.phone, pic: data.img, index: index,)));
                            },


                            
                            leading: CircleAvatar(
                              radius: 25,
                             // backgroundColor: Colors.black45,
                             backgroundImage: FileImage(File(data.img)),
                            ),
                      //      title: Text(enteredDataList[index]),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                    //  );
                  //  }
                 // )
                );
                   }
                )
                )
              ],
            )));
  }
}

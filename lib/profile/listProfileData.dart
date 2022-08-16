// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studentsportal/db/functions/db_functions.dart';
import 'package:studentsportal/db/model/datamodel.dart';
import 'package:studentsportal/profile/addProfile.dart';

import 'package:studentsportal/profile/showProfileData.dart';

//ValueNotifier<List<String>> enteredDataList =ValueNotifier([]);

class listProfileData extends StatefulWidget {
   listProfileData({Key? key, }) : super(key: key);

  @override
  State<listProfileData> createState() => _listProfileDataState();
}

class _listProfileDataState extends State<listProfileData> {
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

          
//              IconButton(onPressed: (){
//  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> SearchProfile()) ) ;
//             }, icon: Icon(Icons.search)
//             ),



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
        body: InkWell(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
           onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
          child: Container(
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
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextField(
                    onChanged: (value)async{
                  
                     // Method For Searching 
                 await onSearch(value);
                 studentListNotifier.notifyListeners();
                


                               },
                        decoration: InputDecoration(
                        hintText: "Search profile",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                         borderRadius:
                        BorderRadius.all(Radius.circular(50.0)),
                                  ),
                                ),
                              ),
               ),
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
                              trailing: IconButton(onPressed: ()async{
        
                               await deleteStudent(index);
        
        
                               
        
        
        
                              }, icon: Icon(Icons.delete)),
                             // subtitle: Text(data.age),
        
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (ctx) => showProfileData( index: index, data: data,)));
                              },
        
        
                              
                              leading: CircleAvatar(
                                radius: 25,
                               // backgroundColor: Colors.black45,
                               backgroundImage: FileImage(File(data.img)),
                              ),
                        
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
              )),
        ));
  }
}

 onSearch(String query)async{
 final studentDB =await Hive.openBox<StudentModel>('student_db');
 final allDetails =studentDB.values.toList();
 final result;
 if(query.isEmpty){
result=allDetails;

 }else{
  result = allDetails.where((student) => student.name.toLowerCase().startsWith(query)).toList();
 }
studentListNotifier.value.clear();
studentListNotifier.value.addAll(result);
  
}
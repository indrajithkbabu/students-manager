

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studentsportal/db/model/datamodel.dart';
import 'package:studentsportal/profile/listProfileData.dart';

ValueNotifier<List<StudentModel>> studentListNotifier =ValueNotifier([]);

Future<void> addStudent(StudentModel value)async{

  

 final studentDB =await Hive.openBox<StudentModel>('student_db');

 await studentDB.add(value);    
        await getAllStudents();
 
} 

Future <void>getAllStudents()async{
   final studentDB =await Hive.openBox<StudentModel>('student_db');
studentListNotifier.value.clear();
studentListNotifier.value.addAll(studentDB.values);
studentListNotifier.notifyListeners();

}
Future<void> deleteStudent(int index)async{
  final studentDB =await Hive.openBox<StudentModel>('student_db');
  final Key =studentDB.keys;
  final saved_key =Key.elementAt(index);
  

 await studentDB.delete(saved_key);

 getAllStudents();

}
Future<void>updateStudent(index,StudentModel data)async{

final studentDB =await Hive.openBox<StudentModel>('student_db');
//int idx =studentListNotifier.value.indexOf(data);
final Key =studentDB.keys;
final update_key =Key.elementAt(index);



 await studentDB.put(update_key,data);
 await getAllStudents();
  
}
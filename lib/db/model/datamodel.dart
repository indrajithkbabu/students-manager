

// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
 import 'package:hive_flutter/adapters.dart';
part 'datamodel.g.dart';



@HiveType(typeId: 1)
class StudentModel{


@HiveField(0)
 int? id;

  @HiveField(1)
final String name;

 @HiveField(2)
final String age;

 @HiveField(3)
final String branch;

 @HiveField(4)
final String phone;

 @HiveField(5)
final img;



  StudentModel({required this.name, required this.age, required this.branch, required this.phone,required this.img,this.id});



}
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:studentsportal/db/model/datamodel.dart';
import 'package:studentsportal/profile/addProfile.dart';
import 'package:studentsportal/profile/listProfileData.dart';

Future<void> main()async {
WidgetsFlutterBinding.ensureInitialized();
 await Hive.initFlutter();
 if(!Hive.isAdapterRegistered(StudentModelAdapter().typeId )){
Hive.registerAdapter(StudentModelAdapter());

 }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
   
        primarySwatch: Colors.blueGrey,
      ),
      home:listProfileData()
    );
  }
}



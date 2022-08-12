// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentsportal/db/functions/db_functions.dart';
import 'package:studentsportal/db/model/datamodel.dart';
import 'package:studentsportal/profile/listProfileData.dart';






// ValueNotifier<dynamic> pickedImage =ValueNotifier(null);



class addProfile extends StatefulWidget {
  addProfile( {Key? key}) : super(key: key);

  @override
  State<addProfile> createState() => _addProfileState();
}

class _addProfileState extends State<addProfile> {
  final _nameController = TextEditingController();

    final _ageController = TextEditingController();

      final _branchController = TextEditingController();

        final _phoneController = TextEditingController();

var pic;
var photo;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 65, 76),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        onTap: () {

        FocusManager.instance.primaryFocus!.unfocus();
      },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding:  EdgeInsets.only(top: 10,left: 10,right: 10),
            child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Student's portal",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(255, 27, 32, 33)),
                ),
                SizedBox(height: 15),
                CircleAvatar(
                    radius: 52,
                   backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: photo==null?  Image.asset('assets/defaultpic.jpg' ,fit: BoxFit.cover,height: 135,
                        width: 135,) :Image.file(File(photo) , fit: BoxFit.cover,height: 135,
                        width: 135,)
                    )),
          
                SizedBox(height: 5),
                ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 5, 9, 10)),
                    ),
                    icon: Icon(
                      Icons.image,
                      color: Color.fromARGB(255, 32, 57, 61),
                      size: 10.0,
                    ),
                    label: Text(
                      'Image',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                    onPressed: () async {
                          pic =await getImage();
                      setState(() {
                       photo=pic;
                      });
                    
                      // pickedImage.value =pic;
                    }),
                SizedBox(height: 12),
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  style:  TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 24, 31, 32)),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    contentPadding:
                        EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                   controller: _ageController,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 24, 31, 32)),
                  decoration: InputDecoration(
                    labelText: 'Age',
                    contentPadding:
                        EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                   controller: _branchController,
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  style:  TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 24, 31, 32)),
                  decoration: InputDecoration(
                    labelText: 'Branch',
                    contentPadding:
                        EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                   controller: _phoneController,
                  keyboardType: TextInputType.number,
                  autofocus: false,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 24, 31, 32)),
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    contentPadding:
                        EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 5, 9, 10)),
                    ),
                    icon: Icon(
                      Icons.save,
                      color: Color.fromARGB(255, 32, 57, 61),
                      size: 30.0,
                    ),
                    label: Text('Save',
                        style: TextStyle(color: Colors.blueGrey)),
                    onPressed: () {
                     // enteredDataList.value.add(_nameController.text);
                  onAddStudentButtonClicked(context);
          
                      
                    }),
           
              ],
            ),
          ),
        ),
      ),
    );
  }

Future getImage()async{
  XFile? _image =await ImagePicker().pickImage(source: ImageSource.gallery);
return _image!.path ;

}

Future onAddStudentButtonClicked(ctx)async{
final _name =_nameController.text.trim();
    final _age = _ageController.text.trim();
    final _branch = _branchController.text.trim();
    final _phone = _phoneController.text.trim();
    //snackbar
    if (_name.isEmpty || _age.isEmpty || _branch.isEmpty || _phone.isEmpty || pic==null) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(15),
          backgroundColor: Colors.red,
          content: Text('Add complete details')));
    }else{

     final _student= StudentModel(name: _name, age: _age, branch: _branch, phone: _phone, img: pic);
     Navigator.pushReplacement(
                            ctx,
                            MaterialPageRoute(
                                builder: (context) => listProfileData()),
                          );

addStudent(_student);

    }




}
}
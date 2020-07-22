import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttersolvecaseuploader/constants.dart';

class UploadStudyMaterial extends StatefulWidget {
  UploadStudyMaterial({Key key}) : super(key: key);

  @override
  _UploadStudyMaterialState createState() => _UploadStudyMaterialState();
}

class _UploadStudyMaterialState extends State<UploadStudyMaterial> {
  final _formKey = GlobalKey<FormState>();
  final listOfCategories1 = [
    "First",
    "Second",
    "Third",
    "Fourth",
  ];
  final listOfSubjects1 = [
    "A",
    "B",
    "C",
    "D",
  ];
  final listOfSubjects2 = [
    "E",
    "F",
    "G",
    "H",
  ];
  final listOfSubjects3 = [
    "I",
    "J",
    "K",
    "L",
  ];
  final listOfSubjects4 = [
    "M",
    "N",
    "O",
    "P",
  ];
  int subnum = 1;
  String dropdownValue1 = 'First';
  String subjectlist = 'listofSubjects1';
  String DropdownValuesub = 'E';

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final quantity = TextEditingController();
  final dbRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    List<String> temp = listOfSubjects2;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Enter File Name",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: kPrimaryColor)),
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter File Name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: DropdownButtonFormField(
                value: dropdownValue1,
                icon: Icon(
                  Icons.arrow_downward,
                  color: kPrimaryColor,
                ),
                decoration: InputDecoration(
                  labelText: "Select Semester",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: kPrimaryColor)),
                ),
                items: listOfCategories1.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'Cabin',
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue1 = newValue;
                    print(dropdownValue1);
                    if (dropdownValue1 == 'First') {
                      temp = listOfSubjects1;
                    }
                    if (dropdownValue1 == 'Second') {
                      temp = listOfSubjects2;
                    }
                    if (dropdownValue1 == 'Third') {
                      temp = listOfSubjects3;
                    }
                    if (dropdownValue1 == 'Fourth') {
                      temp = listOfSubjects4;
                    }
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Select Semester';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: DropdownButtonFormField(
                value: DropdownValuesub,
                icon: Icon(
                  Icons.arrow_downward,
                  color: kPrimaryColor,
                ),
                decoration: InputDecoration(
                  labelText: "Select Subjects",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: kPrimaryColor)),
                ),
                items: temp.map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(
                      value,
                      style: TextStyle(
                        fontFamily: 'Cabin',
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String newValue) {
                  setState(() {
                    DropdownValuesub = newValue;
                  });
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please Select Subject';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: kPrimaryColor),
                ),
                color: kPrimaryColor,
                onPressed: () {
                  int price1 = int.parse(ageController.text);
                  if (_formKey.currentState.validate()) {
                    dbRef
                        .child(dropdownValue1)
                        .child(nameController.text)
                        .update({
                      "Name": nameController.text,
                    }).then((_) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Successfully Added')));
                      ageController.clear();
                      nameController.clear();
                    }).catchError((onError) {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text(onError)));
                    });
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(fontFamily: 'Cabin', color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

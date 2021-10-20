import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'contact.dart';
import 'home.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key}) : super(key: key);

  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final formKey = GlobalKey<FormState>();
  late String name;
  late String number;
  late int year,month,day,hour,minute,second;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Add Contact"),
        centerTitle: true,
      ),
      body:
        Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.all(0),
                    child:Text("Enter name: ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Name'
                  ),
                  style: TextStyle(fontSize: 20),
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter name';
                    }else{
                      name = input;
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16,),
                Text("Enter phone number: ",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Phone Number'
                  ),
                  style: TextStyle(fontSize: 20),
                  validator: (input) {
                    if (input == null || input.isEmpty) {
                      return 'Please enter phone number';
                    }else{
                      number = input;
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16,),
                Text("Enter check in date & time: ",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width:65,
                        child:TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "YYYY"
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return "year?";
                        }else{
                          year = int.parse(input);
                        }
                        return null;
                      },
                    )
                    ),
                    Container(width:65,
                        child:TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'MM'
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'month?';
                          }else{
                            month = int.parse(input);
                          }
                          return null;
                        },
                    )),
                    Container(width:65,
                        child:TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'DD',
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'day?';
                          }else{
                            day = int.parse(input);
                          }
                          return null;
                        },
                    )),
                    Container(width:65,
                        child:TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'hh'
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'hour?';
                          }else{
                            hour = int.parse(input);
                          }
                          return null;
                        },
                    )),
                    Container(width:65,
                        child:TextFormField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'mm',
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        validator: (input) {
                          if (input == null || input.isEmpty) {
                            return 'minute?';
                          }else{
                            minute = int.parse(input);
                          }
                          return null;
                        },
                    ))
                  ]
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        second = 0 ;
                        Contact newContact = Contact(name, number, year, month, day, hour, minute, second);
                        MyApp.displayingContacts.add(newContact);
                        Navigator.pushReplacement(context, MaterialPageRoute<void>(
                          builder: (BuildContext context) => const MyApp())
                        );
                        Fluttertoast.showToast(
                            msg: "The contact is added to list",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 16.0);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}




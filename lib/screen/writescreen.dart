import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:writeout_web_android_ios/services/data_services.dart';

import 'home.dart';
class WriteScreen extends StatefulWidget {
  //const WriteScreen({Key? key}) : super(key: key);
  String email='';
  WriteScreen({required this.email});

  @override
  State<WriteScreen> createState() => _WriteScreenState(email);
}

class _WriteScreenState extends State<WriteScreen> {
  String email='';
  _WriteScreenState(this.email);
  var formKey=GlobalKey<FormState>();
  String articleName='';/////
  String Article='';////
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());//////
  DataService dataService=DataService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.brown,
            title: Text(
              'Write OUT',
              style: TextStyle(
                  color: Colors.yellow
              ),
            ),
            actions: [
              TextButton.icon(
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home(email: email,)), (route) => false);
                  },
                  icon: Icon(Icons.home,color: Colors.yellow,),
                  label: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.yellow,
                    ),
                  )
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Article Name ',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white,width: 2)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.brown,width: 2)
                        ),
                      ),
                      validator: (val)=> val!.isEmpty? 'Required Field':null,
                      onChanged: (val){
                        setState(() {
                          articleName=val;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                        SizedBox(width: 10,),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      validator: (val)=> val!.isEmpty? 'Required Field':null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Start Writing From Here',
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,width: 2)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow,width: 2)
                        ),
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      onChanged: (val){
                        setState(() {
                          Article=val;
                        });
                      },
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton.icon(
                      icon: Icon(Icons.upload),
                        onPressed: (){
                            if(formKey.currentState!.validate()){
                              showLoaderDialog(BuildContext context){
                                AlertDialog alert=AlertDialog(
                                  content: new Row(
                                    children: [
                                      CircularProgressIndicator(),
                                      Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
                                    ],),
                                );
                                showDialog(barrierDismissible: false,
                                  context:context,
                                  builder:(BuildContext context){
                                    return alert;
                                  },
                                );
                              }
                              showLoaderDialog(context);
                              dataService.DataInsertOne(email, articleName, formattedDate, Article,context);
                            }
                        },
                        label: Text(
                          'Submit'
                        ),
                    )
                  ],
                ),
              ),
            ),
          )
      );
  }
}

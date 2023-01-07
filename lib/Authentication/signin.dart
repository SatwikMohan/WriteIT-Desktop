import 'package:flutter/material.dart';
import 'package:writeout_web_android_ios/Authentication/register.dart';
import 'package:writeout_web_android_ios/services/auth.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email='',password='';
  var formKey=GlobalKey<FormState>();
  AuthService authService=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text('SignIN'),
        actions: [
          TextButton.icon(icon: Icon(Icons.person,color: Colors.yellow,),
            onPressed:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Register()));
            },
            label: Text(
                'Register',
              style: TextStyle(
                color: Colors.yellow
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Email ',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,width: 2)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink,width: 2)
                  ),
                ),
                validator: (val)=> val!.isEmpty? 'Enter an Email':null,
                onChanged: (val){
                  setState(() {
                    email=val;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Password ',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white,width: 2)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.pink,width: 2)
                  ),
                ),
                validator: (val)=> val!.length<6? 'Enter a Password of at least 6 char':null,
                obscureText: true ,
                onChanged: (val){
                  setState(() {
                    password=val;
                  });
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
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
                              authService.SignInWithEmailAndPassword(email, password,context);
                        }
                   },
                  child: Text(
                    'Sign IN',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

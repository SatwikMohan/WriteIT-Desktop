import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:writeout_web_android_ios/screen/home.dart';
class AuthService {
    String? error='';
    String? localId='';
    Future RegisterWithEmailAndPassword(String email, String password,BuildContext context) async{
        String baseurl='https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDYeP4yBnnX_CliQoJzrbeo9_WxsRaIfUg';
        final body={
            "email":email,
            "password":password,
            "returnSecureToken":true
        };
        final response;
        try{

            response=await http.post(Uri.parse(baseurl),
                headers:{'Content-type': 'application/json'},
                body: jsonEncode(body)
            );

            var data=jsonDecode(response.body);
            print(data);
            error=data['error'].toString();
            localId=data['localId'].toString();
            print(error);
            Navigator.pop(context);
            if(error=="null"){
                showDialog(context: context, builder: (context)=>AlertDialog(
                    title: Text(
                        'Authentication Message',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    content: Text(
                        'Registration Successful! You can now Sign IN'
                    ),
                ));
            }else{
                showDialog(context: context, builder: (context)=>AlertDialog(
                    title: Text(
                        'Authentication Message',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    content: Text(
                        'The User is already Registered',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                ));
            }

        }catch(e){
            print('Registerwithemailandpassword=> ${e.toString()}');
        }
    }

    Future SignInWithEmailAndPassword(String email,String password,BuildContext context) async{
        error='';
        String baseurl='https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDYeP4yBnnX_CliQoJzrbeo9_WxsRaIfUg';
        final body={
            "email":email,
            "password":password,
            "returnSecureToken":true
        };
        final response;
        try{
            response=await http.post(Uri.parse(baseurl),
                headers:{'Content-type': 'application/json'},
                body: jsonEncode(body)
            );
            var data=jsonDecode(response.body);
            print(data.toString());
            error=data['error'].toString();
            print(error);
            Navigator.pop(context);
            if(error=="null"){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home(email: email,)), (route) => false);
            }else{
                showDialog(context: context, builder: (context)=>AlertDialog(
                    title: Text(
                        'Authentication Message',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                    content: Text(
                        'No such User Registered',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                        ),
                    ),
                ));
            }
        }catch(e){
            print('SignInWithEmailAndPassword=> ${e.toString()}');
        }
    }

}
import 'package:flutter/material.dart';
import 'package:writeout_web_android_ios/screen/tabs/favorite.dart';
import 'package:writeout_web_android_ios/screen/tabs/mywriting.dart';
import 'package:writeout_web_android_ios/screen/tabs/writings.dart';
import 'package:writeout_web_android_ios/screen/writescreen.dart';

import '../Modal/ArticleModal.dart';
import '../services/data_services.dart';

class Home extends StatefulWidget {
  //const Home({Key? key}) : super(key: key);
  String email='';
  Home({required this.email});

  @override
  State<Home> createState() => _HomeState(email);
}

class _HomeState extends State<Home> {
  String email='';
  _HomeState(this.email);

  @override
  Widget build(BuildContext context) {
    print('Email _HomeState ${email}');
    return DefaultTabController(
        length:3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.brown,
            title: Text(
                'Home'
            ),
            actions: [
              TextButton.icon(
                icon: Icon(Icons.edit,color: Colors.yellow,),
                onPressed: (){
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WriteScreen(email:email)));
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder:(context)=>WriteScreen(email: email)), (route) => false);
                },
                label: Text(
                  'Write ',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.favorite),text:'Favorite',),
                Tab(icon: Icon(Icons.people),text:'Writings',),
                Tab(icon: Icon(Icons.folder),text:'My Writings',),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Favorite(email: email,),
              Writings(email: email,),
              MyWiriting(email: email)
            ],
          ),
        ),
    );
  }
}

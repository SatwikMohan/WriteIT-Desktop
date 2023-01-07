import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:writeout_web_android_ios/services/data_services.dart';

import '../../Modal/ArticleModal.dart';
class Writings extends StatefulWidget {
  //const Writings({Key? key}) : super(key: key);
  String email='';
  Writings({required this.email});

  @override
  State<Writings> createState() => _WritingsState(email: email);
}

class _WritingsState extends State<Writings> {

  String email='';
  _WritingsState({required this.email});

  List<ArticleModal>? list=[];

  DataService dataService=DataService();

  Future<void> fetchData() async{
    String baseUrl='https://data.mongodb-api.com/app/data-tqyfi/endpoint/data/v1/action/find';
    final body={
      "dataSource":"Cluster0",
      "database":"WriteOutDatabase",
      "collection":"WriteOutCollection",
      "filter":{
        "get":"all"
      }
    };
    final response;
    try{
      response=await http.post(Uri.parse(baseUrl),
          headers: {'Content-Type':'application/json',
            'Accept':'application/json',
            'Access-Control-Request-Headers':'Access-Control-Allow-Origin, Accept',
            'api-key':'MHzPK7JBgspOWAZ5G0ZHDOgT93hmZlCy7evyHjRRTCU4WRBmDoMbt2g7EKAaG9Qv'},
          body: jsonEncode(body)
      );
      var data=jsonDecode(response.body);
      print(data.toString());
      print(data['documents']);
      print(data['documents'].length);
      if(data['documents'].length>0){
        print(data['documents'][0]);
        print(data['documents'][0]['user']);
      }
      for(int i=0;i<data['documents'].length;i++){
        setState(() {
          //list?[i]=ArticleModal(user: data['documents'][i]['user'], articleName: data['documents'][i]['articleName'], date: data['documents'][i]['date'], Article: data['documents'][i]['Article']);
          list?.add(ArticleModal(user: data['documents'][i]['user'], articleName: data['documents'][i]['articleName'], date: data['documents'][i]['date'], Article: data['documents'][i]['Article']));
        });
      }
    }catch(e){
      print("writingsfetchData=> ${e.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }


  @override
  Widget build(BuildContext context) {
    print('listlength=>'+list!.length.toString());
    if(list!.length==0){
      return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 55),
          child: Text(
            'Nothing to show!!!!',
            style: TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }else{
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: list!.map((dataArticle){
              return ListTile(
                tileColor: Colors.blueAccent[100],
                title: Text(
                  dataArticle.articleName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  dataArticle.Article,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                leading: Icon(Icons.book,),
                trailing: IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: (){
                        dataService.FavoriteInserOne(email, dataArticle.articleName, dataArticle.date, dataArticle.Article,context);
                  },
                ),
              );
            }).toList(),
          ),
        ),
      );
    }
  }
}

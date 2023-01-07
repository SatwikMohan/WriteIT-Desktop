import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:writeout_web_android_ios/Modal/ArticleModal.dart';
class DataService{
  Future DataInsertOne(String user,String articleName,String date,String Article,BuildContext context) async{
    String baseUrl='https://data.mongodb-api.com/app/data-tqyfi/endpoint/data/v1/action/insertOne';
    final body={
          "dataSource":"Cluster0",
          "database":"WriteOutDatabase",
          "collection":"WriteOutCollection",
          "document":{
                          "user":user,
                          "articleName":articleName,
                          "date":date,
                          "Article":Article,
                          "get":"all"
                     }
      };
    // final Map<String,String> header={
    //   "Content-type":"application/json",
    //   "Access-Control-Request-Headers":"*",
    //   "api-key":"MHzPK7JBgspOWAZ5G0ZHDOgT93hmZlCy7evyHjRRTCU4WRBmDoMbt2g7EKAaG9Qv"
    // };
    // final response;
    // try{
    //   response=await http.post(Uri.parse(baseUrl),
    //     headers:header,
    //     body: jsonEncode(body)
    //   );
    //   var data=jsonDecode(response.body);
    //   print(data.toString());
    // }catch(e){
    //   print("DataInsertOne=> ${e.toString()}");
    // }

    HttpClient httpClient=new HttpClient();
    HttpClientRequest httpClientRequest=await httpClient.postUrl(Uri.parse(baseUrl));
    httpClientRequest.headers.set("Content-Type", "application/json");
    httpClientRequest.headers.set("api-key", "MHzPK7JBgspOWAZ5G0ZHDOgT93hmZlCy7evyHjRRTCU4WRBmDoMbt2g7EKAaG9Qv");
    httpClientRequest.add(utf8.encode(jsonEncode(body)));
    HttpClientResponse response=await httpClientRequest.close();
    httpClient.close();
    final contents = StringBuffer();
    await for (var data in response.transform(utf8.decoder)) {
      contents.write(data);
    }
    var output=jsonDecode(contents.toString());
    print(output['insertedId']);

    Navigator.pop(context);
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text(
        'Upload Message',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Your Writings are successfully uploaded',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));

  }

  Future FavoriteInserOne(String user,String articleName,String date,String Article,BuildContext context) async{
    String baseUrl='https://data.mongodb-api.com/app/data-tqyfi/endpoint/data/v1/action/insertOne';
    final body={
      "dataSource":"Cluster0",
      "database":"WriteOutDatabase",
      "collection":"CollectionFavorite",
      "document":{
        "user":user,
        "articleName":articleName,
        "date":date,
        "Article":Article,
      }
    };
    HttpClient httpClient=new HttpClient();
    HttpClientRequest httpClientRequest=await httpClient.postUrl(Uri.parse(baseUrl));
    httpClientRequest.headers.set("Content-Type", "application/json");
    httpClientRequest.headers.set("api-key", "MHzPK7JBgspOWAZ5G0ZHDOgT93hmZlCy7evyHjRRTCU4WRBmDoMbt2g7EKAaG9Qv");
    httpClientRequest.add(utf8.encode(jsonEncode(body)));
    HttpClientResponse response=await httpClientRequest.close();
    httpClient.close();
    final contents = StringBuffer();
    await for (var data in response.transform(utf8.decoder)) {
      contents.write(data);
    }
    var output=jsonDecode(contents.toString());
    print(output['insertedId']);
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text(
        'Favorite Upload Message',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Successfully Added to your Favorites',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }

  //   Future<List<ArticleModal>?> DataFindMultiple(String user) async{
  //
  //   String baseUrl='https://data.mongodb-api.com/app/data-tqyfi/endpoint/data/v1/action/find';
  //   final body={
  //     "dataSource":"Cluster0",
  //     "database":"WriteOutDatabase",
  //     "collection":"WriteOutCollection",
  //     "filter":{
  //                  "user":user
  //              }
  //   };
  //   final response;
  //   try{
  //     response=await http.post(Uri.parse(baseUrl),
  //         headers: {'Content-Type':'application/json',
  //                   'Accept':'application/json',
  //                   'Access-Control-Request-Headers':'Access-Control-Allow-Origin, Accept',
  //                   'api-key':'MHzPK7JBgspOWAZ5G0ZHDOgT93hmZlCy7evyHjRRTCU4WRBmDoMbt2g7EKAaG9Qv'},
  //         body: jsonEncode(body)
  //     );
  //     var data=jsonDecode(response.body);
  //     print(data.toString());
  //     print(data['documents']);
  //     print(data['documents'].length);
  //     if(data['documents'].length>0){
  //       print(data['documents'][0]);
  //       print(data['documents'][0]['user']);
  //     }
  //     List<ArticleModal> list=[];
  //     for(int i=0;i<data['documents'].length;i++){
  //       list.add(ArticleModal(user: data['documents'][i]['user'], articleName: data['documents'][i]['articleName'], date: data['documents'][i]['date'], Article: data['documents'][i]['Article']));
  //     }
  //     return list;
  //   }catch(e){
  //     print("DataFindMultiple=> ${e.toString()}");
  //   }
  // }
}
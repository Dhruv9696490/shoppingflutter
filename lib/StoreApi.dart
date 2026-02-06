import 'dart:convert';
import 'package:shoppingflutter/private_section/private.dart';
import 'package:shoppingflutter/shopping_model.dart';
import 'package:http/http.dart' as http;

class StoreApi{
   Future<List<StoreData>> getAllItems() async{
     final itemInstance = await http.get(Uri.parse(PrivateData.api));
     if(itemInstance.statusCode==200){
       try{
         final List<dynamic> response = jsonDecode(itemInstance.body);
         return response.map((it){
           return StoreData.fromJson(it);
         }).toList();
       }catch(e){
         throw Exception(e.toString());
       }
     }else{
       throw Exception("Something Went wrong");
     }
   }
}
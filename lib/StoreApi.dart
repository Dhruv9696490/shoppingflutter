import 'dart:convert';
import 'package:shoppingflutter/shopping_model.dart';
import 'package:http/http.dart' as http;

class StoreApi{
   static const String api = "https://fakestoreapi.com/products";
   Future<List<StoreData>> getAllItems() async{
     final itemInstance = await http.get(Uri.parse(api));
     if(itemInstance.statusCode==200){
       try{
         final List response = jsonDecode(itemInstance.body);
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
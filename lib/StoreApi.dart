import 'dart:convert';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shoppingflutter/database/data_base_helper.dart';
import 'package:shoppingflutter/private_section/private.dart';
import 'package:shoppingflutter/model/shopping_model.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';

class StoreRepository {
  Future<List<StoreData>> getAllItems() async {
    final DatabaseHelper databaseHelper = DatabaseHelper.instance;
    final db = await databaseHelper.database;
    try {
      if (!(await InternetConnection().hasInternetAccess)) {
        final res = await db.query('products');
        return res.map((item) {
          return StoreData.fromMap(item);
        }).toList();
      }
      final itemInstance = await http.get(Uri.parse(PrivateData.api));
      if (itemInstance.statusCode == 200) {
        final List response = jsonDecode(itemInstance.body);
        final data = response.map((it) {
          return StoreData.fromJson(it);
        }).toList();
        for (var i in data) {
          await db.insert(
            'products',
            i.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        return data;
      }
      throw Exception("something went wrong");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

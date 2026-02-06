
import 'package:flutter/cupertino.dart';
import 'package:shoppingflutter/StoreApi.dart';
import 'package:shoppingflutter/shopping_model.dart';

class StoreViewModel extends ChangeNotifier{
  final StoreApi storeApi = StoreApi();
  List<StoreData> _list = [];
  List<StoreData> get list => _list;
  bool _loading = false;
  bool get loading => _loading;
  String _error = "";
  String get error => _error;
  Future<void> getAllData()async{
    _loading = true;
    notifyListeners();
    try{
      _list = await storeApi.getAllItems();
    }catch(e){
      _error = e.toString();
    }
    _loading =false;
    notifyListeners();
  }
  void toggleFavorite(StoreData product){
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }
}
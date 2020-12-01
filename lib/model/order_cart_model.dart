import 'package:flutter/cupertino.dart';

class CartModel extends ChangeNotifier {
  int _counter;
  List<String> _food;
  List<String> _img;
  List<String> _fiyat;
  List<int> _counterList;

  int get counter => _counter;
  List<int> get counterList => _counterList;
  List<String> get food => _food;
  List<String> get img => _img;
  List<String> get fiyat => _fiyat;

  CartModel(
      this._counter, this._food, this._fiyat, this._img, this._counterList);

  void increment() {
    _counter++;
    notifyListeners();
  }

  void addFood(String foodName, String foodPrice, String foodImg) {
    _food.add(foodName);
    _img.add(foodImg);
    _fiyat.add(foodPrice);
    _counterList.add(1);
    notifyListeners();
  }

  void removeFood(String foodName, String foodPrice, String foodImg) {
    _food.remove(foodName);
    _img.remove(foodImg);
    _fiyat.remove(foodPrice);
    _counterList.remove(0);
    _counter--;
    notifyListeners();
  }

  void decreaseCounter(int index) {
    _counterList[index]--;
    notifyListeners();
  }

  void increaseCounter(int index) {
    _counterList[index]++;
    notifyListeners();
  }

  double sumPrice() {
    double sum = 0;
    for (int i = 0; i < _food.length; i++) {
      sum += double.parse(_fiyat[i]) * _counterList[i];
    }
    return sum;
  }
}

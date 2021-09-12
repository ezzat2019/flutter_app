import 'package:flutter/cupertino.dart';

class Test3Provider extends ChangeNotifier{
  int count=0;
  int countHome=20;
  void increCount(){
    this.count++;
    notifyListeners();
  }
  void increCountHome(){
    this.countHome++;
    notifyListeners();
  }
}
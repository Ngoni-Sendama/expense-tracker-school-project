import 'package:flutter/material.dart';

class IncomeModel with ChangeNotifier {
  List<Map<String, dynamic>> _incomes = [];

  List<Map<String, dynamic>> get incomes => _incomes;

  void addIncome(String title, double amount) {
    _incomes.add({'title': title, 'amount': amount});
    notifyListeners();
  }

  void updateIncome(int index, String title, double amount) {
    _incomes[index] = {'title': title, 'amount': amount};
    notifyListeners();
  }

  double get totalIncome {
    return _incomes.fold(0.0, (sum, income) => sum + income['amount']);
  }
}

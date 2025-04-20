import 'package:flutter/foundation.dart';

class ExpenseModel with ChangeNotifier {
  List<Map<String, dynamic>> _expenses = [];

  List<Map<String, dynamic>> get expenses => _expenses;

  double get totalExpense {
    return _expenses.fold(0.0, (sum, item) => sum + (item['amount'] ?? 0));
  }

  void addExpense(String title, double amount) {
    _expenses.add({
      'title': title,
      'amount': amount,
    });
    notifyListeners();
  }

  void updateExpense(int index, String newTitle, double newAmount) {
    if (index >= 0 && index < _expenses.length) {
      _expenses[index] = {
        'title': newTitle,
        'amount': newAmount,
      };
      notifyListeners();
    }
  }
}

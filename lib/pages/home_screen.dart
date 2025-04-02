import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Expense Manager"),
      ),
      body: ExpenseHomePage(), // Removed extra parenthesis
    );
  }
} // Added missing closing brace

class Expense {
  final String description;
  final double amount;
  final String category;

  Expense({required this.description, required this.amount, required this.category});
}

class ExpenseHomePage extends StatefulWidget {
  const ExpenseHomePage({super.key});

  @override
  _ExpenseHomePageState createState() => _ExpenseHomePageState();
}

class _ExpenseHomePageState extends State<ExpenseHomePage> {
  final List<Expense> _expenses = [];
  double _budget = 1000.0;

  void _setBudget(double budget) {
    setState(() {
      _budget = budget;
    });
  }

  void _addExpense(String description, double amount, String category) {
    setState(() {
      _expenses.add(Expense(description: description, amount: amount, category: category));
    });
  }

  double get totalSpent {
    return _expenses.fold(0, (sum, expense) => sum + expense.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Column( // Removed duplicate Scaffold
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text("Budget: \$${_budget.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Total Spent: \$${totalSpent.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 18,
                        color: totalSpent > _budget ? Colors.red : Colors.green,
                        fontWeight: FontWeight.bold,
                      )),
                  if (totalSpent > _budget)
                    const Text(
                      "⚠ Budget Exceeded!",
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => _showBudgetDialog(),
                    child: const Text("Set Budget"),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: _expenses.isEmpty
              ? const Center(child: Text("No Expenses Yet!"))
              : ListView.builder(
                  itemCount: _expenses.length,
                  itemBuilder: (context, index) {
                    final expense = _expenses[index];
                    return Hero(
                      tag: expense.description,
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: ListTile(
                          leading: Icon(Icons.category, color: Colors.blue),
                          title: Text(expense.description),
                          subtitle: Text("${expense.category} - \$${expense.amount.toStringAsFixed(2)}"),
                        ),
                      ),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddExpensePage()),
              );
              if (result != null && result is Map<String, dynamic>) {
                _addExpense(result['description'], result['amount'], result['category']);
              }
            },
          ),
        ),
      ],
    );
  }

  void _showBudgetDialog() {
    final TextEditingController _budgetController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Set Budget"),
        content: TextField(
          controller: _budgetController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Enter Budget Amount"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final budget = double.tryParse(_budgetController.text) ?? 0;
              if (budget > 0) {
                _setBudget(budget);
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  _AddExpensePageState createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _selectedCategory = "Food";

  final List<String> _categories = ["Food", "Rent", "Travel", "Entertainment", "Other"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Expense")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: "Expense Description"),
            ),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: _selectedCategory,
              items: _categories.map((category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value as String;
                });
              },
              decoration: const InputDecoration(labelText: "Category"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final desc = _descController.text.trim();
                final amountText = _amountController.text.trim();
                final amount = double.tryParse(amountText) ?? 0;

                if (desc.isEmpty || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter valid details")),
                  );
                  return;
                }

                Navigator.pop(context, {
                  'description': desc,
                  'amount': amount,
                  'category': _selectedCategory
                });
              },
              child: const Text("Add Expense"),
            ),
          ],
        ),
      ),
    );
  }
}
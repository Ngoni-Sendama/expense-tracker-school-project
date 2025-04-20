import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/income_model.dart';  // Import the income model

class IncomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income Tracker'),
      ),
      body: Consumer<IncomeModel>(
        builder: (context, incomeModel, child) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 60, bottom: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF0666EB),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      '\$${incomeModel.totalIncome.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Total Income',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: incomeModel.incomes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFF0666EB).withOpacity(0.1),
                          child: Icon(Icons.money, color: Color(0xFF0666EB)),
                        ),
                        title: Text(incomeModel.incomes[index]['title']),
                        subtitle: Text(
                          '\$${incomeModel.incomes[index]['amount'].toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        trailing: Icon(Icons.edit, size: 16),
                        onTap: () => _showEditIncomeDialog(context, index),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () => _showAddIncomeDialog(context),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'New Income',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAddIncomeDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Income'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Income Title'),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Income Amount'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String title = titleController.text;
                final double amount = double.tryParse(amountController.text) ?? 0.0;

                if (title.isNotEmpty && amount > 0) {
                  Provider.of<IncomeModel>(context, listen: false)
                      .addIncome(title, amount);
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditIncomeDialog(BuildContext context, int index) {
    final TextEditingController titleController = TextEditingController(text: context.read<IncomeModel>().incomes[index]['title']);
    final TextEditingController amountController = TextEditingController(text: context.read<IncomeModel>().incomes[index]['amount'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Income'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Income Title'),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Income Amount'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final String title = titleController.text;
                final double amount = double.tryParse(amountController.text) ?? 0.0;

                if (title.isNotEmpty && amount > 0) {
                  Provider.of<IncomeModel>(context, listen: false)
                      .updateIncome(index, title, amount);
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

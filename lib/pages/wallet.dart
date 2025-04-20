import 'package:flutter/material.dart';

class IncomePage extends StatefulWidget {
  @override
  _IncomePageState createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  List<Map<String, dynamic>> incomes = [];

  void _showAddIncomeDialog() {
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
                  setState(() {
                    incomes.add({
                      'title': title,
                      'amount': '\$${amount.toStringAsFixed(2)}',
                    });
                  });
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

  void _showEditIncomeDialog(int index) {
    final TextEditingController titleController = TextEditingController(text: incomes[index]['title']);
    final TextEditingController amountController = TextEditingController(text: incomes[index]['amount'].substring(1));

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
                  setState(() {
                    incomes[index] = {
                      'title': title,
                      'amount': '\$${amount.toStringAsFixed(2)}',
                    };
                  });
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

  @override
  Widget build(BuildContext context) {
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
                '\$${incomes.fold(0.0, (sum, income) => sum + double.tryParse(income['amount']!.substring(1))!).toStringAsFixed(2)}',
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
            itemCount: incomes.length,
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
                  title: Text(incomes[index]['title']),
                  subtitle: Text(
                    incomes[index]['amount'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  trailing: Icon(Icons.edit, size: 16),
                  onTap: () => _showEditIncomeDialog(index),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _showAddIncomeDialog,
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
  }
}

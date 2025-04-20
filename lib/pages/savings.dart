import 'package:flutter/material.dart';

class SavingsPage extends StatefulWidget {
  @override
  _SavingsPageState createState() => _SavingsPageState();
}

class _SavingsPageState extends State<SavingsPage> {
  List<Map<String, dynamic>> savings = [];

  void _showAddSavingDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController savedController = TextEditingController();
    final TextEditingController targetController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Saving'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Saving Name'),
              ),
              TextField(
                controller: savedController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Saved Amount'),
              ),
              TextField(
                controller: targetController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Target Amount'),
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
                final String name = nameController.text;
                final double saved =
                    double.tryParse(savedController.text) ?? 0.0;
                final double target =
                    double.tryParse(targetController.text) ?? 0.0;

                if (name.isNotEmpty && saved >= 0 && target > 0) {
                  setState(() {
                    savings.add({
                      'name': name,
                      'saved': saved,
                      'target': target,
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

  void _showEditSavingDialog(int index) {
    final TextEditingController savedController =
        TextEditingController(text: savings[index]['saved'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Saving'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: savedController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Updated Saved Amount'),
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
                final double updatedSaved =
                    double.tryParse(savedController.text) ?? 0.0;

                if (updatedSaved >= 0) {
                  setState(() {
                    savings[index]['saved'] = updatedSaved;
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Save Changes'),
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
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: savings.length,
            itemBuilder: (context, index) {
              final item = savings[index];
              double percentage = 0.0;

              if (item['target'] != 0) {
                percentage = (item['saved'] / item['target']) * 100;
              }

              return Card(
                margin: EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(item['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                          Text('Target: \$${item['target']}'),
                        ],
                      ),
                      SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: percentage / 100,
                        backgroundColor: Colors.grey[300],
                        color: Colors.blue,
                        minHeight: 8,
                      ),
                      SizedBox(height: 6),
                      Text('Saved: \$${item['saved']} / \$${item['target']}'),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => _showEditSavingDialog(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: _showAddSavingDialog,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16),
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3, // Optional: soft shadow
            ),
            child: Text(
              'Add New Saving',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

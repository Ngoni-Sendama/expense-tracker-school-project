import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalBalance(),
            SizedBox(height: 20),
            _buildIncomeExpense(),
            SizedBox(height: 20),
            _buildExpenseChart(),
            SizedBox(height: 20),
            Text('Goals',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 10),
            _buildGoalCard('Play Station', 2200, 1000),
            _buildGoalCard('Food', 200, 250),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0666EB),
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
              context, '/add'); // Navigate to Add Expense/Income page
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Color(0xFF0666EB),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.savings), label: 'Savings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _buildTotalBalance() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Balance', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 5),
            Text('\$223,876',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildIncomeExpense() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: _buildMoneyCard(
                'Income', '\$273,876', Icons.arrow_upward, Colors.green)),
        SizedBox(width: 12),
        Expanded(
            child: _buildMoneyCard(
                'Expense', '\$50,000', Icons.arrow_downward, Colors.red)),
      ],
    );
  }

  Widget _buildMoneyCard(
      String title, String amount, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.grey)),
                Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseChart() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(child: Text('Expense Chart Placeholder')),
    );
  }

  Widget _buildGoalCard(String name, double saved, double target) {
    double percentage = (saved / (saved + target)) * 100;
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 6),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[300],
              color: Color(0xFF0666EB),
            ),
            SizedBox(height: 6),
            Text(
                'Saved \$${saved.toStringAsFixed(0)} / \$${(saved + target).toStringAsFixed(0)} (${percentage.toStringAsFixed(1)}%)'),
          ],
        ),
      ),
    );
  }
}

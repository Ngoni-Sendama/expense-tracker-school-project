import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'savings.dart';
import 'wallet.dart';
import 'settings.dart';
import 'expense.dart';
import '../models/income_model.dart';
import '../models/expense_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    _HomePage(),
    SavingsPage(),
    IncomePage(),
    ExpensePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'School Expense Tracker',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0666EB),
        elevation: 2,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Color(0xFF0666EB),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.savings), label: 'Savings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: 'Wallet'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long), label: 'Expenses'),
        ],
      ),
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Accessing the IncomeModel and ExpenseModel using Provider
    final incomeModel = Provider.of<IncomeModel>(context);
    final expenseModel = Provider.of<ExpenseModel>(context);

    // Calculate total balance (Income - Expense)
    final totalBalance = incomeModel.totalIncome - expenseModel.totalExpense;
    
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalBalance(totalBalance),
            SizedBox(height: 24),
            _buildIncomeExpense(incomeModel, expenseModel),
            SizedBox(height: 24),
            _buildExpenseChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalBalance(double totalBalance) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0666EB), Color(0xFF0044AA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF0666EB).withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Balance',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 16),
              ),
              Icon(
                Icons.visibility,
                color: Colors.white.withOpacity(0.8),
                size: 20,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            '\$${totalBalance.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.arrow_upward, color: Colors.greenAccent, size: 16),
              SizedBox(width: 4),
              Text(
                '12% from last month',
                style: TextStyle(color: Colors.greenAccent, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeExpense(IncomeModel incomeModel, ExpenseModel expenseModel) {
    return Row(
      children: [
        Expanded(
          child: _buildMoneyCard(
            'Income',
            '\$${incomeModel.totalIncome.toStringAsFixed(2)}',
            Icons.arrow_upward,
            Colors.green,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: _buildMoneyCard(
            'Expense',
            '\$${expenseModel.totalExpense.toStringAsFixed(2)}',
            Icons.arrow_downward,
            Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildMoneyCard(
      String title, String amount, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          SizedBox(height: 14),
          Text(
            title,
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            amount,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseChart() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Monthly Expenses',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'April 2025',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildChartBar('Books', 0.3, Colors.blue),
                _buildChartBar('Food', 0.5, Colors.orange),
                _buildChartBar('Tech', 0.7, Colors.purple),
                _buildChartBar('Trans', 0.4, Colors.green),
                _buildChartBar('Fees', 0.6, Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar(String label, double height, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40,
          height: 150 * height,
          decoration: BoxDecoration(
            color: color.withOpacity(0.7),
            borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
        ),
      ],
    );
  }

 

 
}

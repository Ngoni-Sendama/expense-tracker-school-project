import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    _HomePage(),
    _SavingsPage(),
    _WalletPage(),
    Center(child: Text('Settings Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF0666EB),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.pushNamed(context, '/add');
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
}

class _WalletPage extends StatelessWidget {
  final List<Map<String, dynamic>> wallets = [
    {
      'icon': Icons.account_balance_wallet,
      'title': 'Cash Wallet',
      'amount': '\$5,555',
    },
    {
      'icon': Icons.remove_red_eye,
      'title': 'Goldman Sachs',
      'amount': '\$2,18,321',
    },
    {
      'icon': Icons.account_balance,
      'title': 'Chase Bank',
      'amount': '\$2,110',
    },
  ];

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
                '\$223,876',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Total Balance',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Text(
                'My Wallets',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              ...wallets.map((wallet) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color(0xFF0666EB).withOpacity(0.1),
                        child: Icon(wallet['icon'], color: Color(0xFF0666EB)),
                      ),
                      title: Text(wallet['title']),
                      subtitle: Text(wallet['amount'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  )),
              SizedBox(height: 24),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0666EB),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(Icons.link, color: Colors.white),
                label: Text(
                  'Link bank account',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue.shade800,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            alignment: Alignment.center,
            child: SafeArea(
              child: Text(
                'School Expense APP',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
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
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 10),
                _buildGoalCard('Play Station', 2200, 1000),
                _buildGoalCard('Food', 200, 250),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalBalance() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF0666EB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Balance', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 8),
          Text('\$223,876',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildIncomeExpense() {
    return Row(
      children: [
        Expanded(
            child: _buildMoneyCard(
                'Income', '\$273,876', Icons.arrow_upward, Colors.blue)),
        SizedBox(width: 12),
        Expanded(
            child: _buildMoneyCard(
                'Expense', '\$50,000', Icons.arrow_downward, Colors.red)),
      ],
    );
  }

  Widget _buildMoneyCard(
      String title, String amount, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.grey)),
                SizedBox(height: 4),
                Text(amount,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
          ),
        ],
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(name,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF0666EB).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${percentage.toStringAsFixed(1)}%',
                    style: TextStyle(
                      color: Color(0xFF0666EB),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey[300],
              color: Color(0xFF0666EB),
              minHeight: 8,
            ),
            SizedBox(height: 6),
            Text(
                'Saved \$${saved.toStringAsFixed(0)} / \$${(saved + target).toStringAsFixed(0)}'),
          ],
        ),
      ),
    );
  }
}

class _SavingsPage extends StatelessWidget {
  final List<Map<String, dynamic>> savings = [
    {'name': 'Laptop', 'saved': 1200.0, 'target': 800.0},
    {'name': 'Textbooks', 'saved': 300.0, 'target': 200.0},
    {'name': 'Groceries', 'saved': 150.0, 'target': 150.0},
    {'name': 'Trip', 'saved': 500.0, 'target': 1000.0},
    {'name': 'Gym Membership', 'saved': 100.0, 'target': 150.0},
    {'name': 'Phone', 'saved': 400.0, 'target': 600.0},
    {'name': 'Desk Chair', 'saved': 100.0, 'target': 200.0},
    {'name': 'Online Course', 'saved': 250.0, 'target': 250.0},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          alignment: Alignment.center,
          child: SafeArea(
            child: Text(
              'Savings',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: savings.length,
            itemBuilder: (context, index) {
              final item = savings[index];
              double percentage =
                  (item['saved'] / (item['saved'] + item['target'])) * 100;
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
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${percentage.toStringAsFixed(1)}%',
                              style: TextStyle(
                                  color: Colors.blue.shade800,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
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
                      Text(
                          'Saved \$${item['saved'].toStringAsFixed(0)} / \$${(item['saved'] + item['target']).toStringAsFixed(0)}'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

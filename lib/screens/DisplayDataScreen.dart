import 'package:flutter/material.dart';

import '../model/file_utils.dart';
class DisplayDataScreen extends StatefulWidget {
  const DisplayDataScreen({super.key});

  @override
  State<DisplayDataScreen> createState() => _DisplayDataScreenState();
}

class _DisplayDataScreenState extends State<DisplayDataScreen> {
  Map<String, dynamic> userData = {};
  Map<String, dynamic> budgetData = {};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final user = await FileUtils.readJson('user_data.json');
    final budget = await FileUtils.readJson('budget_data.json');
    setState(() {
      userData = user;
      budgetData = budget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('First Name: ${userData['firstName'] ?? ''}'),
            Text('Last Name: ${userData['lastName'] ?? ''}'),
            Text('Email: ${userData['email'] ?? ''}'),
            Text('Password: ${userData['password'] ?? ''}'),
            SizedBox(height: 20),
            Text('Budget Data', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Daily Budget: ${budgetData['dailyBudget'] ?? ''}'),
            Text('Monthly Budget: ${budgetData['monthlyBudget'] ?? ''}'),
            Text('Saved Amount: ${budgetData['savedAmount'] ?? ''}'),
          ],
        ),
      ),
    );
  }
}

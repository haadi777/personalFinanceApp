import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../Notification/NotificationDialog.dart';
import '../model/file_utils.dart';
import '../ui_widgets/CustomCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> userData = {};
  Map<String, dynamic> budgetData = {};
  List<Map<String, dynamic>> _expenses = [];

  @override
  void initState() {
    loadData();
    NotificationService().showNotification(100.0, 100.0);
    _updateTime();
    _updateDate();
    Timer.periodic(Duration(seconds: 1), (Timer t) => _updateTime());
    super.initState();
  }

  Future<void> loadData() async {
    final user = await FileUtils.readJson('user_data.json');
    final budget = await FileUtils.readJson('budget_data.json');
    setState(() {
      userData = user;
      budgetData = budget;
    });
  }

  String _currentTime = '';
  String _currentDate = '';
  void _updateTime() {
    final String formattedTime = DateFormat('hh:mm:ss a').format(DateTime.now());
    setState(() {
      _currentTime = formattedTime;
    });
  }

  void _updateDate() {
    final String formattedDate = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());
    setState(() {
      _currentDate = formattedDate;
    });
  }

  void _addExpense(String time, String reason, int expense) {
    setState(() {
      _expenses.add({'time': time, 'reason': reason, 'expense': expense});
    });
  }

  void _deleteExpense(int index) {
    setState(() {
      _expenses.removeAt(index);
    });
  }

  Future<void> _showAddExpenseDialog() async {
    final TextEditingController timeController = TextEditingController();
    final TextEditingController reasonController = TextEditingController();
    final TextEditingController expenseController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Expense'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(labelText: 'Time'),
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        timeController.text = picked.format(context);
                      });
                    }
                  },
                ),
                TextField(
                  controller: reasonController,
                  decoration: InputDecoration(labelText: 'Reason'),
                ),
                TextField(
                  controller: expenseController,
                  decoration: InputDecoration(labelText: 'Expense'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                final String time = timeController.text;
                final String reason = reasonController.text;
                final int expense = int.tryParse(expenseController.text) ?? 0;

                if (time.isNotEmpty && reason.isNotEmpty && expense > 0) {
                  _addExpense(time, reason, expense);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2C14DD),
              Color(0xFF1A1A3B),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0.1 * screenHeight, left: 0.03 * screenWidth),
                  child: Row(
                    children: [
                      Text('Hello ${userData['firstName'] ?? ''}', style: TextStyle(fontSize: 20, color: Colors.white),),
                      Padding(
                        padding: EdgeInsets.only(left: 0.5 * screenWidth),
                        child: InkWell(
                          onTap: () {
                            // Add your onTap functionality here
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.settings_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0.03 * screenHeight),
                  child: Container(
                    width: 0.7 * screenWidth,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 9,
                          offset: Offset(0, 9),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CircularPercentIndicator(
                          radius: 50.0,
                          lineWidth: 4.0,
                          percent: 0.5,
                          header: Text(_currentDate, style: TextStyle(fontFamily: "Roboto", fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                          center: Icon(
                            Icons.monetization_on,
                            size: 50.0,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.white,
                          progressColor: Colors.black12,
                          animation: true,
                          footer: Text('Daily Budget: ${budgetData['dailyBudget'] ?? ''}', style: TextStyle(fontFamily: "Roboto", fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0.03 * screenHeight),
                      child: Container(
                        width: 0.9 * screenWidth,
                        height: 0.1 * screenHeight,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 5,
                              blurRadius: 9,
                              offset: Offset(0, 9),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                                  child: Text('Monthly Budget: ${budgetData['monthlyBudget'] ?? ''}', style: TextStyle(fontFamily: "Roboto", fontSize: 15), ),
                                )
                              ],
                            ),
                            SizedBox(height: 9,),
                            Container(
                              width: screenWidth * 0.85,
                              child: FAProgressBar(
                                currentValue: 80,
                                displayText: '% Spent',
                                size: 20,
                                progressColor: Colors.blueAccent,
                                backgroundColor: Colors.black12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.03 * screenHeight),
                      child: Container(
                        child: Text("Expense List", style: TextStyle(color: Colors.white, fontSize: 20),),
                      ),
                    ),
                    Container(
                      height: 300, // Adjust as needed
                      child: ListView.builder(
                        itemCount: _expenses.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text('${_expenses[index]['reason']} - ${_expenses[index]['expense']}'),
                              subtitle: Text(_expenses[index]['time']),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _deleteExpense(index);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Expense',
        onPressed: _showAddExpenseDialog,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
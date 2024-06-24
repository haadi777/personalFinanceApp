import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quantity_input/quantity_input.dart';
import '../model/file_utils.dart';


import '../ui_widgets/RoundButton.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final dailyBudgetController = TextEditingController();
  final monthlyBudgetController = TextEditingController();
  final savedAmountController = TextEditingController();
  int simpleIntInput = 0;

  Future<void> saveData() async {
    final Map<String, dynamic> data = {
      'dailyBudget': dailyBudgetController.text,
      'monthlyBudget': monthlyBudgetController.text,
      'savedAmount': savedAmountController.text,
    };

    await FileUtils.writeJson('budget_data.json', data);
    print('Data saved successfully.');
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: double.infinity,
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
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80),
                Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.26),
                    child: Text(
                      "Set Budget",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                Padding(
                  padding: EdgeInsets.only(right: 200),
                  child: Text(
                    'Enter Monthly Budget',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: dailyBudgetController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: "Daily Budget Approx.",
                    hintStyle: TextStyle(color: Color(0xffb4b4b4)),
                    icon: Icon(Icons.money, color: Color(0xFFFFFFFF)),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: monthlyBudgetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Monthly Budget Approx.",
                    hintStyle: TextStyle(color: Color(0xffb4b4b4)),
                    icon: Icon(Icons.monetization_on,
                        color: Color(0xFFffffff)),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: savedAmountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Saved Amount",
                    hintStyle: TextStyle(color: Color(0xffb4b4b4)),
                    icon: Icon(Icons.savings, color: Color(0xFFffffff)),
                  ),
                ),
                SizedBox(height: 25),
                RoundButton(
                    title: "Let's Go!",
                    onTap: () {
                      saveData();
                    }),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

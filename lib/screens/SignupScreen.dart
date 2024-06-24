import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../model/file_utils.dart';
import '../ui_widgets/RoundButton.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  bool isChecked = false;
  Color color1 = Colors.blue;
  Color color2 = Colors.white;

  Future<void> saveData() async {
    final Map<String, dynamic> data = {
      'firstName': firstname.text,
      'lastName': lastname.text,
      'email': emailcontroller.text,
      'password': passwordcontroller.text,
    };

    await FileUtils.writeJson('user_data.json', data);
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
                    padding: EdgeInsets.only(right: screenWidth * 0.45),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                Padding(
                  padding: EdgeInsets.only(right: 100),
                  child: Text(
                    'Enter your details below & free sign up',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Container(
                      width: screenWidth * 0.4,
                      child: TextFormField(
                        controller: firstname,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: "First Name",
                          hintStyle: TextStyle(color: Color(0xffb4b4b4)),
                          icon: Icon(Icons.person, color: Color(0xFFFFFFFF)),
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.07),
                    Container(
                      width: screenWidth * 0.3,
                      child: TextFormField(
                        controller: lastname,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          hintText: "Last Name",
                          hintStyle: TextStyle(color: Color(0xffb4b4b4)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Color(0xffb4b4b4)),
                    icon: Icon(Icons.email, color: Color(0xFFFFFFFF)),
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Color(0xffb4b4b4)),
                    icon: Icon(Icons.password_outlined,
                        color: Color(0xFFffffff)),
                  ),
                ),
                SizedBox(height: 25),
                RoundButton(
                    title: "Sign Up",
                    onTap: () {
                      saveData();
                    }),
                SizedBox(height: 10),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyle(color: Colors.blueAccent),
                    )),
                SizedBox(height: 25),
                Image.asset(
                  'assets/images/rocket.png',
                  scale: 1.5,
                ).animate().move(
                    delay: 600.ms, duration: 600.ms) // runs after the above w/new duration
              ],
            ),
          ),
        ),
      ),
    );
  }
}

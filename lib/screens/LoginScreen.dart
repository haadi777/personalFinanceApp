import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:personalfinanceapp/screens/HomeScreen.dart';

import '../model/file_utils.dart';
import '../ui_widgets/RoundButton.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
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
  final emailcontroller = TextEditingController();
  final passwordcontroller=TextEditingController();

  bool isChecked =false;
  Color color1 = Colors.blue;
  Color color2 = Colors.white;


  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      

      body:Container(
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
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 80),
                Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.55),
                    child: Text("Login", style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold,color: Colors.white),)
                ),

                Padding(
                  padding: EdgeInsets.only(right: 100),
                  child: Text('Enter your details below & free sign up', style: TextStyle(color: Colors.grey),),
                ),
                SizedBox(height: 30,),
                TextFormField(

                  controller: emailcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0) ,
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(color:  Color(0xffb4b4b4)),
                    icon: Icon(Icons.email,color:  Color(0xFFFFFFFF)),
                  ),
                ),
                SizedBox(height: 30,),
                TextFormField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color:Colors.blueAccent),
                      borderRadius: BorderRadius.circular(15.0) ,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(color:  Color(0xffb4b4b4)),
                    icon: Icon(Icons.password_outlined, color:  Color(0xFFffffff),),
                  ),
                ),
                SizedBox(height: 25,),
                RoundButton(

                    title: "Sign Up", onTap: () {
                              if (userData['email'] == emailcontroller.text || userData['password'] == passwordcontroller.text){
                                Get.off(HomeScreen());

                              }
                              else{
                                Fluttertoast.showToast(
                                    msg: "Either Email or Password is invalid",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                              }

                }),
                SizedBox(height: 10,),


                TextButton(onPressed: (){
                  }, child: Text('Terms & Conditions',style: TextStyle(color: Colors.blueAccent),)),

                SizedBox(height: 25,),
                Image.asset('assets/images/rocket.png').animate().move(delay: 600.ms, duration: 600.ms) // runs after the above w/new duration

              ],
            ),
          ),
          //TextButton(onPressed: (){}, child: Text('Terms & Conditions',style: TextStyle(color: Colors.blueAccent),))

        ),
      ),

    );
  }
}

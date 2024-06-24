import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../Notification/NotificationDialog.dart';
class CustomCard extends StatefulWidget {
  final int budget;
  final String reason;
  final String time;


  const CustomCard({super.key,
    required this.budget,
    required this.reason, required this.time,


  });
  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Padding(

        padding:EdgeInsets.only(top: 0.03 * screenHeight),

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
              offset: Offset(0, 9), // changes position of shadow
            ),
          ],

        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            children: [
              Column(

                children: [
                  Row(
                    children: [
                      Text("Reason: " + widget.reason , style: TextStyle(fontFamily: "Roboto", fontSize: 15), )

                    ],
                  ),
                  Row(

                    children: [
                      Text( widget.budget < 0 ? widget.budget.toString() + "/-" : "+" + widget.budget.toString()+  "/-",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 21, color: widget.budget < 0 ? Colors.red : Colors.green,),
                      )
                    ],
                  ),

                ],
              ),
              Padding(
                padding: EdgeInsets.only(left:0.1 * screenWidth),
                child: InkWell(
                  onTap: () {

                    // Add your onTap functionality here
                  },
                  child: Container(
                    height: 40,  // Adjusted size for better icon visibility
                    width: 40,   // Adjusted size for better icon visibility
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),  // Rounded borders
                    ),
                    child: Center(
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 24,  // Adjust size as needed
                      ),
                    ),
                  ),
                ),
              )


            ],
          ),
        ),
      ).animate().fade(duration: 500.ms),
    );
  }
}

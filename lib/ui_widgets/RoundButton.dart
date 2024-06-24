import 'package:flutter/material.dart';


class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const RoundButton({super.key,
    required this.title,
    required this.onTap,
    this.loading =false

  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child :Container(
        height: 0.07 * screenHeight,
        decoration: BoxDecoration(

          color:  Color(0xFF4B72F5),

          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Center(child: SizedBox(

            child: loading ? CircularProgressIndicator(strokeWidth: 3,color: Colors.white,) :
            Text(title,style: TextStyle(color: Colors.white),),
          ),),


        ),
      ),
    );




  }
}


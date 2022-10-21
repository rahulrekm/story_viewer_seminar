import 'package:flutter/material.dart';

class Animated_Bar extends StatelessWidget{

  late AnimationController animationController;
  late int position;
  late int currentIndex;

   Animated_Bar({

    required this.animationController,
    required this.position,
    required this.currentIndex,
}) ;
  @override
  Widget build(BuildContext context) {
     return Flexible(
         child: Padding(
           padding: EdgeInsets.symmetric(horizontal: 1.5),
           child: LayoutBuilder(
             builder: (context , constraints ) {
               return Stack(
                 children: <Widget>[
                   _buildContainer(
                     double.infinity,
                     position  < currentIndex ? Colors.white : Colors.white.withOpacity(0.5),
                   ),
                   position == currentIndex ?
                       AnimatedBuilder(
                           animation: animationController,
                           builder: (context,child){
                             return _buildContainer(
                               constraints.maxWidth*animationController.value, Colors.white,
                             );
                           }
                       ) : const SizedBox.shrink(),
                 ],
               );
             },

           ),
         ));
  }

  Container _buildContainer(double width, Color color){
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }

}
import 'package:flutter/material.dart';

class BottomCard extends StatelessWidget {
  const BottomCard({Key? key,required this.color,required this.text, required this.icon, required this.textStyle, required this.selected, required this.spacing}) : super(key: key);
  final Color color;
  final String text;
  final IconData? icon;
  final TextStyle textStyle;
  final bool selected;
  final double spacing;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.09,
      width: MediaQuery.of(context).size.width*0.15,
      decoration: BoxDecoration(
        color: selected?Colors.blue:color,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: selected?Colors.white:null,size: 25.0,),
          SizedBox(height: spacing,),
          Text(text,style:textStyle,),
        ],
      ),
    );
  }
}

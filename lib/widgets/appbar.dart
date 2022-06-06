import 'package:flutter/material.dart';
import 'package:mudra/theme.dart';

class Appbar extends StatefulWidget {
  const Appbar({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<Appbar> createState() => _AppbarState();
}

class _AppbarState extends State<Appbar> {
  AppTheme appTheme=AppTheme();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height*0.07,
        color:appTheme.backcolor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                child: Image.asset('assets/images/user.jpeg',width: 50.0,)),
            Text(widget.title,style: appTheme.fontWeightW100(25.0),),
            const Icon(Icons.notifications,color: Colors.white,size: 30.0,),
          ],),
    );
  }
}

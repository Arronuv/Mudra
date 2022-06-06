import 'package:flutter/material.dart';
import 'package:mudra/helper.dart';
import 'package:mudra/theme.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

   AppTheme themeData= AppTheme();
   late Helper helper;


   void initSate(){
     helper= Provider.of<Helper>(context,listen: false);
     super.initState();
     init();
   }

   void init() async{
   }


  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 4),(){
      Navigator.pushNamed(context, '/home');
    });


    return Scaffold(
      body: Container(color:themeData.splashColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Image.asset('assets/images/splash.png',height: 200,width: 200,),
                  CircularProgressIndicator(color:themeData.backcolor,),
                  const SizedBox(height: 20.0,),
                  Text("Getting Rates...",style: themeData.fontWeightW100(25.0),),
              ],
            ),
          ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mudra/Screens/Charts.dart';
import 'package:mudra/Screens/convert.dart';
import 'package:mudra/theme.dart';
import 'package:mudra/widgets/bottombarcard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  AppTheme appTheme= AppTheme();
  List<String> pagesNames=["Convert","Charts","Sent","Track","More"];
  List<IconData> pagesIcons=[Icons.currency_exchange,Icons.bar_chart,Icons.telegram,Icons.location_on_outlined,Icons.more_horiz];
  List screens=[const Convert(),const Chart()];
  int selected=0;


  @override
  Widget build(BuildContext context) {
    List<Widget> pageButtons=[];
    for(int i=0;i<pagesNames.length;i++) {
      pageButtons.add(
          InkWell(
            splashColor: Colors.transparent,
            onTap: (){
              setState((){
                selected=i;
              });
            },
            child: BottomCard(color: appTheme.foreground,
                text: pagesNames[i],
                icon: pagesIcons[i],
                textStyle: appTheme.fontNavBar,
                selected: i==selected?true:false,
                spacing: 5.0),
          )
      );
      //pageButtons.add(const SizedBox(width: 10.0,));
    }

     return Scaffold(
       bottomNavigationBar: Padding(
         padding: const EdgeInsets.all(10.0),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: pageButtons,
         ),
       ),
      backgroundColor: appTheme.backcolor,
      body:screens[selected%screens.length],
     );
  }



}

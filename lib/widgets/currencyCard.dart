import 'package:flutter/material.dart';

import '../Class/currencydata.dart';
import '../theme.dart';


class currencyCard extends StatelessWidget {
  const currencyCard({
    Key? key,
    required this.appTheme,
    required this.cd,
    required this.item,
    this.converted=0.0,
    this.conversion="",
    required this.baseCurrency,
  }) : super(key: key);

  final AppTheme appTheme;
  final CurrencyData cd;
  final dynamic item;
  final double converted;
  final String conversion;
  final String baseCurrency;

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: appTheme.inactive,
        borderRadius: BorderRadius.circular(30.0),
      ),
      height: MediaQuery.of(context).size.height*0.1,
      width: MediaQuery.of(context).size.width,
      child:Row(
        children: [
          const SizedBox(width: 20.0,),
          DropdownButton(
              hint: item,
              underline: Container(),
              dropdownColor: appTheme.inactive,
              style: appTheme.fontWeightW100(20.0),
              focusColor: appTheme.inactive,
              items: const [],
              onChanged: null),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text("${cd.symbol} ${converted.toStringAsFixed(3)}",style: appTheme.fontWeightW100(25.0),),
            Text("1 $baseCurrency = ${conversion+cd.currency}",style: appTheme.sub,)
          ]),
          const Spacer(),
          Container(
            height:MediaQuery.of(context).size.height*0.1,
            width: MediaQuery.of(context).size.width*0.2,
            decoration: BoxDecoration(
              color: appTheme.foreground,
              borderRadius: const BorderRadius.only(topRight:Radius.circular( 30.0),bottomRight:Radius.circular( 30.0)),
            ),
            child: IconButton(
              onPressed: (){},
              icon: const Icon(Icons.more_vert_sharp,color: Colors.white,size: 30.0,),
            ),
          ) ],
      ),
    );
  }
}

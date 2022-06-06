import 'package:flutter/material.dart';
import 'package:mudra/helper.dart';
import 'package:mudra/theme.dart';
import 'package:mudra/widgets/appbar.dart';
import 'package:provider/provider.dart';

import '../widgets/currencyCard.dart';
import '../widgets/dropDown.dart';

class Convert extends StatefulWidget {
  const Convert({Key? key}) : super(key: key);

  @override
  State<Convert> createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {

  late AppTheme appTheme;
  late Helper helper;
  String dropValue='';
  dynamic value;
  late TextEditingController amount;
  String symbol='';
  bool loading=false;


  @override
  initState(){
    amount= TextEditingController();
    amount.text="0.0";
    appTheme = AppTheme();
    helper=Provider.of<Helper>(context,listen: false);
    helper.loadCurrency();
    helper.loadDropDownitems(helper);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.backcolor,
      body: Padding(
        padding: const EdgeInsets.only(top:20.0,left: 10.0,right: 10.0),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                  child: ListView(children:getBody())),
              loading?Container(
                color: Colors.black12,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              ):Container(),
               const Appbar(title: 'Convert'),
            ],
          )
      ),
    );
  }

  List<Widget> getBody(){
    List<Widget> list=[];


    list.add(Padding(padding: EdgeInsets.all(10.0),child: Text("Last updated: ${helper.date}",style: appTheme.fontWeightW100(15.0),),));
    list.add(                                  //active card
        Container(
            decoration: BoxDecoration(
              color: appTheme.foreground,
              borderRadius: BorderRadius.circular(30.0),
            ),
          height: MediaQuery.of(context).size.height*0.1,
          width: MediaQuery.of(context).size.width,
          child:Row(
            children: [
              const SizedBox(width: 10.0,),
              DropDown(appTheme: appTheme, helper: helper, value: value,callback: (dynamic s){
                setState((){
                  helper.conversions=[];
                  helper.selectedCurrency=s;
                  value=s;
                  symbol=helper.currencySymbol[helper.currencyNames.indexOf(helper.selectedCurrency)];
                });
              },),
              const SizedBox(width: 65.0,),
              Text(symbol,style: appTheme.fontWeightW100(20.0),),
              const SizedBox(width: 5.0,),
              SizedBox(
                width: 100.0,
                child: TextFormField(
                  maxLength: 5,
                  controller: amount,
                  keyboardType: TextInputType.number,
                  style: appTheme.fontWeightW100(20.0),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterText: ''
                  ),
                ),
              ),
              const Spacer(),

              Container(
                height:MediaQuery.of(context).size.height*0.1,
                width: MediaQuery.of(context).size.width*0.2,
                decoration: BoxDecoration(
                  color: appTheme.inactive,
                  borderRadius: const BorderRadius.only(topRight:Radius.circular( 30.0),bottomRight:Radius.circular( 30.0)),
                ),
                child: IconButton(
                  onPressed: () async{
                    if(helper.selectedCurrency.isNotEmpty) {
                      if (amount.text.isNotEmpty) {
                        setState(() {
                          loading = true;
                        });
                        var res = await helper.getRates(
                            helper.selectedCurrency, helper);
                        setState(() {
                          loading = false;
                        });

                        if (res != null) {
                          helper.messageShow(context, false, res.toString());
                        }
                      }
                    }else if(helper.selectedCurrency.isEmpty){
                      helper.messageShow(context, false, "Select Currency");
                    }
                  },
                  icon: const Icon(Icons.calculate_outlined,color: Colors.white,size: 40.0,),
              ),
              ) ],
          ),

        )
    );

    list.add(Divider(height: 30.0,color: appTheme.inactive,thickness: 3.0,));

    try {
      for (int i = 0; i < helper.cd.length; i++) {
        if (helper.selectedCurrency != helper.cd[i].currency) {
          list.add(currencyCard(
              baseCurrency: helper.selectedCurrency,
              conversion: helper.conversions.isNotEmpty ? helper
                  .conversions[i][helper.currencyNames[i]].toString() : '',
              converted: helper.conversions.isNotEmpty && amount.text.isNotEmpty
                  ? helper.conversions[i][helper.currencyNames[i]]! *
                  double.parse(amount.text)
                  : 0.0,
              item: helper.dropItems[i],
              appTheme: appTheme,
              cd: helper.cd[i]));
          list.add(const SizedBox(height: 10.0,));
        }
      }
    }catch(e){
      WidgetsBinding.instance.addPostFrameCallback((_){
        helper.messageShow(context, true, e.toString());
      });

    }

    return list;
  }


}





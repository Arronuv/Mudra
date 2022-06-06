import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mudra/Class/chartclass.dart';
import 'package:mudra/Class/currencydata.dart';
import 'package:mudra/theme.dart';

class Helper with ChangeNotifier {
  List<String> currencyNames = [
    'UAH',
    'USD',
    'EUR',
    'GBR',
    'JPY'
  ]; //list of currency
  List<String> currencySymbol = [
    '₴',
    "\$",
    '€',
    '£',
    '¥'
  ]; //list of currency symbol in order
  List<CurrencyData> cd = []; //currency data
  List<ChartData> points = []; //chart points
  List<DropdownMenuItem> dropItems = []; // dropdown items list
  AppTheme appTheme = AppTheme();
  List<Map<String, double>> conversions = [];
  dynamic chartCurrency1 = '';
  dynamic chartCurrency2 = '';
  String selectedCurrency = '';
  String chartConversion = '';
  String date = 'NA';

  double lowestrate=5.0;
  double highestrate=1.0;

  loadCurrency() {
    cd = [];
    for (int i = 0; i < currencyNames.length; i++) {
      cd.add(CurrencyData(
          symbol: currencySymbol[i],
          currency: currencyNames[i],
          imagePath: 'assets/images/flags/${currencyNames[i]}.png'));
    }
  }

  loadDropDownitems(Helper helper) {
    // generating dropdown items
    dropItems = [];
    for (CurrencyData cd in helper.cd) {
      dropItems.add(DropdownMenuItem(
          value: cd.currency,
          child: SizedBox(
            height: 100.0,
            width: 90.0,
            child: Row(
              children: [
                Expanded(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          cd.imagePath,
                          fit: BoxFit.contain,
                          height: 50.0,
                          width: 50.0,
                        ))),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  cd.currency,
                  style: appTheme.fontWeightW100(20.0),
                ),
              ],
            ),
          )));
    }
  }

  Future<String?> getRates(String base, Helper helper) async {
    conversions = [];
    try {
      var url = Uri.parse('https://api.exchangerate.host/latest?base=$base');
      var response = await http.get(url);
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      for (String s in helper.currencyNames) {
        helper.conversions.add({
          s: jsonResponse['rates'][s] != null
              ? double.parse(jsonResponse['rates'][s].toString())
              : 1.0,
        });
      }
      helper.date = jsonResponse['date'].toString();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> getSpecificRate(Helper helper) async {
    conversions = [];
    try {
      var url = Uri.parse(
          'https://api.exchangerate.host/convert?from=${helper.chartCurrency1}&to=${helper.chartCurrency2}');
      var response = await http.get(url);
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      helper.chartConversion = jsonResponse['info']['rate'].toString();
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> loadChartPoints(Helper helper) async {
    String endDate = DateTime.now().toString().substring(0, 10);
    String startDate = DateTime.now()
        .subtract(const Duration(days: 182))
        .toString()
        .substring(0, 10);
    points = [];
    try {
      var url = Uri.parse(
          'https://api.exchangerate.host/timeseries?start_date=$startDate&end_date=$endDate&base=${helper.chartCurrency1}&symbols=${helper.chartCurrency2}');
      var response = await http.get(url);
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      double i = 0.0;
      jsonResponse['rates'].forEach((K, V) {
        if(double.parse(V['${helper.chartCurrency2}'].toString())>highestrate){
          highestrate=double.parse(V['${helper.chartCurrency2}'].toString());
        }
        helper.points.add(
            ChartData(x:i, y: double.parse(V['${helper.chartCurrency2}'].toString()))
        );
            i++;
      });
      helper.lowestrate=i;

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  void messageShow(BuildContext context, bool good, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: good ? Colors.blue : Colors.red,
        content: SizedBox(
          height: 15,
          child: Center(
            child: Text(text),
          ),
        )));
  }
}

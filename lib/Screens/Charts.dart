import 'package:flutter/material.dart';
import 'package:mudra/Class/chartclass.dart';
import 'package:mudra/widgets/dropDown.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../helper.dart';
import '../theme.dart';
import '../widgets/appbar.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late AppTheme appTheme;
  bool loading = false;
  late Helper helper;
  dynamic value1;
  dynamic value2;

  @override
  initState() {
    appTheme = AppTheme();
    helper = Helper();
    helper.loadCurrency();
    helper.loadDropDownitems(helper);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: Scaffold(
          backgroundColor: appTheme.backcolor,
          body: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: ListView(children: getBody())),
              loading
                  ? Container(
                      color: Colors.black12,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      ),
                    )
                  : Container(),
              const Appbar(title: 'Charts'),
            ],
          )),
    );
  }

  List<Widget> getBody() {
    List<Widget> list = [];

    list.add(SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: appTheme.foreground,
                    borderRadius: BorderRadius.circular(30.0)),
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Center(
                  child: DropDown(
                    appTheme: appTheme,
                    value: value1,
                    callback: (dynamic s) {
                      setState(() {
                        helper.chartCurrency1 = s;
                        value1 = s;
                      });
                      loadPoints();
                      getConversion();
                    },
                    helper: helper,
                  ),
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Icon(
                  Icons.compare_arrows_outlined,
                  size: 35.0,
                  color: Colors.white,
                )),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: appTheme.foreground,
                    borderRadius: BorderRadius.circular(30.0)),
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Center(
                    child: DropDown(
                  appTheme: appTheme,
                  value: value2,
                  callback: (dynamic s) {
                    setState((){
                      helper.chartCurrency2 = s;
                      value2 = s;
                    });
                    loadPoints();
                    getConversion();
                  },
                  helper: helper,
                )),
              ),
            ),
          ],
        ),
      ),
    ));

    list.add(Container(
      padding: const EdgeInsets.only(right: 25.0, left: 25.0),
      child: Row(
        children: [
          Text(
            "1 ${helper.chartCurrency1} = ${helper.chartConversion} ${helper.chartCurrency2}",
            style: appTheme.fontWeightW100(23.0),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.upload_sharp,
              size: 35.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ));
    list.add(SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: SfCartesianChart(
        borderColor: appTheme.backcolor,
        backgroundColor: appTheme.backcolor,
          primaryXAxis: CategoryAxis(
            borderColor: appTheme.backcolor,
            isVisible: false,
          ),
          plotAreaBackgroundColor: appTheme.backcolor,
          plotAreaBorderColor: appTheme.backcolor,
          palette: const [Colors.blue],
          series: <LineSeries<ChartData, double>>[
            LineSeries<ChartData, double>(
                dataSource: helper.points,
                xValueMapper: (ChartData sales, _) => sales.x,
                yValueMapper: (ChartData sales, _) => sales.y
            )
          ]
      )
    ));

    return list;
  }

  getConversion() async {
    if (helper.chartCurrency1.isNotEmpty && helper.chartCurrency2.isNotEmpty) {
      setState(() {
        loading = true;
      });
      var res = await helper.getSpecificRate(helper);
      setState(() {
        loading = false;
      });

      if (res != null) {
        //helper.messageShow(context, false, res.toString());
      }
    }
  }

  loadPoints() async {
    if (helper.chartCurrency1.isNotEmpty && helper.chartCurrency2.isNotEmpty) {
      setState(() {
        loading = true;
      });
      var res = await helper.loadChartPoints(helper);
      setState(() {
        loading = false;
      });
      if (res != null) {
        //helper.messageShow(context, false, res.toString());
      }
    }
  }


}

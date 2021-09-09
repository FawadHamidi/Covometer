import 'package:covometer/models/corona_graph_model.dart';
import 'package:covometer/providers/api_provider.dart';
import 'package:covometer/utilis/pallete.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class GraphsScreen extends StatefulWidget {
  @override
  _GraphsScreenState createState() => _GraphsScreenState();
}

class _GraphsScreenState extends State<GraphsScreen> {
  var _tooltipBehaviorCases = TooltipBehavior(enable: true);
  var _tooltipBehaviorDeaths = TooltipBehavior(enable: true);
  var _tooltipBehaviorRecovered = TooltipBehavior(enable: true);
  Future? future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<ApiProvider>(context, listen: false);
    provider.loadCoronaGraphs();
    // var dmyString = '23/4/1999';
    // var dateTime1 = DateFormat('d/M/yyyy').parse(dmyString).day.toString();
    // print(dateTime1);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ApiProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    return Consumer<ApiProvider>(
      builder: (context, provider, child) {
        // List<dynamic> cases = provider.coronaGraphModel!.timeline!.cases;
        return provider.coronaGraphModel != null
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Graphs',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Row(
                          children: [
                            Text(
                              provider.countryName.toUpperCase(),
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(
                                  provider.countryModel!.countryInfo!.flag ??
                                      ''),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kWhite,
                    ),
                    height: 200,
                    width: size.width - 20,
                    child: SfCartesianChart(
                      title: ChartTitle(
                          text: 'Last 7 days Cases',
                          textStyle: Theme.of(context).textTheme.headline6),
                      tooltipBehavior: _tooltipBehaviorCases,
                      primaryXAxis: CategoryAxis(
                        labelPlacement: LabelPlacement.onTicks,
                        // isVisible: true,
                      ),
                      primaryYAxis:
                          NumericAxis(numberFormat: NumberFormat.compact()),
                      series: <SplineAreaSeries<Case, String>>[
                        SplineAreaSeries(
                            animationDuration: 2000,
                            name: 'Cases',
                            color: kOrange,
                            dataSource:
                                provider.coronaGraphModel!.timeline!.cases,
                            enableTooltip: true,
                            splineType: SplineType.cardinal,
                            cardinalSplineTension: 0.9,
                            xValueMapper: (Case cases, _) =>
                                DateFormat('M/d/yy')
                                    .parse(cases.date)
                                    .day
                                    .toString(),
                            yValueMapper: (Case cases, _) =>
                                num.parse(cases.cases.toString()))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kWhite,
                    ),
                    height: 200,
                    width: size.width - 20,
                    child: SfCartesianChart(
                      title: ChartTitle(
                          text: 'Last 7 days Deaths',
                          textStyle: Theme.of(context).textTheme.headline6),
                      tooltipBehavior: _tooltipBehaviorDeaths,
                      primaryXAxis: CategoryAxis(
                        labelPlacement: LabelPlacement.onTicks,
                        // isVisible: true,
                      ),
                      primaryYAxis:
                          NumericAxis(numberFormat: NumberFormat.compact()),
                      series: <SplineAreaSeries<Death, String>>[
                        SplineAreaSeries(
                            animationDuration: 2000,
                            name: 'Deaths',
                            color: kRed,
                            dataSource:
                                provider.coronaGraphModel!.timeline2!.deaths,
                            enableTooltip: true,
                            splineType: SplineType.cardinal,
                            cardinalSplineTension: 0.9,
                            xValueMapper: (Death deaths, _) =>
                                DateFormat('M/d/yy')
                                    .parse(deaths.date)
                                    .day
                                    .toString(),
                            yValueMapper: (Death deaths, _) =>
                                num.parse(deaths.deaths.toString()))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kWhite,
                    ),
                    height: 200,
                    width: size.width - 20,
                    child: SfCartesianChart(
                      enableAxisAnimation: true,
                      title: ChartTitle(
                          text: 'Last 7 days Recovered',
                          textStyle: Theme.of(context).textTheme.headline6),
                      tooltipBehavior: _tooltipBehaviorRecovered,
                      primaryXAxis: CategoryAxis(
                        labelPlacement: LabelPlacement.onTicks,
                        // isVisible: true,
                      ),
                      primaryYAxis:
                          NumericAxis(numberFormat: NumberFormat.compact()),
                      series: <SplineAreaSeries<Recovered, String>>[
                        SplineAreaSeries(
                            animationDuration: 2000,
                            name: 'Recovered',
                            color: kGreen,
                            dataSource:
                                provider.coronaGraphModel!.timeline3!.recovered,
                            enableTooltip: true,
                            splineType: SplineType.cardinal,
                            cardinalSplineTension: 0.9,
                            xValueMapper: (Recovered recovered, _) =>
                                DateFormat('M/d/yy')
                                    .parse(recovered.date)
                                    .day
                                    .toString(),
                            yValueMapper: (Recovered recovered, _) =>
                                num.parse(recovered.recovered.toString()))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

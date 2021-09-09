import 'package:covometer/providers/api_provider.dart';
import 'package:covometer/services/api_services.dart';
import 'package:covometer/utilis/pallete.dart';
import 'package:covometer/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ApiServices().getGraphs(countryName: 'india');
    var allCasesProvider = Provider.of<ApiProvider>(context, listen: false);
    allCasesProvider.loadAllCases();
    var size = MediaQuery.of(context).size;
    return Consumer<ApiProvider>(
      builder: (context, allCasesProvider, child) {
        return allCasesProvider.coronaCases != null
            ? SafeArea(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Statistics',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'All World',
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                  ),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Container(
                                    child: Icon(
                                      Icons.public,
                                      color: kWhite,
                                    ),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CustomCard(
                          height: size.width / 3.5,
                          width: size.width - 60,
                          color: kOrange,
                          title: 'Affected',
                          casesNumber: allCasesProvider.coronaCases!.cases
                              .toString()
                              .replaceAllMapped(
                                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},'),
                          textStyle: Theme.of(context).textTheme.headline2,
                          textStyle2: Theme.of(context).textTheme.headline3,
                        ),
                        CustomCard(
                          height: size.width / 3.5,
                          width: size.width - 60,
                          color: kRed,
                          title: 'Death',
                          casesNumber: allCasesProvider.coronaCases!.deaths
                              .toString()
                              .replaceAllMapped(
                                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},'),
                          textStyle: Theme.of(context).textTheme.headline2,
                          textStyle2: Theme.of(context).textTheme.headline3,
                        ),
                        CustomCard(
                          height: size.width / 3.5,
                          width: size.width - 60,
                          color: kGreen,
                          title: 'Recovered',
                          casesNumber: allCasesProvider.coronaCases!.recovered
                              .toString()
                              .replaceAllMapped(
                                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},'),
                          textStyle: Theme.of(context).textTheme.headline2,
                          textStyle2: Theme.of(context).textTheme.headline3,
                        ),
                        CustomCard(
                          height: size.width / 3.5,
                          width: size.width - 60,
                          color: kBlue,
                          title: 'Active',
                          casesNumber: allCasesProvider.coronaCases!.active
                              .toString()
                              .replaceAllMapped(
                                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},'),
                          textStyle: Theme.of(context).textTheme.headline2,
                          textStyle2: Theme.of(context).textTheme.headline3,
                        ),
                        CustomCard(
                          height: size.width / 3.5,
                          width: size.width - 60,
                          color: kPurple,
                          title: 'Serious',
                          casesNumber: allCasesProvider.coronaCases!.critical
                              .toString()
                              .replaceAllMapped(
                                  new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},'),
                          textStyle: Theme.of(context).textTheme.headline2,
                          textStyle2: Theme.of(context).textTheme.headline3,
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}

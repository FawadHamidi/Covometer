import 'package:covometer/providers/api_provider.dart';
import 'package:covometer/utilis/pallete.dart';
import 'package:covometer/widgets/custom_card.dart';
import 'package:covometer/widgets/custom_card2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _countryNameController = TextEditingController();
  TabController? _tabController;
  int selectedIndex = 0;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    var provider = Provider.of<ApiProvider>(context, listen: false);
    provider.loadCountryCases();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<ApiProvider>(context, listen: false);

    return Consumer<ApiProvider>(
      builder: (context, model, child) {
        return model.countryModel != null
            ? SingleChildScrollView(
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
                                  provider.countryName.toUpperCase(),
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                CircleAvatar(
                                  radius: 12,
                                  backgroundImage: NetworkImage(
                                      model.countryModel!.countryInfo!.flag ??
                                          ''),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: kTextFieldColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: TextField(
                          style: Theme.of(context).textTheme.headline4,
                          onSubmitted: (value) {
                            value = _countryNameController.text;
                            provider.countryName = value;
                            provider.loadCountryCases();
                          },
                          controller: _countryNameController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: kWhite.withOpacity(0.4),
                              ),
                              border: InputBorder.none,
                              hintText: 'Search Country',
                              hintStyle: TextStyle(
                                color: kWhite.withOpacity(0.4),
                              )),
                        ),
                      ),
                      Container(
                        child: DefaultTabController(
                          length: 3,
                          initialIndex: 0,
                          child: TabBar(
                            unselectedLabelColor: kWhite.withOpacity(0.4),
                            labelColor: kWhite,
                            indicatorColor: kWhite,
                            indicatorPadding:
                                EdgeInsets.symmetric(horizontal: 30),
                            tabs: [
                              Tab(
                                text: 'Total',
                              ),
                              Tab(
                                text: 'Today',
                              ),
                              Tab(
                                text: 'Yesterday',
                              ),
                            ],
                            controller: _tabController,
                            onTap: (index) {
                              setState(() {
                                selectedIndex = index;
                                _tabController!.animateTo(index);
                              });
                              if (selectedIndex == 2) {
                                provider.loadCountryCases(isYesterday: true);
                              } else {
                                provider.loadCountryCases(isYesterday: false);
                              }
                            },
                          ),
                        ),
                      ),
                      IndexedStack(
                        children: [
                          Visibility(
                            maintainState: true,
                            visible: selectedIndex == 0,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kOrange,
                                          title: 'Affected',
                                          casesNumber: model.countryModel!.cases
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kRed,
                                          title: 'Death',
                                          casesNumber: model
                                              .countryModel!.deaths
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kGreen,
                                          title: 'Recovered',
                                          casesNumber: model
                                              .countryModel!.recovered
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kBlue,
                                          title: 'Active',
                                          casesNumber: model
                                              .countryModel!.active
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kPurple,
                                          title: 'Serious',
                                          casesNumber: model
                                              .countryModel!.critical
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            maintainState: true,
                            visible: selectedIndex == 1,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kOrange,
                                          title: 'Affected',
                                          casesNumber: model
                                              .countryModel!.todayCases
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kRed,
                                          title: 'Death',
                                          casesNumber: model
                                              .countryModel!.todayDeaths
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kGreen,
                                          title: 'Recovered',
                                          casesNumber: model
                                              .countryModel!.todayRecovered
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kBlue,
                                          title: 'Active',
                                          casesNumber: model
                                              .countryModel!.active
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kPurple,
                                          title: 'Serious',
                                          casesNumber: model
                                              .countryModel!.critical
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            maintainState: true,
                            visible: selectedIndex == 2,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kOrange,
                                          title: 'Affected',
                                          casesNumber: model
                                              .countryModel!.todayCases
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kRed,
                                          title: 'Death',
                                          casesNumber: model
                                              .countryModel!.todayDeaths
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kGreen,
                                          title: 'Recovered',
                                          casesNumber: model
                                              .countryModel!.todayRecovered
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kBlue,
                                          title: 'Active',
                                          casesNumber: model
                                              .countryModel!.active
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CustomizableCard(
                                          width: 200,
                                          height: 120,
                                          color: kPurple,
                                          title: 'Serious',
                                          casesNumber: model
                                              .countryModel!.critical
                                              .toString()
                                              .replaceAllMapped(
                                                  new RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match m) => '${m[1]},'),
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                          textStyle2: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                        index: selectedIndex,
                      )
                    ],
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

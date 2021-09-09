import 'package:covometer/models/corona_country_model.dart';
import 'package:covometer/models/corona_graph_model.dart';
import 'package:covometer/models/corona_model.dart';
import 'package:covometer/services/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ApiProvider extends ChangeNotifier {
  CoronaCases? coronaCases;
  CountryModel? countryModel;
  CoronaGraphModel? coronaGraphModel;
  String countryName = "USA";

  loadAllCases() async {
    coronaCases = await ApiServices().getAllCases();
    notifyListeners();
    return coronaCases;
  }

  loadCountryCases({bool isYesterday = false}) async {
    countryModel = await ApiServices()
        .getCountryCases(countryName: countryName, isYesterday: isYesterday);
    notifyListeners();
    return countryModel;
  }

  loadCoronaGraphs() async {
    coronaGraphModel = await ApiServices().getGraphs(
      countryName: countryName,
    );
    notifyListeners();
    // print(coronaGraphModel!.timeline!.cases.length);
    return coronaGraphModel;
  }
}

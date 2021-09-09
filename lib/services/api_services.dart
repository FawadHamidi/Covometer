import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:covometer/models/corona_country_model.dart';
import 'package:covometer/models/corona_graph_model.dart';
import 'package:covometer/models/corona_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiServices {
  Future<CoronaCases?> getAllCases() async {
    CoronaCases? coronaModel;
    try {
      String url = 'https://corona.lmao.ninja/v2/all';
      var response = await Dio().get(url);
      if (response.statusCode == 200) {
        coronaModel = CoronaCases.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        print(e.response!.statusCode);
      } else {
        print(e.message);
        print(e.response);
      }
    }
    // print(coronaModel?.cases);
    return coronaModel;
  }

  Future<CountryModel?> getCountryCases(
      {String? countryName, bool? isYesterday}) async {
    CountryModel? responseModel;
    try {
      String url =
          'https://corona.lmao.ninja/v2/countries/$countryName?yesterday=$isYesterday';
      var response = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));

      if (response.statusCode == 200) {
        responseModel = CountryModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        print(e.response!.statusCode);
      } else {
        print(e.message);
        print(e.response);
      }
    }
    print(responseModel!.country);
    return responseModel;
  }

  Future<CoronaGraphModel?> getGraphs({
    String? countryName,
  }) async {
    CoronaGraphModel? responseModel;
    try {
      String url =
          'https://corona.lmao.ninja/v2/historical/$countryName?lastdays=7';
      var response = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));

      if (response.statusCode == 200) {
        responseModel = CoronaGraphModel.fromJson(response.data);
        print(responseModel.timeline2!.deaths[0].deaths);
        print(responseModel.timeline!.cases[0].cases);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        print(e.response!.statusCode);
      } else {
        print(e.message);
        print(e.response);
      }
    }
    // print(responseModel);
    return responseModel;
  }
}

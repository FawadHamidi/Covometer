class CoronaGraphModel {
  String? country;

  Timeline? timeline;
  Timeline? timeline2;
  Timeline? timeline3;
  CoronaGraphModel({
    this.country,
    this.timeline,
    this.timeline2,
    this.timeline3,
  });
  CoronaGraphModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    timeline =
        Timeline.fromJson((json['timeline']['cases'] as Map).entries.toList());
    timeline2 =
        Timeline.fromJson((json['timeline']['deaths'] as Map).entries.toList());
    timeline3 = Timeline.fromJson(
        (json['timeline']['recovered'] as Map).entries.toList());
  }
  Map<String, dynamic>? toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = country;
    data['timeline'] = timeline;
    data['timeline'] = timeline2;
    data['timeline'] = timeline3;
  }
}

class Timeline {
  Timeline({
    required this.cases,
    required this.deaths,
    required this.recovered,
  });

  factory Timeline.fromJson(List<MapEntry<dynamic, dynamic>> data) {
    var c = data.map((element) {
      return Case(cases: element.value, date: element.key);
    }).toList();
    var d = data.map((e) {
      return Death(deaths: e.value, date: e.key);
    }).toList();
    var r = data.map((e) {
      return Recovered(recovered: e.value, date: e.key);
    }).toList();
    return Timeline(cases: c, deaths: d, recovered: r);
  }

  List<Case> cases;
  List<Death> deaths;
  List<Recovered> recovered;
}

class Case {
  String date;
  var cases;

  Case({required this.date, required this.cases});
}

class Death {
  String date;
  var deaths;
  Death({required this.deaths, required this.date});
}

class Recovered {
  String date;
  var recovered;
  Recovered({required this.recovered, required this.date});
}

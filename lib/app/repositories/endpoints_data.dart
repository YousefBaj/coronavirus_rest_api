import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/endpoint_data.dart';
import 'package:flutter/cupertino.dart';

class EndpointsData {
  EndpointsData({@required this.values});
  final Map<Endpoints, EndpointData> values;

  EndpointData get cases => values[Endpoints.cases];
  EndpointData get todayCases => values[Endpoints.todayCases];
  EndpointData get active => values[Endpoints.active];
  EndpointData get critical => values[Endpoints.critical];
  EndpointData get deaths => values[Endpoints.deaths];
  EndpointData get todayDeaths => values[Endpoints.todayDeaths];
  EndpointData get recovered => values[Endpoints.recovered];
  EndpointData get casesPerOneMillion => values[Endpoints.casesPerOneMillion];
  EndpointData get deathsPerOneMillion => values[Endpoints.deathsPerOneMillion];

  @override
  String toString() =>
      'cases: $cases, today cases: $todayCases, active cases: $active, critical cases: $critical cases per one million: $casesPerOneMillion \n deaths: $deaths, today deaths: $todayDeaths, deaths per one million: $deathsPerOneMillion, \n recovered: $recovered';
}

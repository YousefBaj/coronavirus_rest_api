import 'package:coronavirus_rest_api_flutter_course/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum Endpoints {
  cases,
  todayCases,
  active,
  deaths,
  recovered,
  todayDeaths,
  critical,
  casesPerOneMillion,
  deathsPerOneMillion,
}

class API {
  API({@required this.apiKey});
  final String apiKey;

  factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

  static final String host = "apigw.nubentos.com";
  static final int port = 443;
  static final String basePath = 't/nubentos.com/ncovapi/2.0.0';

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: 'token',
        queryParameters: {'grant_type': 'client_credentials'},
      );

  Uri endpointUri(Endpoints endpoints) => Uri(
      scheme: 'https',
      host: host,
      port: port,
      path: '$basePath/${_paths[endpoints]}');

  static Map<Endpoints, String> _paths = {
    Endpoints.cases: 'cases',
    Endpoints.todayCases: 'todayCases',
    Endpoints.active: 'active',
    Endpoints.critical: 'critical',
    Endpoints.deaths: 'deaths',
    Endpoints.recovered: 'recovered',
    Endpoints.todayDeaths: 'todayDeaths',
    Endpoints.casesPerOneMillion: 'casesPerOneMillion',
    Endpoints.deathsPerOneMillion: 'deathsPerOneMillion',
  };
}

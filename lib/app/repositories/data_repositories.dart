import 'package:coronavirus_rest_api_flutter_course/app/repositories/endpoints_data.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api_service.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService});

  final APIService apiService;
  String _accessToken;
  Future<EndpointData> getEndpointData(Endpoints endpoint) async =>
      await _getDataRefreshingToken<EndpointData>(
        onGetData: () => apiService.getEndpointData(
          accessToken: _accessToken,
          endpoint: endpoint,
        ),
      );

  Future<EndpointsData> getAllEndpointsData() async =>
      await _getDataRefreshingToken<EndpointsData>(
        onGetData: _getAllEndpointsData,
      );

  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndpointsData> _getAllEndpointsData() async {
    final values = await Future.wait(
      [
        apiService.getEndpointData(
            accessToken: _accessToken, endpoint: Endpoints.cases),
        apiService.getEndpointData(
            accessToken: _accessToken, endpoint: Endpoints.todayCases),
        apiService.getEndpointData(
            accessToken: _accessToken, endpoint: Endpoints.active),
        apiService.getEndpointData(
            accessToken: _accessToken, endpoint: Endpoints.critical),
        apiService.getEndpointData(
            accessToken: _accessToken, endpoint: Endpoints.deaths),
        apiService.getEndpointData(
            accessToken: _accessToken, endpoint: Endpoints.recovered),
        apiService.getEndpointData(
            accessToken: _accessToken, endpoint: Endpoints.todayDeaths),
        apiService.getEndpointData(
            accessToken: _accessToken, endpoint: Endpoints.casesPerOneMillion),
        apiService.getEndpointData(
            accessToken: _accessToken, endpoint: Endpoints.deathsPerOneMillion),
      ],
    );

    return EndpointsData(
      values: {
        Endpoints.cases: values[0],
        Endpoints.todayCases: values[1],
        Endpoints.active: values[2],
        Endpoints.critical: values[3],
        Endpoints.deaths: values[4],
        Endpoints.recovered: values[5],
        Endpoints.todayDeaths: values[6],
        Endpoints.casesPerOneMillion: values[7],
        Endpoints.deathsPerOneMillion: values[8],
      },
    );
  }
}

import 'dart:convert';

import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/endpoint_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService(this.api);
  final API api;

  Future<String> getAccessToken() async {
    final response = await http.post(
      api.tokenUri().toString(),
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }
    print(
        "Request ${api.tokenUri} failed \n Respose ${response.statusCode} ${response.reasonPhrase}");
    throw response;
  }

  Future<EndpointData> getEndpointData(
      {@required String accessToken, @required Endpoints endpoint}) async {
    final uri = api.endpointUri(endpoint);
    final response = await http.get(
      uri.toString(),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final int value = data[0]['data'];
        final String dateString = data[0]['date'];
        final date = DateTime.tryParse(dateString);
        if (value != null) {
          return EndpointData(value: value, date: date);
        }
      }
    }
    print(
        "Request ${api.tokenUri} failed \n Respose ${response.statusCode} ${response.reasonPhrase}");
    throw response;
  }
}

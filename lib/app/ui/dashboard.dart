import 'dart:io';

import 'package:coronavirus_rest_api_flutter_course/app/repositories/data_repositories.dart';
import 'package:coronavirus_rest_api_flutter_course/app/repositories/endpoints_data.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/endpoint_card.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/last_updated_status_text.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/show_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointData;

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointData = dataRepository.getAllEndpointsCachedData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final cases = await dataRepository.getAllEndpointsData();

      setState(
        () {
          _endpointData = cases;
        },
      );
    } on SocketException catch (e) {
      showAlertDialog(
          context: context,
          title: 'Connection Error',
          content: 'Could not retrieve data. Please try again later.',
          defaultActionText: 'OK');
    } catch (_) {
      showAlertDialog(
          context: context,
          title: 'Unknown Error',
          content: 'Please contact support or try again later',
          defaultActionText: 'OK');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
        lastUpdated: _endpointData != null
            ? _endpointData.values[Endpoints.cases]?.date
            : null);
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: SafeArea(
          child: ListView(
            children: [
              LastUpdatedStatusText(
                text: formatter.lastUpdatedStatuesText(),
              ),
              for (var endpoint in Endpoints.values)
                EndpointCard(
                  endpoint: endpoint,
                  value: _endpointData != null
                      ? _endpointData.values[endpoint]?.value
                      : null,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

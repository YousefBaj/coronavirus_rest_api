import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget {
  const EndpointCard({Key key, this.endpoint, this.value}) : super(key: key);
  final Endpoints endpoint;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Cases',
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Icon(Icons.access_alarm),
                ],
              ),
              Text(
                value != null ? value.toString() : '',
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
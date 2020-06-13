import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndpointCarData {
  EndpointCarData(this.title, this.assetName, this.color);
  final String title;
  final String assetName;
  final Color color;
}

class EndpointCard extends StatelessWidget {
  const EndpointCard({Key key, this.endpoint, this.value}) : super(key: key);
  final Endpoints endpoint;
  final int value;
  static Map<Endpoints, EndpointCarData> _cardsData = {
    Endpoints.cases:
        EndpointCarData('cases', 'assets/count.png', Color(0xfffff429)),
    Endpoints.todayCases:
        EndpointCarData('todayCases', 'assets/suspect.png', Color(0xffeeda29)),
    Endpoints.active:
        EndpointCarData('active', 'assets/fever.png', Color(0xffe99600)),
    Endpoints.critical:
        EndpointCarData('critical', 'assets/death.png', Color(0xffe99600)),
    Endpoints.deaths:
        EndpointCarData('deaths', 'assets/death.png', Color(0xffe40000)),
    Endpoints.recovered:
        EndpointCarData('recovered', 'assets/patient.png', Color(0xff70a901)),
    Endpoints.todayDeaths:
        EndpointCarData('todayDeaths', 'assets/death.png', Color(0xffe40000)),
    Endpoints.casesPerOneMillion: EndpointCarData(
        'casesPerOneMillion', 'assets/count.png', Color(0xfffff429)),
    Endpoints.deathsPerOneMillion: EndpointCarData(
        'deathsPerOneMillion', 'assets/count.png', Color(0xffe40000)),
  };

  String get formattedValues {
    if (value == null) {
      return '';
    }

    return NumberFormat('#,###,###,###').format(value);
  }

  @override
  Widget build(BuildContext context) {
    final cardData = _cardsData[endpoint];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cardData.title,
                    style: Theme.of(context)
                        .textTheme
                        .headline
                        .copyWith(color: cardData.color),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Image.asset(
                    cardData.assetName,
                    color: cardData.color,
                  ),
                ],
              ),
              Text(
                formattedValues,
                style: Theme.of(context).textTheme.display1.copyWith(
                    color: cardData.color, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

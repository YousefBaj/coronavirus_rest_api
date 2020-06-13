import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdatedDateFormatter {
  LastUpdatedDateFormatter({@required this.lastUpdated});
  final DateTime lastUpdated;

  String lastUpdatedStatuesText() {
    if (lastUpdated != null) {
      final formatter = DateFormat.yMd().add_Hms();
      final formatted = formatter.format(lastUpdated.toLocal());
      return 'Last updated: ${formatted}';
    } else {
      return '';
    }
  }
}

class LastUpdatedStatusText extends StatelessWidget {
  LastUpdatedStatusText({@required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}

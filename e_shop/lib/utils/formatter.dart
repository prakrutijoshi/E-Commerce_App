import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UtilFormatter {
  static String formatTimeStamp(Timestamp timestamp) {
    DateFormat formatter = DateFormat.yMMMMd().add_jm();
    var date =
        new DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return formatter.format(date);
  }
}

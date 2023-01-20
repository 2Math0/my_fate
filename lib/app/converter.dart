import 'package:intl/intl.dart';

class Converter {
  const Converter();

  String dateFormatDDMMYYYY(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date).toString();
  }

  DateTime convertToDate(String input) {
    return DateFormat("DD/MM/yyyy").parseStrict(input);
  }

  DateTime convertHourToDate(String hour) {
    return DateFormat("hh:mm").parseStrict(hour);
  }

  String convertToPM(DateTime time) {
    return DateFormat("h:mma").format(time);
  }

  String dayFormatter(date) {
    return DateFormat("dd").format(date);
  }
}

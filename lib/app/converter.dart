import 'package:intl/intl.dart';

class Converter {
  const Converter();

  String dateFormatDDMMYYYY(DateTime date) =>
      DateFormat('dd/MM/yyyy').format(date).toString();

  DateTime convertToDate(String input) =>
      DateFormat("DD/MM/yyyy").parseStrict(input);

  DateTime convertHourToDate(String hour) =>
      DateFormat("hh:mm").parseStrict(hour);

  String convertToPM(DateTime time) => DateFormat("h:mma").format(time);

  String dayFormatter(DateTime date) => DateFormat("dd").format(date);

  String intToTime(int i) => "${i >= 10 ? i : "0$i"}:00";
  int parsingHourToInt(String time) => int.parse(time.split(":")[0]);
}

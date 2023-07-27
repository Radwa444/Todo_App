import 'package:intl/intl.dart';
class Mydate{
  static String formatTaskDate(DateTime data){
    return DateFormat("yyyy-MM-dd").format(data);
  }
  static DateTime datenow(DateTime input){
    return DateTime(input.year,input.month,input.day);
  }
}
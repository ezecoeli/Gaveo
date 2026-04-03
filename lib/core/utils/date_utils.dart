import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static String monthName(int mes, int anio, String locale) {
    final date = DateTime(anio, mes);
    return DateFormat('MMMM yyyy', locale).format(date);
  }

  static String formatShort(DateTime date, String locale) {
    return DateFormat('dd/MM/yyyy', locale).format(date);
  }

  static bool isCurrentMonth(int mes, int anio) {
    final now = DateTime.now();
    return now.month == mes && now.year == anio;
  }

  static ({int mes, int anio}) previousMonth(int mes, int anio) {
    final date = DateTime(anio, mes - 1);
    return (mes: date.month, anio: date.year);
  }

  static ({int mes, int anio}) nextMonth(int mes, int anio) {
    final date = DateTime(anio, mes + 1);
    return (mes: date.month, anio: date.year);
  }

  static bool canGoToNextMonth(int mes, int anio) {
    final now = DateTime.now();
    final next = DateTime(anio, mes + 1);
    final max = DateTime(now.year, now.month + 1);
    return next.isBefore(max);
  }
}

// ============================================================
// Formatters – currency, number, date helpers.
// ============================================================
import 'package:intl/intl.dart';

abstract class AppFormatters {
  // Indian Rupee currency format e.g. ₹1,234.50
  static final _currencyFmt = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  // Compact e.g. ₹1,234
  static final _currencyNoDecFmt = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  static String currency(double amount) => _currencyFmt.format(amount);
  static String currencyNoDec(double amount) => _currencyNoDecFmt.format(amount);

  // Weight: 0.5 kg, 1 kg, 2.5 kg
  static String weight(double kg) {
    if (kg == kg.roundToDouble()) {
      return '${kg.toInt()} kg';
    }
    return '$kg kg';
  }

  // Phone: +91 98765 43210
  static String phone(String digits) {
    if (digits.length == 10) {
      return '+91 ${digits.substring(0, 5)} ${digits.substring(5)}';
    }
    return digits;
  }

  // Date: Wed, 30 Sep 2026
  static String fullDate(DateTime d) => DateFormat('EEE, d MMM yyyy').format(d);

  // Date and Time: 30 Sep 2026, 10:30 AM
  static String dateTime(DateTime d) => DateFormat('d MMM yyyy, h:mm a').format(d);

  // Time: 10:30 AM
  static String time(DateTime d) => DateFormat('h:mm a').format(d);

  // Short date: 30 Sep
  static String shortDate(DateTime d) => DateFormat('d MMM').format(d);

  // Day name: Wed
  static String dayName(DateTime d) => DateFormat('EEE').format(d);

  // Slot time: 6:00 AM - 7:00 AM
  static String slotTime(int startHour) {
    final start = DateFormat('h:00 a').format(
      DateTime(2000, 1, 1, startHour),
    );
    final end = DateFormat('h:00 a').format(
      DateTime(2000, 1, 1, startHour + 1),
    );
    return '$start – $end';
  }

  // Distance
  static String distance(double meters) {
    if (meters < 1000) return '${meters.toStringAsFixed(0)} m';
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  // Order ID
  static String orderId(DateTime ts, int seq) {
    final dateStr = DateFormat('yyyyMMdd').format(ts);
    final seqStr = seq.toString().padLeft(4, '0');
    return 'RSB-$dateStr-$seqStr';
  }

  // Percentage
  static String percent(double v) => '${(v * 100).toStringAsFixed(0)}%';
}

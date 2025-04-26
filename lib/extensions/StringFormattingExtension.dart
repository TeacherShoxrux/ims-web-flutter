import 'package:intl/intl.dart';

extension IntCurrencyExtension on int {
  String som() =>
      NumberFormat.compactSimpleCurrency(locale: 'uz_UZ').format(this);
}

extension DoubleCurrencyExtension on double {
  String som() =>
      NumberFormat.compactSimpleCurrency(locale: 'uz_UZ',).format(this);
}

extension StringDateExtension on String? {
  String fmtDate({
    String input = 'yyyy-MM-ddTHH:mm:ss',
    String output = 'dd MMM, yyyy',
  }) {
    if (this == null) {
      return '';
    }
    try {
      var dateTime = DateTime.parse(this??'');
      return '${DateFormat.Hm().format(dateTime)}\n${DateFormat.yMd().format(dateTime)}';
    } catch (_) {
      return this!;
    }
  }
}

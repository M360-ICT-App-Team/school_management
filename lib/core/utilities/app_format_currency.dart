import 'package:intl/intl.dart';

String formatCurrencySymbol(dynamic amount) {
  if (amount == null) return 'N/A';
  final convertDouble = double.tryParse(amount.toString())??0;
  try {
    final formatter =
        NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 0);
    return '${formatter.format(convertDouble)} ৳';
  } catch (e) {
    return 'N/A';
  }
}
String formatCurrency(dynamic amount) {
  if (amount == null) return 'N/A';
  final convertDouble = double.tryParse(amount.toString())??0;
  try {
    final formatter =
        NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 2);
    return formatter.format(convertDouble);
  } catch (e) {
    return 'N/A';
  }
}

String formatCurrencyBDT(dynamic amount) {
  if (amount == null) return 'N/A';
  final convertDouble = double.tryParse(amount.toString())??0;
  try {
    final formatter =
        NumberFormat.currency(locale: 'en_IN', symbol: '', decimalDigits: 0);
    return '${formatter.format(convertDouble)} BDT';
  } catch (e) {
    return 'N/A';
  }
}

class CustomType {
  final dynamic _value;

  CustomType(dynamic value) : _value = value;

  int? get asInt {
    if (_value is int) return _value;
    if (_value is double) return (_value).toInt();
    if (_value is String) return int.tryParse(_value);
    return null;
  }

  double? get asDouble {
    if (_value is double) return _value;
    if (_value is int) return (_value).toDouble();
    if (_value is String) return double.tryParse(_value);
    return null;
  }

  String? get asString {
    if (_value is String) return _value;
    return _value?.toString();
  }

  @override
  String toString() => asString ?? '';
}

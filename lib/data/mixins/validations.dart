mixin ValidationsMixin {
  double nullAmount(String value) {
    final amount = double.tryParse(value);
    if (amount != null) {
      return amount;
    } else {
      return 0.00;
    }
  }

  String? validateLength(String value, int minLength, String errorMessage) {
    if (value.length < minLength) return errorMessage;
    return null;
  }
}

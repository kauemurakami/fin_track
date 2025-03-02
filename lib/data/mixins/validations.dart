mixin ValidationsMixin {
  double nullAmount(String value) {
    final amount = double.tryParse(value);
    if (amount != null) {
      return amount;
    } else {
      return 0.00;
    }
  }
}

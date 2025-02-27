enum TransactionType {
  income('income'),
  expense('expense');

  const TransactionType(this.type);
  final String type;
}

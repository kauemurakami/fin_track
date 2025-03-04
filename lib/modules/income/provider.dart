import 'package:fin_track/data/enums/transaction_type.dart';
import 'package:fin_track/data/mixins/validations.dart';
import 'package:fin_track/data/models/app_error.dart';
import 'package:fin_track/data/models/either.dart';
import 'package:fin_track/data/models/transaction.dart';
import 'package:fin_track/modules/income/repository.dart';
import 'package:flutter/foundation.dart';

class IncomeProvider extends ChangeNotifier with ValidationsMixin {
  final IncomeRepository repository;
  ValueNotifier<List<TransactionModel>> incomes = ValueNotifier([]);
  ValueNotifier<bool> loadTransactions = ValueNotifier(true);
  TransactionModel newTransaction = TransactionModel();
  IncomeProvider(this.repository);

  Future<Either<AppError, TransactionModel>> addIncome() async {
    newTransaction.type = TransactionType.income;
    final Either<AppError, TransactionModel> result = await repository.addIncome(newTransaction);
    result.fold((AppError error) {
      // TODO: another error handlers
    }, (TransactionModel transaction) {
      incomes.value.add(transaction);
      incomes.notifyListeners();
    });
    return result;
  }

  Future<Either<AppError, List<TransactionModel>>> fetchIncomes() async {
    final Either<AppError, List<TransactionModel>> result = await repository.fetchIncomes(TransactionType.income);
    result.fold((AppError error) {
      // TODO: another errors handlers
    }, (List<TransactionModel> transactions) {
      incomes.value = transactions;
      notifyListeners();
    });
    loadTransactions.value = false;
    notifyListeners();
    return result;
  }

  onChangedTitle(String value) => newTransaction.title = value;
  onSavedTitle(String value) => newTransaction.title = value;
  validateTitle(String value) => validateLength(value, 3, 'Insert a valide title');

  onChangedAmount(String value) => newTransaction.amount = nullAmount(value);
  onSavedAmount(String value) => newTransaction.amount = nullAmount(value);
  validateAmount(String value) => validateLength(value, 1, 'Insert an amount');
}

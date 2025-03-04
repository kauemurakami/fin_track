import 'package:fin_track/data/enums/transaction_type.dart';
import 'package:fin_track/data/models/app_error.dart';
import 'package:fin_track/data/models/either.dart';
import 'package:fin_track/data/models/transaction.dart';
import 'package:fin_track/modules/income/repository.dart';
import 'package:flutter/foundation.dart';

class IncomeProvider extends ChangeNotifier {
  final IncomeRepository repository;
  ValueNotifier<List<TransactionModel>> incomes = ValueNotifier([]);
  ValueNotifier<bool> loadTransactions = ValueNotifier(true);
  IncomeProvider(this.repository);

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
}

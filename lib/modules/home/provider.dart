import 'package:fin_track/data/models/app_error.dart';
import 'package:fin_track/data/models/category_transactions.dart';
import 'package:fin_track/data/models/either.dart';
import 'package:fin_track/data/models/transaction.dart';
import 'package:fin_track/modules/home/repository.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepository repository;
  ValueNotifier<List<TransactionModel>> transactions = ValueNotifier([]);
  ValueNotifier<List<CategoryTransactionsModel>> transactionsByCategory = ValueNotifier([]);
  ValueNotifier<bool> loadTransactions = ValueNotifier(true);
  ValueNotifier<bool> loadChart = ValueNotifier(true);
  ValueNotifier<int> touchedIndex = ValueNotifier(-1);
  HomeProvider(this.repository);

  Future<Either<AppError, List<CategoryTransactionsModel>>> fetchExpensesByCategory() async {
    final Either<AppError, List<CategoryTransactionsModel>> result = await repository.fetchCategoryTransactions();
    result.fold((AppError error) {
      // TODO another handlers
    }, (List<CategoryTransactionsModel> categoryTransactions) {
      transactionsByCategory.value = categoryTransactions;
      transactionsByCategory.notifyListeners();
    });
    loadChart.value = false;
    notifyListeners();
    return result;
  }

  Future<Either<AppError, List<TransactionModel>>> fetchTransactions() async {
    final Either<AppError, List<TransactionModel>> result = await repository.fetchTransactions();
    result.fold((AppError error) {
      //TODO : another handlers
    }, (List<TransactionModel> transactions) {
      this.transactions.value = transactions;
    });
    loadTransactions.value = false;
    notifyListeners();
    return result;
  }
}

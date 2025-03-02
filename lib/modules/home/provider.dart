import 'package:fin_track/data/models/app_error.dart';
import 'package:fin_track/data/models/either.dart';
import 'package:fin_track/data/models/transaction.dart';
import 'package:fin_track/modules/home/repository.dart';
import 'package:flutter/foundation.dart';

class HomeProvider extends ChangeNotifier {
  final HomeRepository repository;
  ValueNotifier<List<TransactionModel>> transactions = ValueNotifier([]);
  ValueNotifier<bool> loadTransactions = ValueNotifier(true);
  HomeProvider(this.repository);

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

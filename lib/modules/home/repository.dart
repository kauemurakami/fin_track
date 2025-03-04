import 'package:fin_track/data/models/app_error.dart';
import 'package:fin_track/data/models/category_transactions.dart';
import 'package:fin_track/data/models/either.dart';
import 'package:fin_track/data/models/transaction.dart';
import 'package:fin_track/core/services/db/db.dart';

class HomeRepository {
  final DBService dbService;
  HomeRepository(this.dbService);

  Future<Either<AppError, List<TransactionModel>>> fetchTransactions() async =>
      await dbService.fetchTransactions(type: null);
  Future<Either<AppError, List<CategoryTransactionsModel>>> fetchCategoryTransactions() async => await dbService.fetchCategoryTransactions();
}

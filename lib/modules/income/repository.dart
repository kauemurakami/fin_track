import 'package:fin_track/data/models/app_error.dart';
import 'package:fin_track/data/models/either.dart';
import 'package:fin_track/data/models/transaction.dart';
import 'package:fin_track/routes/delegate/delegate_imports.dart';

class IncomeRepository {
  final DBService db;
  IncomeRepository(this.db);

  Future<Either<AppError, TransactionModel>> addIncome(TransactionModel transaction) async =>
      await db.addTransaction(transaction);

  Future<Either<AppError, List<TransactionModel>>> fetchIncomes(type) async => await db.fetchTransactions(type: type);
}

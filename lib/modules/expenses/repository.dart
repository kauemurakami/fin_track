import 'package:fin_track/data/enums/transaction_type.dart';
import 'package:fin_track/data/models/app_error.dart';
import 'package:fin_track/data/models/category.dart';
import 'package:fin_track/data/models/either.dart';
import 'package:fin_track/data/models/transaction.dart';
import 'package:fin_track/core/services/db/db.dart';

class ExpensesRepository {
  final DBService dbService;

  ExpensesRepository(this.dbService);

  Future<Either<AppError, List<CategoryModel>>> fetchCategories() async => await dbService.fetchCategories();
  Future<Either<AppError, List<TransactionModel>>> fetchExpenses(TransactionType type) async =>
      await dbService.fetchTransactions(type: type);
  Future<Either<AppError, CategoryModel>> addCategory(CategoryModel category) async =>
      await dbService.addCategory(category);

  Future<Either<AppError, TransactionModel>> addExpense(TransactionModel transaction) async =>
      await dbService.addExpense(transaction);
}

import 'package:fin_track/data/models/app_error.dart';
import 'package:fin_track/data/models/category.dart';
import 'package:fin_track/data/models/either.dart';
import 'package:fin_track/data/models/transaction.dart';
import 'package:fin_track/data/services/db/db.dart';

class ExpensesRepository {
  final DBService dbService;

  ExpensesRepository(this.dbService);

  Future<Either<AppError, List<CategoryModel>>> fetchCategories() async => await dbService.fetchCategories();
  Future<Either<AppError, CategoryModel>> addCategory() async => await dbService.addCategory();
  Future<Either<AppError, TransactionModel>> addExpense(TransactionModel transaction) async =>
      await dbService.addExpense(transaction);
}

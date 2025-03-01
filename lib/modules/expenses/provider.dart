import 'package:fin_track/data/enums/transaction_type.dart';
import 'package:fin_track/data/models/app_error.dart';
import 'package:fin_track/data/models/category.dart';
import 'package:fin_track/data/models/either.dart';
import 'package:fin_track/data/models/transaction.dart';
import 'package:fin_track/modules/expenses/repository.dart';
import 'package:flutter/foundation.dart';

class ExpensesProvider extends ChangeNotifier {
  final ExpensesRepository repository;

  ExpensesProvider(this.repository);
  List<CategoryModel> categories = [];
  ValueNotifier<List<TransactionModel>> transactions = ValueNotifier([]);
  ValueNotifier<bool> loadTransactions = ValueNotifier(true);
  late CategoryModel selectedCategory;
  CategoryModel newCategory = CategoryModel();
  TransactionModel newTransaction = TransactionModel();

  Future<Either<AppError, TransactionModel>> addExpense() async {
    newTransaction.category = selectedCategory;
    newTransaction.date = DateTime.now();
    newTransaction.type = TransactionType.expense;
    final Either<AppError, TransactionModel> result = await repository.addExpense(newTransaction);
    result.fold((AppError error) {
      //TODO: another handlers
    }, (TransactionModel transaction) {
      transactions.value.add(transaction);
      notifyListeners();
    });
    return result;
  }

  addCategory() async {}

  Future<Either<AppError, List<TransactionModel>>> fetchExpenses() async {
    final Either<AppError, List<TransactionModel>> result = await repository.fetchExpenses();
    result.fold((AppError error) {
      //TODO: another handlers
      transactions.value = [];
    }, (List<TransactionModel> transactions) {
      this.transactions.value = transactions;
    });
    loadTransactions.value = false;
    notifyListeners();
    return result;
  }

  Future<Either<AppError, List<CategoryModel>>> fetchCategories() async {
    final Either<AppError, List<CategoryModel>> result = await repository.fetchCategories();
    result.fold((AppError error) {
      //TODO: another handlers
      categories = [];
    }, (List<CategoryModel> categories) {
      this.categories = categories;
      selectedCategory = categories.first;
    });
    notifyListeners();
    return result;
  }

  void selectCategory(CategoryModel category) {
    selectedCategory = category;
    notifyListeners();
  }

  onChangedTitle(String value) => newTransaction.title = value;
  onSavedTitle(String value) => newTransaction.title = value;
  validateTitle(String value) => value.length < 3 ? 'Insert a valide title' : null;
  onChangedAmount(String value) {
    final amount = double.tryParse(value);
    if (amount != null) {
      newTransaction.amount = amount;
    } else {
      newTransaction.amount = 0.00;
    }
  }

  onSavedAmount(String value) {
    final amount = double.tryParse(value);
    if (amount != null) {
      newTransaction.amount = amount;
    } else {
      newTransaction.amount = 0.00;
    }
  }

  validateAmount(String value) => value.length < 1 ? 'Insert an amount' : null;

  onChangedCategoryName(String value) => newCategory.name = value;
  onSavedCategoryName(String value) => newCategory.name = value;
  validateCategoryName(String value) => value.length < 3 ? 'Insert a valid category' : null;
}

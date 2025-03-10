import 'package:fin_track/data/enums/transaction_type.dart';
import 'package:fin_track/data/mixins/validations.dart';
import 'package:fin_track/data/models/app_error.dart';
import 'package:fin_track/data/models/category.dart';
import 'package:fin_track/data/models/either.dart';
import 'package:fin_track/data/models/transaction.dart';
import 'package:fin_track/modules/expenses/repository.dart';
import 'package:flutter/foundation.dart';

class ExpensesProvider extends ChangeNotifier with ValidationsMixin {
  final ExpensesRepository repository;

  ExpensesProvider(this.repository);
  ValueNotifier<List<CategoryModel>> categories = ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> transactions = ValueNotifier([]);
  ValueNotifier<bool> loadTransactions = ValueNotifier(true);
  late CategoryModel selectedCategory;
  CategoryModel newCategory = CategoryModel();
  TransactionModel newTransaction = TransactionModel();

  Future<Either<AppError, TransactionModel>> addExpense() async {
    newTransaction.category = selectedCategory;
    newTransaction.type = TransactionType.expense;
    final Either<AppError, TransactionModel> result = await repository.addExpense(newTransaction);
    result.fold((AppError error) {
      //TODO: another handlers
    }, (TransactionModel transaction) {
      transactions.value.add(transaction);
    });
    transactions.notifyListeners();
    return result;
  }

  Future<Either<AppError, CategoryModel>> addCategory() async {
    final Either<AppError, CategoryModel> result = await repository.addCategory(newCategory);
    result.fold((AppError error) {
      // TODO: another handlers
    }, (CategoryModel category) {
      categories.value.add(category);
    });
    categories.notifyListeners();
    return result;
  }

  Future<Either<AppError, List<TransactionModel>>> fetchExpenses() async {
    final Either<AppError, List<TransactionModel>> result = await repository.fetchExpenses(TransactionType.expense);
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
      categories = ValueNotifier([]);
    }, (List<CategoryModel> categories) {
      this.categories.value = categories;
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
  validateTitle(String value) => validateLength(value, 3, 'Insert a valide title');

  onChangedAmount(String value) => newTransaction.amount = nullAmount(value);
  onSavedAmount(String value) => newTransaction.amount = nullAmount(value);
  validateAmount(String value) => validateLength(value, 1, 'Insert an amount');

  onChangedCategoryName(String value) => newCategory.name = value;
  onSavedCategoryName(String value) => newCategory.name = value;
  validateCategoryName(String value) => validateLength(value, 3, 'Insert a valid category');
}

import 'package:fin_track/data/models/app_error.dart';
import 'package:fin_track/data/models/category.dart';
import 'package:fin_track/data/models/either.dart';
import 'package:fin_track/modules/expenses/repository.dart';
import 'package:flutter/foundation.dart';

class ExpensesProvider extends ChangeNotifier {
  final ExpensesRepository repository;

  ExpensesProvider(this.repository);
  String a = 'aa';
  List<CategoryModel> categories = [];

  Future<Either<AppError, List<CategoryModel>>> fetchCategories() async {
    final Either<AppError, List<CategoryModel>> result = await repository.fetchCategories();
    result.fold((AppError error) {
      //TODO: another handlers
      categories = [];
    }, (List<CategoryModel> categories) {
      this.categories = categories;
    });
    notifyListeners();
    return result;
  }
}

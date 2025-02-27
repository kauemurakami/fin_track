import 'package:fin_track/data/models/app_error.dart';
import 'package:fin_track/data/models/category.dart';
import 'package:fin_track/data/models/either.dart';
import 'package:fin_track/data/models/transaction.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBService {
  static Database? _database;
  Future<Either<AppError, CategoryModel>> addCategory() async {
    return Either.left(AppError(error: '1'));
  }

  Future<Either<AppError, TransactionModel>> addExpense(TransactionModel transaction) async {
    return Either.left(AppError(error: '1'));
  }

  // Função para recuperar todas as categorias
  Future<Either<AppError, List<CategoryModel>>> fetchCategories() async {
    try {
      final db = await database;
      // Recuperar todas as categorias
      final List<Map<String, dynamic>> categoryMaps = await db.rawQuery('SELECT * FROM categories');
      print(categoryMaps);

      return Either.right(categoriesFromMap(categoryMaps));
    } on DatabaseException catch (e) {
      print('Erro ao recuperar categorias: ${e.toString()}');
      return Either.left(AppError(error: 'Database Exception', message: 'Erro ao recuperar categorias'));
    } catch (e) {
      print('Erro inesperado: ${e.toString()}');
      return Either.left(AppError(error: 'Unexpected Error', message: 'Um erro inesperado aconteceu, tente novamente'));
    }
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = '${directory.path}/fintrack.db';

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (Database db, int version) async {
        // Criar tabela de categorias com auto incremento
        await db.execute('''
          CREATE TABLE categories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL
          )
        ''');

        // Criar tabela de transações com chave estrangeira para categorias
        await db.execute('''
          CREATE TABLE transactions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            amount REAL NOT NULL,
            date TEXT NOT NULL,
            type TEXT NOT NULL,
            category_id INTEGER,
            FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
          )
        ''');

        // Adicionar categorias padrão (seeds)
        await db.insert('categories', {'name': 'Lazer'});
        await db.insert('categories', {'name': 'Alimentação'});
        await db.insert('categories', {'name': 'Transporte'});
        await db.insert('categories', {'name': 'Saúde'});
        await db.insert('categories', {'name': 'Moradia'});
      },
    );
  }
}

import 'package:fin_track/data/di/setup_locator.dart';
import 'package:fin_track/core/services/db/db.dart';
import 'package:fin_track/core/services/navigation.dart';
import 'package:flutter/material.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await getIt<DBService>().database;
  //test created seeds
  // var db = await getIt<DBService>().database;
  // var result = await db.rawQuery('SELECT * FROM categories');
  // print(result);
  //test if created tables
  // var db = await getIt<DBService>().database;
  // var result = await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table" AND name="categories";');

  // if (result.isNotEmpty) {
  //   print('Tabela "categories" criada com sucesso!');
  // } else {
  //   print('Tabela "categories" não encontrada!');
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'FinTrack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      // theme: ThemeData.dark().copyWith(
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: Colors.deepPurple,
      //   ),
      // ),

      routerConfig: getIt<NavigationService>().router,
    );
  }
}

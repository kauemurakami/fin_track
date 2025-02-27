import 'package:fin_track/modules/expenses/provider.dart';
import 'package:fin_track/modules/expenses/widgets/bs_add_expense.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  late ExpensesProvider provider;
  @override
  void initState() {
    provider = Provider.of<ExpensesProvider>(context, listen: false);
    provider.fetchCategories();
    provider.fetchExpenses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await showModalBottomSheet(
          backgroundColor: Color(0xff1e1e1e),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0),
              topRight: Radius.circular(4.0),
            ),
          ),
          enableDrag: true,
          isDismissible: true,
          context: context,
          builder: (_) => ChangeNotifierProvider.value(
            value: provider,
            builder: (__, ___) => BSAddExpense(),
          ),
        ),
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Expenses',
                style: TextTheme.of(context).titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

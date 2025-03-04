import 'package:fin_track/modules/expenses/provider.dart';
import 'package:fin_track/modules/expenses/widgets/bs_add_expense.dart';
import 'package:fin_track/modules/widgets/card_transaction.dart';
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
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
              Text('Expenses', style: TextTheme.of(context).titleLarge),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: provider.loadTransactions,
                  builder: (context, load, child) => load
                      ? Center(child: CircularProgressIndicator.adaptive())
                      : ValueListenableBuilder(
                          valueListenable: provider.transactions,
                          builder: (context, value, child) => value.isEmpty
                              ? Center(child: Text('You still have no expenses'))
                              : ListView.builder(
                                  itemCount: value.length,
                                  itemBuilder: (context, index) => CardTransactionWidget(
                                    transaction: value[index],
                                  ),
                                ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

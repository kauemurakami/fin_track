import 'package:fin_track/modules/expenses/provider.dart';
import 'package:fin_track/modules/expenses/widgets/bs_add_expense.dart';
import 'package:fin_track/utils/functions/format_date.dart';
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
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: provider.loadTransactions,
                  builder: (context, load, child) => load
                      ? Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : ValueListenableBuilder(
                          valueListenable: provider.transactions,
                          builder: (context, value, child) => value.isEmpty
                              ? Center(
                                  child: Text('You still have no expenses'),
                                )
                              : ListView.builder(
                                  itemCount: value.length,
                                  itemBuilder: (context, index) => Card(
                                    // color: Color(0xff010101),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        spacing: 4.0,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${value[index].title}',
                                                style: TextTheme.of(context).titleMedium,
                                              ),
                                              Text(
                                                formatDate(
                                                  value[index].date!,
                                                ),
                                                style: TextTheme.of(context).labelSmall,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                spacing: 1.0,
                                                children: [
                                                  Icon(
                                                    Icons.remove,
                                                    color: Colors.red,
                                                    size: 11.0,
                                                  ),
                                                  Text(
                                                    value[index].amount!.toStringAsFixed(2),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(4.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurple.shade100,
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(4.0),
                                                  ),
                                                ),
                                                child: Text(
                                                  '${value[index].category?.name}',
                                                  style: TextTheme.of(context).labelMedium,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
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

import 'package:fin_track/modules/income/provider.dart';
import 'package:fin_track/modules/income/widgets/bs_add_income.dart';
import 'package:fin_track/modules/widgets/card_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  late IncomeProvider provider;

  @override
  void initState() {
    provider = Provider.of<IncomeProvider>(context, listen: false);
    provider.fetchIncomes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await showModalBottomSheet(
          // backgroundColor: Color(0xff1e1e1e),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0)),
          ),
          enableDrag: true,
          isDismissible: true,
          context: context,
          builder: (_) => ChangeNotifierProvider.value(value: provider, builder: (__, ___) => BSAddIncomeWidget()),
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
                          valueListenable: provider.incomes,
                          builder: (context, value, child) => value.isEmpty
                              ? Center(child: Text('You still have no incomes'))
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

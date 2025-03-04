import 'package:fin_track/modules/home/provider.dart';
import 'package:fin_track/modules/widgets/card_transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeProvider provider;
  @override
  void initState() {
    provider = Provider.of<HomeProvider>(context, listen: false);
    print('aqui');
    provider.fetchTransactions();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('transactions');
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('All Transactions', style: TextTheme.of(context).titleLarge),
              Consumer<int>(
                builder: (context, currentIndex, child) {
                  currentIndex == 0 ? provider.fetchTransactions() : null;
                  return Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: provider.loadTransactions,
                      builder: (context, load, child) => load
                          ? Center(child: CircularProgressIndicator.adaptive())
                          : ValueListenableBuilder(
                              valueListenable: provider.transactions,
                              builder: (context, value, child) => value.isEmpty
                                  ? Center(child: Text('You still have no transactions'))
                                  : ListView.builder(
                                      itemCount: value.length,
                                      itemBuilder: (context, index) => CardTransactionWidget(
                                        transaction: value[index],
                                      ),
                                    ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

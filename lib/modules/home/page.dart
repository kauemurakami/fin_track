import 'package:fin_track/modules/home/provider.dart';
import 'package:fin_track/utils/functions/format_date.dart';
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
    provider.fetchTransactions();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('All Transactions', style: TextTheme.of(context).titleLarge),
              Expanded(
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
                                                formatDate(value[index].date!),
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
                                                  Icon(Icons.remove, color: Colors.red, size: 11.0),
                                                  Text(value[index].amount!.toStringAsFixed(2)),
                                                ],
                                              ),
                                              Container(
                                                padding: const EdgeInsets.all(4.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.deepPurple.shade100,
                                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
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

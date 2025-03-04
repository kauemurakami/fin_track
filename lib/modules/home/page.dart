import 'package:fin_track/data/models/category_transactions.dart';
import 'package:fin_track/modules/home/provider.dart';
import 'package:fin_track/modules/widgets/card_transaction.dart';
import 'package:fl_chart/fl_chart.dart';
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
    provider.fetchExpensesByCategory();
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
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: provider.loadChart,
                  builder: (context, bool load, child) => load
                      ? Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: PieChart(
                                  PieChartData(
                                    pieTouchData: PieTouchData(
                                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                        setState(() {
                                          if (!event.isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection == null) {
                                            provider.touchedIndex.value = -1;
                                            return;
                                          }
                                          provider.touchedIndex.value =
                                              pieTouchResponse.touchedSection!.touchedSectionIndex;
                                        });
                                      },
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40,
                                    sections: showingSections(provider.transactionsByCategory.value),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child: Text('data'))
                          ],
                        ),
                ),
              ),
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

  List<PieChartSectionData> showingSections(List<CategoryTransactionsModel> categoryTransactions) {
    print(categoryTransactions.length);
    if (categoryTransactions.isEmpty) return [];

    // Calcula o total geral
    double totalAmount = categoryTransactions.fold(0, (sum, item) => sum + (item.totalAmount ?? 0));

    // Definir uma lista de cores para as categorias (ajuste conforme necessário)
    final List<Color> colors = [Colors.blue, Colors.yellow, Colors.purple, Colors.green, Colors.red, Colors.orange];

    return categoryTransactions.asMap().entries.map((entry) {
      final index = entry.key;
      final category = entry.value;
      final isTouched = index == provider.touchedIndex.value;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      final percentage = ((category.totalAmount ?? 0) / totalAmount) * 100;
      final color = colors[index % colors.length]; // Garante que sempre há uma cor disponível

      return PieChartSectionData(
        color: color,
        value: category.totalAmount ?? 0,
        title: '${percentage.toStringAsFixed(1)}%', // Mostra a porcentagem com 1 casa decimal
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      );
    }).toList();
  }
}

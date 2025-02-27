import 'package:flutter/material.dart';

class BSAddExpense extends StatelessWidget {
  const BSAddExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height / 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Expense',
            style: TextTheme.of(context).titleMedium,
          ),
        ],
      ),
    );
  }
}

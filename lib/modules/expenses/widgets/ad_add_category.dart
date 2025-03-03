import 'package:fin_track/modules/expenses/provider.dart';
import 'package:fin_track/modules/widgets/button.dart';
import 'package:fin_track/modules/widgets/tff.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ADCreateCategory extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ADCreateCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ExpensesProvider>();
    return AlertDialog(
      actions: [
        DefaultButton(
          callback: () => Navigator.pop(context),
          text: 'Cancel',
          color: Colors.red.shade500,
        ),
        DefaultButton(
          callback: () async {
            await provider.addCategory();
            context.mounted ? Navigator.pop(context) : null;
          },
          text: 'Create',
          color: Colors.green.shade500,
        ),
      ],
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height / 9,
        child: Column(
          spacing: 10.0,
          children: [
            Text(
              'Add new category',
              style: TextTheme.of(context).titleMedium,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Tff(
                    label: 'Category name',
                    onChanged: (String value) => provider.onChangedCategoryName(value),
                    onSaved: (String value) => provider.onSavedCategoryName(value),
                    onValidate: (String value) => provider.validateCategoryName(value),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

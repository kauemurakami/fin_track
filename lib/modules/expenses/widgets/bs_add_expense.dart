import 'package:fin_track/data/models/category.dart';
import 'package:fin_track/modules/expenses/provider.dart';
import 'package:fin_track/modules/expenses/widgets/ad_add_category.dart';
import 'package:fin_track/modules/widgets/button.dart';
import 'package:fin_track/modules/widgets/tff.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BSAddExpense extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BSAddExpense({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.read<ExpensesProvider>();
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height / 2.0,
        child: Column(
          spacing: 10.0,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Expense', style: TextTheme.of(context).titleMedium),
            // Dropdown de categorias
            Column(
              children: [
                DropdownButtonFormField<CategoryModel>(
                  padding: EdgeInsets.zero,
                  value: provider.selectedCategory,
                  items:
                      provider.categories.map((category) {
                        return DropdownMenuItem<CategoryModel>(value: category, child: Text(category.name!));
                      }).toList(),
                  onChanged: (CategoryModel? value) {
                    if (value != null) {
                      // Atualizar a categoria selecionada
                      provider.selectCategory(value);
                    }
                  },
                  decoration: InputDecoration(labelText: 'Categoria', border: OutlineInputBorder()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder:
                              (context) => ChangeNotifierProvider.value(
                                value: provider,
                                builder: (context, child) => ADCreateCategory(),
                              ),
                        );
                      },
                      child: Text('Add new category'),
                    ),
                  ],
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.0,
                children: [
                  Tff(
                    label: 'Title',
                    type: TextInputType.name,
                    onChanged: (String value) => provider.onChangedTitle(value),
                    onSaved: (String value) => provider.onSavedTitle(value),
                    onValidate: (String value) => provider.validateTitle(value),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: Tff(
                      label: 'Amount',
                      type: TextInputType.number,
                      onChanged: (String value) => provider.onChangedAmount(value),
                      onSaved: (String value) => provider.onSavedAmount(value),
                      onValidate: (String value) => provider.validateAmount(value),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DefaultButton(callback: () => Navigator.pop(context), text: 'Cancel', color: Colors.red.shade500),
                DefaultButton(
                  callback: () async {
                    await provider.addExpense();
                  },
                  text: 'Create',
                  color: Colors.green.shade500,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:fin_track/modules/income/provider.dart';
import 'package:fin_track/modules/widgets/button.dart';
import 'package:fin_track/modules/widgets/tff.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BSAddIncomeWidget extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  BSAddIncomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final IncomeProvider provider = context.read<IncomeProvider>();
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height / 3.0,
      child: Column(
        spacing: 10.0,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add Income', style: TextTheme.of(context).titleMedium),
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
                  // await provider.addIncome();
                  context.mounted ? Navigator.pop(context) : null;
                },
                text: 'Create',
                color: Colors.green.shade500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

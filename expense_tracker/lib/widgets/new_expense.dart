import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: _titleController,
                // onChanged: _saveTitleInput,
                maxLength: 50,
                decoration: InputDecoration(label: Text('Title'))),
            TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(prefixText: '\$ ', label: Text('Amount'))),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
                ElevatedButton(
                    onPressed: () {
                      // print(_enteredTitle);
                      print(_titleController.text);
                      print(_amountController.text);
                    },
                    child: Text('Save Expense'))
              ],
            )
          ],
        ));
  }
}

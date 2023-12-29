import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

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
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    // .then((value) => {});

    setState(() {
      _selectedDate = pickedDate;
    });
  }

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
            Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixText: '\$ ', label: Text('Amount'))),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate == null
                          ? 'Selected Date'
                          : formatter.format(_selectedDate!)),
                      IconButton(
                          icon: const Icon(Icons.calendar_month),
                          onPressed: _presentDatePicker)
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                            child: Text(category.name.toUpperCase()),
                            value: category))
                        .toList(),
                    onChanged: (category) {
                      if (category == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = category as Category;
                      });
                    }),
                const Spacer(),
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

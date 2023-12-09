import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addTransaction;
  NewTransaction(this._addTransaction);

  State<StatefulWidget> createState() => _NewTransaction();
}

class _NewTransaction extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate = DateTime.now();
  // final Function _addTransaction;

  // _NewTransaction(this._addTransaction);

  void _submit() {
    debugPrint("IN SIBMIT");
    final enterTitel = _titleController.text;
    if (_amountController.text.isEmpty) {
      return;
    }
    final enterAmount = double.parse(_amountController.text);
    debugPrint("title : $enterTitel amount : $enterAmount");

    if (enterTitel.isEmpty && enterAmount >= 0.0) {
      debugPrint("No I don't");
      return;
    }

    debugPrint("title : $enterTitel amount : $enterAmount");
    widget._addTransaction(enterTitel, enterAmount,
        _pickedDate); // connetced props of paerent class in this Newtransaction

    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        _pickedDate = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  label: Text("title"),
                ),
                // onChanged: (val) {
                //   title = val;
                // },
                controller: _titleController,
                keyboardType: TextInputType.name,
                onSubmitted: (_) =>
                    _submit(), // _ meaning is we don't care this value or not use but we have to take
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text("amount"),
                ),
                keyboardType: TextInputType.number,
                // onChanged: (val) {
                //   amount = double.parse(val);
                // },
                controller: _amountController,
                onSubmitted: (_) => _submit(),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(children: [
                  Expanded(
                    child: Text(
                        'Picked Date : ${DateFormat.yMd().format(_pickedDate)}'),
                  ),
                  TextButton(
                    onPressed: _datePicker,
                    child: Text('choose date'),
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: FilledButton(
                  onPressed: _submit,
                  child: Text(
                    "Add Transaction",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColorDark,
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

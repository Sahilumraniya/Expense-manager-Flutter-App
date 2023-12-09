// import 'package:flutter/services.dart';
import '/widgets/chart.dart';
import '/widgets/new_transaction.dart';
import '/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';

void main() {
  /*
  off rotaetion
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Quicksand',
        // colorScheme: ColorScheme(error: Colors.red),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }

  // final List<Transacation> transations = [
  //   Transacation(id: 't1', title: 'Dosa', amount: 20, date: DateTime.now()),
  //   Transacation(id: 't2', title: 'Burger', amount: 50, date: DateTime.now()),
  //   Transacation(id: 't3', title: 'Puff', amount: 25, date: DateTime.now()),
  // ];

  // late String title;
  // late double amount;
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();
}

class _MyHomePage extends State<MyHomePage> {
  final List<Transacation> _usertransations = [
    // Transacation(id: 't1', title: 'Dosa', amount: 20, date: DateTime.now()),
    // Transacation(id: 't2', title: 'Burger', amount: 50, date: DateTime.now()),
    // Transacation(id: 't3', title: 'Puff', amount: 25, date: DateTime.now()),
  ];

  bool _showChrat = true;

  void _showAddTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        // _ is same as context
        return GestureDetector(
          child: NewTransaction(_addTransaction),
          onTap: () {},
        );
      },
    );
  }

  void _addTransaction(String title, double amount, DateTime pickedDate) {
    final newTx = Transacation(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: pickedDate,
    );

    setState(() {
      _usertransations.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransations.removeWhere((element) => element.id == id);
    });
  }

  List<Transacation> get _recentTransactions {
    return _usertransations.where((tx) {
      return tx.date!.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isLanscap =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appbar = AppBar(
      title: Text('Expense Manager'),
      actions: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: IconButton(
            icon: Icon(Icons.add_box, size: 40),
            onPressed: () {
              _showAddTransaction(context);
            },
          ),
        )
      ],
    );
    final txList = Container(
      height: (MediaQuery.of(context).size.height -
              appbar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
      child: TransacationList(_usertransations, _deleteTransaction),
    );

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround, // by defluat start
          // crossAxisAlignment: CrossAxisAlignment.start, // by defluat center
          children: [
            if (isLanscap)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Show Chart'),
                    Switch(
                        value: _showChrat,
                        onChanged: (val) {
                          setState(() {
                            _showChrat = val;
                          });
                        })
                  ],
                ),
              ),
            if (!isLanscap)
              Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                child: Chart(_recentTransactions),
              ),
            if (!isLanscap) txList,
            if (isLanscap)
              _showChrat
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appbar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.75,
                      child: Chart(_recentTransactions),
                    )
                  : txList,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showAddTransaction(context);
        },
      ),
    );
  }
}

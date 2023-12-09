import 'package:expensemanager/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransacationList extends StatelessWidget {
  final List<Transacation> transations;
  final Function deleteTransaction;

  TransacationList(this.transations, this.deleteTransaction);

  //ListView not optimaize
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     height: 430,
  //     // SingleChildScrollView in Cloume
  //     child: ListView(
  //       children: transations.map((tx) {
  //         return Card(
  //           child: Row(
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  //                 decoration: BoxDecoration(
  //                   border: Border.all(
  //                     style: BorderStyle.solid,
  //                     color: Color.fromARGB(206, 91, 248, 83),
  //                   ),
  //                   borderRadius: BorderRadius.all(Radius.circular(5)),
  //                   color: Color.fromARGB(213, 9, 173, 0),
  //                 ),
  //                 padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
  //                 child: Text(
  //                   // "₹ " + tx.amount.toString(),
  //                   "₹ ${tx.amount}",
  //                   style: TextStyle(
  //                       fontSize: 20,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     tx.title.toString(),
  //                     style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 20,
  //                     ),
  //                   ),
  //                   Text(
  //                     DateFormat('hh:mm:ss a dd/MM/yy ').format(tx.date!),
  //                     style: TextStyle(
  //                       color: Color.fromARGB(142, 35, 35, 0),
  //                       fontSize: 12,
  //                     ),
  //                   ),
  //                 ],
  //               )
  //             ],
  //           ),
  //         );
  //       }).toList(),
  //     ),
  //   );
  // }

  //ListView.builder()
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return transations.isEmpty
            ? Column(
                children: [
                  Text(
                    'No Transaction found!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Container(
                    height: constraints.maxHeight*0.85,
                    child: Image.asset('./assets/images/watting.gif'),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  // debugPrint("In ListView.builder $index and \ncontext : $context");
                  return Card(
                    elevation: 6,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: FittedBox(
                            child: Text(
                                '₹ ${transations[index].amount?.toStringAsFixed(1)}'),
                          ),
                        ),
                      ),
                      title: Text(
                        '${transations[index].title}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMMEEEEd()
                            .format(transations[index].date as DateTime),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.error,
                        onPressed: () =>
                            deleteTransaction(transations[index].id),
                      ),
                    ),
                  );
                },
                itemCount: transations.length,
              );
      },
    );
  }
}

// Card by me
/*
return Card(
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Theme.of(context).primaryColor,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                        child: Text(
                          // "₹ " + transations[index].amount.toString(),
                          "₹ ${transations[index].amount}",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transations[index].title.toString(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            DateFormat('hh:mm:ss a dd/MM/yy ')
                                .format(transations[index].date!),
                            style: TextStyle(
                              color: Color.fromARGB(142, 35, 35, 0),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
*/
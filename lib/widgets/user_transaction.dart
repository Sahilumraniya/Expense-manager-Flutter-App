import 'package:expensemanager/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class UserTransaction extends StatelessWidget {
  final List<Transacation> usertransations;

  UserTransaction(this.usertransations);

  @override
  Widget build(BuildContext context) {
    return TransacationList(transations: usertransations);
  }
}

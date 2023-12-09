// import 'package:flutter/material.dart'; // already have foundation import
import 'package:flutter/foundation.dart'; 

class Transacation {
  final String? id;
  final String? title;
  final double? amount;
  final DateTime? date;

  Transacation({@required this.id,@required this.title,@required this.amount,@required this.date});
}
import 'package:flutter/material.dart';

class ChartPipe extends StatelessWidget {
  final String label;
  final double totalAmount;
  // ignore: non_constant_identifier_names
  final double SpendingPctOfTotal;

  ChartPipe(this.label, this.totalAmount, this.SpendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.12,
              child: FittedBox(
                child: Text("₹ ${totalAmount.toStringAsFixed(0)}"),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.65,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  FractionallySizedBox(
                    heightFactor: SpendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.10,
              child: FittedBox(
                child: Text("${label}"),
              ),
            ),
          ],
        );
      },
    );
  }
}

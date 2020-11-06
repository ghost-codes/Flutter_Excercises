import 'dart:ui';

import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final List<double> weeklySpending;

  const BarChart({Key key, this.weeklySpending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _mostExpensive = 0;
    weeklySpending.forEach((price) {
      if(price>_mostExpensive){
        _mostExpensive = price;
      }
     });
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(
            "Weekly Spending",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 30.0,
                onPressed: () {},
              ),
              Text(
                "Nov 10, 2019 - Nov 16,2019",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                iconSize: 30.0,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Box(
                label: 'Su',
                amountSpent: weeklySpending[0],
                mostExpense: _mostExpensive,
              ),
              Box(
                label: 'Mo',
                amountSpent: weeklySpending[1],
                mostExpense: _mostExpensive,
              ),
              Box(
                label: 'Tu',
                amountSpent: weeklySpending[2],
                mostExpense: _mostExpensive,
              ),
              Box(
                label: 'We',
                amountSpent: weeklySpending[3],
                mostExpense: _mostExpensive,
              ),
              Box(
                label: 'Th',
                amountSpent: weeklySpending[4],
                mostExpense: _mostExpensive,
              ),
              Box(
                label: 'Fr',
                amountSpent: weeklySpending[5],
                mostExpense: _mostExpensive,
              ),
              Box(
                label: 'Sa',
                amountSpent: weeklySpending[6],
                mostExpense: _mostExpensive,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Box extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpense;

  final double _maxBarHeight = 150.0;
  const Box({Key key, this.label, this.amountSpent, this.mostExpense})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _barHeight = amountSpent / mostExpense * _maxBarHeight;
    return Column(
      children: [
        Text(
          "\$${amountSpent.toStringAsFixed(2)}",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 6.0),
        Container(
          height: _barHeight,
          width: 18.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        )
      ],
    );
  }
}


import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CapitalizationCalculator extends StatefulWidget {
  @override
  _CapitalizationCalculatorState createState() => _CapitalizationCalculatorState();
}

class _CapitalizationCalculatorState extends State{
    double initialAmount = 0.0;
    double interestRate = 0.0;
    int years = 0;
    double futureValue = 0.0;

  void calculateFutureValue() {
    setState(() {
    futureValue = initialAmount * pow(1 + interestRate / 100, years);
    });
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capitalizacion'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Initial Amount'),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  initialAmount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Interest Rate (%)'),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  interestRate = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Years'),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  years = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                calculateFutureValue();
              },
              child: Text('Calculate'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Future Value: $futureValue',
              style: TextStyle(fontSize: 20.0, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
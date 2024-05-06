import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AmortizationCalculator extends StatefulWidget {
  @override
  _AmortizationCalculatorState createState() => _AmortizationCalculatorState();
}

enum AmortizationType { Constant, StraightLine }

enum AmortizationMethod { American, French, German }

class _AmortizationCalculatorState extends State {
  double loanAmount = 0.0;
  double interestRate = 0.0;
  int years = 0;
  double monthlyPayment = 0.0;
  AmortizationType? amortizationType = AmortizationType
      .Constant; // Tipo de amortización seleccionado por el usuario
  AmortizationMethod? amortizationMethod =
      AmortizationMethod.American; // Método de amortización predeterminado

  void calculateMonthlyPayment() {
    if (amortizationType != null && amortizationMethod != null) {
      setState(() {
        int n = years * 12; // número total de pagos
        double monthlyInterestRate =
            interestRate / 100 / 12; // tasa de interés mensual
        double denominator = 0.0;
        // Calculamos el valor del denominador según el tipo de amortización seleccionado
        if (amortizationType == AmortizationType.Constant) {
          denominator = pow(1 + monthlyInterestRate, n) - 1;
        } else if (amortizationType == AmortizationType.StraightLine) {
          denominator = n.toDouble();
        }
        // Calculamos el pago mensual según el tipo de amortización
        if (denominator != 0) {
          monthlyPayment = loanAmount *
              monthlyInterestRate *
              (pow(1 + monthlyInterestRate, n)) /
              denominator;
        }
      });
    } else {
      // Mostrar un mensaje de error al usuario indicando que ambos ComboBox deben tener un valor seleccionado
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(
                'Please select values for both amortization type and method.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amortizacion'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField(
              value: amortizationType,
              items: [
                DropdownMenuItem(
                  child: Text('Constant Amortization',
                      style: TextStyle(
                          color: Colors.black)), // Texto en color blanco
                  value: AmortizationType.Constant,
                ),
                DropdownMenuItem(
                  child: Text('Straight Line Amortization',
                      style: TextStyle(
                          color: Colors.black)), // Texto en color blanco
                  value: AmortizationType.StraightLine,
                ),
              ],
              onChanged: (value) {
                setState(() {
                  amortizationType = value;
                });
              },
              decoration: InputDecoration(labelText: 'Amortization Type'),
            ),
            DropdownButtonFormField(
              value: amortizationMethod,
              items: [
                DropdownMenuItem(
                  child: Text('American',
                      style: TextStyle(
                          color: Colors.black)), // Texto en color blanco
                  value: AmortizationMethod.American,
                ),
                DropdownMenuItem(
                  child: Text('French',
                      style: TextStyle(
                          color: Colors.black)), // Texto en color blanco
                  value: AmortizationMethod.French,
                ),
                DropdownMenuItem(
                  child: Text('German',
                      style: TextStyle(
                          color: Colors.white)), // Texto en color blanco
                  value: AmortizationMethod.German,
                ),
              ],
              onChanged: (value) {
                setState(() {
                  amortizationMethod = value;
                });
              },
              decoration: InputDecoration(labelText: 'Amortization Method'),
            ),
            TextField(
              style: TextStyle(color: Colors.white), // Texto en color blanco
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Loan Amount'),
              onChanged: (value) {
                setState(() {
                  loanAmount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            TextField(
              style: TextStyle(color: Colors.white), // Texto en color blanco
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Interest Rate (%)'),
              onChanged: (value) {
                setState(() {
                  interestRate = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            TextField(
              style: TextStyle(color: Colors.white), // Texto en color blanco
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Years'),
              onChanged: (value) {
                setState(() {
                  years = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                calculateMonthlyPayment();
              },
              child: Text('Calculate'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Monthly Payment: $monthlyPayment',
              style: TextStyle(
                  fontSize: 20.0, color: Colors.white), // Texto en color blanco
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

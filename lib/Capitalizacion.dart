import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CapitalizationCalculator extends StatefulWidget {
  @override
  _CapitalizationCalculatorState createState() =>
      _CapitalizationCalculatorState();
}

class _CapitalizationCalculatorState extends State<CapitalizationCalculator> {
  double initialAmount = 0.0;
  double interestRate = 0.0;
  int years = 0;
  double futureValue = 0.0;
  String selectedCalculation = 'Compuesto';

  void calculateFutureValue() {
    setState(() {
      if (selectedCalculation == 'Compuesto') {
        futureValue = initialAmount * pow(1 + interestRate / 100, years);
      } else if (selectedCalculation == 'Simple') {
        futureValue = initialAmount * (1 + interestRate / 100 * years);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capitalization Calculator'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(28.0),
                child: Center(
                  child: Text(
                    "el sistema de capitalización se refiere a cómo crece una inversión a lo largo del tiempo, teniendo en cuenta el interés compuesto. Aquí, los intereses generados por la inversión se reinvierten, lo que lleva a un crecimiento exponencial del capital inicial. La capitalización puede ocurrir en diferentes períodos de tiempo, como anual, semestral, mensual, etc., dependiendo de los términos del acuerdo de inversión.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Center(
                      child: Text(
                        "F=P×(1+r)n",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      " F=P×(1+r×t) ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "F: valor futuro de la inversion ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "P: inversion inicial ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "r: tasa de interes ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "n: numero de periodos ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "n: numero de periodos ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "t: tiempo en años ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Initial Amount'),
                style: TextStyle(color: Color.fromARGB(255, 8, 3, 250)),
                onChanged: (value) {
                  setState(() {
                    initialAmount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Interest Rate (%)'),
                style: TextStyle(color: Color.fromARGB(255, 41, 5, 243)),
                onChanged: (value) {
                  setState(() {
                    interestRate = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Years'),
                style: TextStyle(color: Color.fromARGB(255, 5, 9, 236)),
                onChanged: (value) {
                  setState(() {
                    years = int.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 20.0),
              DropdownButton<String>(
                value: selectedCalculation,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCalculation = newValue!;
                  });
                },
                items: <String>['Compuesto', 'Simple']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
                style: TextStyle(
                    fontSize: 20.0, color: Color.fromARGB(255, 48, 3, 247)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

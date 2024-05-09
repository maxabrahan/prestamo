import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnualidadesPage extends StatefulWidget {
  @override
  _AnualidadesPageState createState() => _AnualidadesPageState();
}

class _AnualidadesPageState extends State<AnualidadesPage> {
  final TextEditingController capitalController = TextEditingController();
  final TextEditingController tasaInteresController = TextEditingController();
  final TextEditingController duracionAnualidadController =
      TextEditingController();

  double valorPresente = 0.0;
  double valorFuturo = 0.0;
  double monto = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anualidades'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Anualidades:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Una anualidad es una serie de pagos o depósitos iguales realizados a intervalos regulares. Las anualidades pueden ser utilizadas para calcular el valor presente, valor futuro y el monto de un préstamo o inversión.\n\n'
                'Fórmulas utilizadas:\n'
                'Valor Presente (VP) = C / ((1 - (1 + i)^-n) / i)\n'
                'Valor Futuro (VF) = C * (1 + i)^n\n'
                'Monto (M) = C * (i / (1 - (1 + i)^-n))\n\n'
                'Donde:\n'
                'C = Capital\n'
                'i = Tasa de interés por período (expresada como decimal)\n'
                'n = Duración de la anualidad en períodos',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: capitalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Capital'),
              ),
              TextField(
                controller: tasaInteresController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Tasa de Interés (%)'),
              ),
              TextField(
                controller: duracionAnualidadController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Duración de la Anualidad (años)'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  double capital = double.parse(capitalController.text);
                  double tasaInteres = double.parse(tasaInteresController.text);
                  int duracionAnualidad =
                      int.parse(duracionAnualidadController.text);
                  calcularAnualidades(capital, tasaInteres, duracionAnualidad);
                },
                child: Text('Calcular Anualidades'),
              ),
              SizedBox(height: 20),
              Text('Valor Presente: \$${valorPresente.toStringAsFixed(2)}'),
              Text('Valor Futuro: \$${valorFuturo.toStringAsFixed(2)}'),
              Text('Monto: \$${monto.toStringAsFixed(2)}'),
            ],
          ),
        ),
      ),
    );
  }

  void calcularAnualidades(
      double capital, double tasaInteres, int duracionAnualidad) {
    double tasaDecimal = tasaInteres / 100;
    double factor =
        (1 - pow(1 + tasaDecimal, -duracionAnualidad)) / tasaDecimal;

    setState(() {
      valorPresente = capital / factor;
      valorFuturo = capital * (pow(1 + tasaDecimal, duracionAnualidad));
      monto = capital *
          (tasaDecimal / (1 - pow(1 + tasaDecimal, -duracionAnualidad)));
    });
  }
}

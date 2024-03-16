import 'dart:math';

import 'package:flutter/material.dart';

class InterestCalculatorPage extends StatefulWidget {
  InterestCalculatorPage({Key? key}) : super(key: key);

  @override
  _InterestCalculatorPageState createState() => _InterestCalculatorPageState();
}

class _InterestCalculatorPageState extends State<InterestCalculatorPage> {
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _tasaController = TextEditingController();
  final TextEditingController _aniosController = TextEditingController();
  final TextEditingController _mesesController = TextEditingController();
  final TextEditingController _diasController = TextEditingController();
  final TextEditingController _montoCompuestoController = TextEditingController();

  String selectedRateType = 'Diariamente';

  void _calcularMonto() {
    double capital = double.tryParse(_capitalController.text) ?? 0;
    double tasa = double.tryParse(_tasaController.text) ?? 0;
    int anios = int.tryParse(_aniosController.text) ?? 0;
    int meses = int.tryParse(_mesesController.text) ?? 0;
    int dias = int.tryParse(_diasController.text) ?? 0;
    int totalDias = (anios * 360) + (meses * 30) + dias;
    if (selectedRateType == 'Diariamente') {
      double monto = capital * pow(1 + ((tasa / 100) / 360), totalDias);
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Mensualmente') {
      double monto = capital * pow(1 + ((tasa / 100) / 12), (totalDias / 30));
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Trimestralmente') {
      double monto = capital * pow(1 + ((tasa / 100) / 4), (totalDias / 90));
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Cuatrimestralmente') {
      double monto = capital * pow(1 + ((tasa / 100) / 3), (totalDias / 120));
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Semestralmente') {
      double monto = capital * pow(1 + ((tasa / 100) / 2), (totalDias / 180));
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'Anualmente') {
      double monto = capital * pow(1 + (tasa / 100), (totalDias / 360));
      _montoCompuestoController.text = monto.toStringAsFixed(2);
    }
    setState(() {}); // Agrega esta línea para actualizar la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de Interés Compuesto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('El interés compuesto es un método financiero donde los intereses se calculan no solo sobre el capital inicial, sino también sobre los intereses acumulados. Con el tiempo, esto resulta en un crecimiento exponencial de la inversión. A medida que los intereses se reinvierten, el capital total aumenta, generando mayores ganancias en comparación con el interés simple.'),
            TextField(
              controller: _capitalController,
              decoration: InputDecoration(labelText: 'Capital'),
            ),
            TextField(
              controller: _tasaController,
              decoration: InputDecoration(labelText: 'Tasa (%)'),
            ),
            TextField(
              controller: _aniosController,
              decoration: InputDecoration(labelText: 'Años'),
            ),
            TextField(
              controller: _mesesController,
              decoration: InputDecoration(labelText: 'Meses'),
            ),
            TextField(
              controller: _diasController,
              decoration: InputDecoration(labelText: 'Días'),
            ),
            DropdownButton<String>(
              value: selectedRateType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedRateType = newValue!;
                });
              },
              items: <String>[
                'Diariamente',
                'Mensualmente',
                'Trimestralmente',
                'Cuatrimestralmente',
                'Semestralmente',
                'Anualmente'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _calcularMonto,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text('Monto Compuesto: ${_montoCompuestoController.text}'),
            
          ],
        ),
      ),
    );
  }
}
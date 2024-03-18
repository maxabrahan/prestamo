import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class InteresSimple extends StatefulWidget {
  @override
  _InteresSimpleState createState() => _InteresSimpleState();
}

class _InteresSimpleState extends State<InteresSimple> {
  String selectedRateType = 'interes';
  TextEditingController _fechaInicialController = TextEditingController();
  TextEditingController _fechaFinalController = TextEditingController();

  int tiempo = 0;

  final _resultadoController = TextEditingController();
  final _capitalController = TextEditingController();
  final _tasaController = TextEditingController();
  final _aniosController = TextEditingController();
  final _mesesController = TextEditingController();
  final _diasController = TextEditingController();
  final _interesController = TextEditingController();
  TextEditingController _montoSimpleController = TextEditingController();
  final _montoController = TextEditingController();
  void _calcularMonto() {
    double capital = double.tryParse(_capitalController.text) ?? 0;
    double tasainteres = double.tryParse(_tasaController.text) ?? 0;
    int anios = int.tryParse(_aniosController.text) ?? 0;
    int meses = int.tryParse(_mesesController.text) ?? 0;
    int dias = int.tryParse(_diasController.text) ?? 0;
    double interes = double.tryParse(_interesController.text) ?? 0;
    double monto = double.tryParse(_montoController.text) ?? 0;

    double calculatedMonto = 0.0;
    String calculatedValueDescription = '';

    if (selectedRateType == 'interes') {
      calculatedMonto =
          capital * (tasainteres / 100) * (anios + meses / 12 + dias / 360);
      calculatedValueDescription = 'Interes';
    }
    if (selectedRateType == 'capital') {
      calculatedMonto =
          interes / ((tasainteres / 100) * (anios + meses / 12 + dias / 360));
      calculatedValueDescription = 'capital';
    }
    if (selectedRateType == 'tasa de interes') {
      calculatedMonto =
          interes / ((capital) * (anios + meses / 12 + dias / 360));
      calculatedValueDescription = 'tasa de interes';
    }
    if (selectedRateType == 'tiempo') {
      calculatedMonto = interes / (capital * (tasainteres / 100));
      calculatedValueDescription = 'tiempo';
    }

    if (selectedRateType == 'monto') {
      calculatedMonto = capital * (1 + tasainteres / 100 * tiempo / 365);
      calculatedValueDescription = 'monto';
    }

    _montoSimpleController.text = calculatedMonto.toStringAsFixed(2);
    _resultadoController.text =
        "Valor del $calculatedValueDescription: ${calculatedMonto.toStringAsFixed(2)}";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Resultado"),
          content: Text(
            "Valor del $calculatedValueDescription: ${calculatedMonto.toStringAsFixed(2)}",
          ),
        );
      },
    );

    setState(() {}); // Agrega esta línea para actualizar la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interes Simple"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Center(
                  child: Text(
                    "Interés simple es el que resulta cuando los intereses generados en el tiempo que dura una inversión se deben únicamente al capital inicial. Normalmente se utiliza para operaciones a corto plazo (menos de un año).",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Formulas:",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Center(
                      child: Text(
                        "Interes simple:I = (C) (i) (t)",
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
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "Monto:M = C (1+(i) (t))",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "Capital:C = I/ (i) (t)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "Tasa de interes:i = i / (C) (t)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "Tiempo:t = I/ (C) (i)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
              DropdownButton<String>(
                value: selectedRateType,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRateType = newValue!;
                  });
                },
                items: <String>[
                  'interes',
                  'capital',
                  'tasa de interes',
                  'monto',
                  'tiempo',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _capitalController,
                      decoration: InputDecoration(
                        hintText: 'Ingrese el capital',
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _tasaController,
                  decoration: InputDecoration(
                    hintText: 'Ingrese la tasa de interes',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _aniosController,
                  decoration: InputDecoration(
                    hintText: 'Ingrese la cantidad de años',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _mesesController,
                  decoration: InputDecoration(
                    hintText: 'Ingrese la cantidad de meses',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _diasController,
                  decoration: InputDecoration(
                    hintText: 'Ingrese la cantidad de dias',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _interesController,
                  decoration: InputDecoration(
                    hintText: 'Ingrese el Interes',
                  ),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _calcularMonto,
                    child: Text('Calcular'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _limpiarCampos();
                      });
                    },
                    child: Text('Limpiar Campos'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _limpiarCampos() {
    _capitalController.text = '';
    _tasaController.text = '';
    _aniosController.text = '';
    _mesesController.text = '';
    _diasController.text = '';
    _interesController.text = '';
    _resultadoController.text = '';
    setState(() {
      _montoSimpleController.text = '';
    });
  }
}

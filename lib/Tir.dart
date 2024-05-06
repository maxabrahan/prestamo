import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pro0030/Tir%20prueba.dart';

class TirCalculatorPage extends StatefulWidget {
  TirCalculatorPage({Key? key}) : super(key: key);

  @override
  _TirCalculatorPageState createState() => _TirCalculatorPageState();
}

class _TirCalculatorPageState extends State<TirCalculatorPage> {
  final TextEditingController _inversionInicialController =
      TextEditingController();
  final TextEditingController _tasaDescuentoController =
      TextEditingController();
  final TextEditingController _resultadoTIRController = TextEditingController();
  final TextEditingController _resultadoVANController = TextEditingController();
  final List<TextEditingController> _flujosCajaControllers = [
    TextEditingController()
  ];

  void _calcularTIRVAN() {
    double inversionInicial =
        double.tryParse(_inversionInicialController.text) ?? 0;
    double tasaDescuento = double.tryParse(_tasaDescuentoController.text) ?? 0;

    List<double> flujosDeCaja = [];
    double van = 0;

    for (int i = 0; i < _flujosCajaControllers.length; i++) {
      double flujo = double.tryParse(_flujosCajaControllers[i].text) ?? 0;
      van += flujo /
          pow(1 + (tasaDescuento / 100),
              i + 1); // Descuento de flujos de caja para calcular VAN
      flujosDeCaja.add(flujo);
    }

    van -= inversionInicial; // Restar inversión inicial para obtener VAN

    _resultadoVANController.text = van.toStringAsFixed(2);

    double tir = _calcularTIR(inversionInicial, flujosDeCaja);
    _resultadoTIRController.text = tir.toStringAsFixed(2) + "%";
  }

  double _calcularTIR(double inversionInicial, List<double> flujosDeCaja) {
    double tir = 0;
    double epsilon = 0.0001;

    double van = 0;
    for (int i = 0; i < flujosDeCaja.length; i++) {
      van += flujosDeCaja[i] / pow(1 + (tir / 100), i + 1);
    }
    van -= inversionInicial;

    double tirPrev = -100.0;
    double tirNext = 100.0;

    do {
      tir = (tirPrev + tirNext) / 2;

      van = 0;
      for (int i = 0; i < flujosDeCaja.length; i++) {
        van += flujosDeCaja[i] / pow(1 + (tir / 100), i + 1);
      }
      van -= inversionInicial;

      if (van > 0) {
        tirPrev = tir;
      } else {
        tirNext = tir;
      }
    } while ((tirNext - tirPrev).abs() > epsilon);

    return tir;
  }

  void _agregarNuevoFlujoCaja() {
    setState(() {
      _flujosCajaControllers.add(TextEditingController());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de TIR y VAN'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  'La Tasa Interna de Retorno (TIR) y el Valor Actual Neto (VAN) son herramientas cruciales '
                  'en la evaluación de proyectos de inversión. La TIR representa la tasa de rendimiento de un '
                  'proyecto, mientras que el VAN indica la diferencia entre el valor presente de los flujos de '
                  'efectivo y la inversión inicial. Utiliza esta calculadora para determinar la TIR y el VAN '
                  'de tus proyectos.\n\n'
                  'Fórmulas:\n'
                  'TIR (Tasa Interna de Retorno):\n'
                  'TIR = (-b ± √(b^2 – 4ac)) / 2a\n\n'
                  'VAN (Valor Actual Neto):\n'
                  'VAN = ∑(Qt / (1 + k)^t) - A\n\n'
                  'Donde:\n'
                  '- Qt: Flujo de efectivo en el período t.\n'
                  '- k: Tasa de descuento o tasa de interés requerida.\n'
                  '- A: Inversión inicial.\n'
                  '- La suma se extiende sobre todos los períodos de tiempo.',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: _inversionInicialController,
                decoration: InputDecoration(labelText: 'Inversión Inicial'),
              ),
              TextField(
                controller: _tasaDescuentoController,
                decoration: InputDecoration(labelText: 'Tasa de Descuento (%)'),
              ),
              SizedBox(height: 10),
              Text("Flujo de Caja:"),
              ListView.builder(
                shrinkWrap: true,
                itemCount: _flujosCajaControllers.length,
                itemBuilder: (context, index) {
                  return TextField(
                    controller: _flujosCajaControllers[index],
                    decoration: InputDecoration(
                        labelText: 'Flujo de Caja ${index + 1}'),
                  );
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _agregarNuevoFlujoCaja,
                child: Text('Agregar Nuevo Año'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _calcularTIRVAN();
                  setState(() {}); // Actualizar estado para mostrar resultados
                },
                child: Text('Calcular TIR y VAN'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TirPruebaCalculatorPage(),
                    ),
                  );
                },
                child: Text('Calcular TIR y VAN prueba'),
              ),
              SizedBox(height: 20),
              Text('TIR: ${_resultadoTIRController.text}'),
              Text('VAN: ${_resultadoVANController.text}'),
            ],
          ),
        ),
      ),
    );
  }
}

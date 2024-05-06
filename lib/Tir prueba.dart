import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TirPruebaCalculatorPage extends StatefulWidget {
  TirPruebaCalculatorPage({Key? key}) : super(key: key);

  @override
  _TirPruebaCalculatorPageState createState() =>
      _TirPruebaCalculatorPageState();
}

class _TirPruebaCalculatorPageState extends State<TirPruebaCalculatorPage> {
  final TextEditingController _inversionInicialController =
      TextEditingController();
  final TextEditingController _tasaDescuentoController =
      TextEditingController();
  final TextEditingController _resultadoTIRController = TextEditingController();
  final TextEditingController _resultadoVANController = TextEditingController();
  final List<YearlyCashFlow> _flujosCaja = [YearlyCashFlow(year: 1)];

  void _calcularTIRVAN() {
    double inversionInicial =
        double.tryParse(_inversionInicialController.text) ?? 0;
    double tasaDescuento = double.tryParse(_tasaDescuentoController.text) ?? 0;

    // Calcular el VAN
    double van = -inversionInicial; // Iniciar con la inversión inicial
    for (int i = 0; i < _flujosCaja.length; i++) {
      double flujoNeto = _flujosCaja[i].totalCashFlow;
      van +=
          flujoNeto / pow(1 + (tasaDescuento / 100), i + 1); // Fórmula del VAN
    }

    _resultadoVANController.text =
        van.toStringAsFixed(2); // Mostrar el VAN en el campo de texto

    double tir = _calcularTIR(inversionInicial,
        _flujosCaja.map((cashFlow) => cashFlow.totalCashFlow).toList());
    _resultadoTIRController.text = tir.toStringAsFixed(2) + "%";
  }

  double _calcularTIR(double inversionInicial, List<double> flujosDeCaja) {
    double tir = 0;
    double epsilon = 0.0001;

    double van = -inversionInicial; // Iniciar con la inversión inicial
    for (int i = 0; i < flujosDeCaja.length; i++) {
      van += flujosDeCaja[i] / pow(1 + (tir / 100), i + 1);
    }

    double tirPrev = -100.0;
    double tirNext = 100.0;

    do {
      tir = (tirPrev + tirNext) / 2;

      van = -inversionInicial; // Reiniciar el VAN con la inversión inicial
      for (int i = 0; i < flujosDeCaja.length; i++) {
        van += flujosDeCaja[i] / pow(1 + (tir / 100), i + 1);
      }

      if (van > 0) {
        tirPrev = tir;
      } else {
        tirNext = tir;
      }
    } while ((tirNext - tirPrev).abs() > epsilon);

    return tir;
  }

  void _agregarNuevoFlujoCaja() {
    int year = _flujosCaja.isNotEmpty ? _flujosCaja.last.year + 1 : 1;
    setState(() {
      _flujosCaja.add(YearlyCashFlow(year: year));
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
              Text(
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
                style: TextStyle(fontSize: 16),
              ),
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
              Column(
                children: _flujosCaja.map((cashFlow) {
                  return Row(
                    children: [
                      Flexible(
                        child: TextField(
                          controller: cashFlow.cobrosController,
                          decoration: InputDecoration(
                              labelText: 'Cobros Año ${cashFlow.year}'),
                          onChanged: (_) => cashFlow.actualizarFlujoCaja(),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: TextField(
                          controller: cashFlow.costosController,
                          decoration: InputDecoration(
                              labelText: 'Costos Año ${cashFlow.year}'),
                          onChanged: (_) => cashFlow.actualizarFlujoCaja(),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: TextField(
                          controller: cashFlow.flujoCajaController,
                          decoration: InputDecoration(
                              labelText: 'Flujo de Caja Año ${cashFlow.year}'),
                          enabled: false,
                        ),
                      ),
                    ],
                  );
                }).toList(),
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

class YearlyCashFlow {
  final int year;
  final TextEditingController cobrosController;
  final TextEditingController costosController;
  final TextEditingController flujoCajaController;

  double get totalCashFlow {
    double cobros = double.tryParse(cobrosController.text) ?? 0;
    double costos = double.tryParse(costosController.text) ?? 0;
    return cobros - costos;
  }

  void actualizarFlujoCaja() {
    double cobros = double.tryParse(cobrosController.text) ?? 0;
    double costos = double.tryParse(costosController.text) ?? 0;
    flujoCajaController.text = (cobros - costos).toString();
  }

  YearlyCashFlow({required this.year})
      : cobrosController = TextEditingController(),
        costosController = TextEditingController(),
        flujoCajaController = TextEditingController();
}

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class InteresSimple extends StatefulWidget {
  @override
  _InteresSimpleState createState() => _InteresSimpleState();
}

class _InteresSimpleState extends State<InteresSimple> {
  String selectedRateType = 'Anualmente';
  TextEditingController _fechaInicialController = TextEditingController();
  TextEditingController _fechaFinalController = TextEditingController();

  int tiempo = 0;

  final _resultadoController = TextEditingController();
  final _capitalController = TextEditingController();
  final _aniosController = TextEditingController();
  final _mesesController = TextEditingController();
  final _diasController = TextEditingController();
  final _tasaController = TextEditingController();
  final _interesController = TextEditingController();
  TextEditingController _montoSimpleController = TextEditingController();
  final _montoController = TextEditingController();
  double capital = 0;
  double tasainteres = 0;
  int anios = 0;
  int meses = 0;
  int dias = 0;
  double interes = 0;
  double monto = 0;
  int diario = 0;
  int mensual = 0;
  int trimestral = 0;
  int cuatrimestral = 0;
  int semestral = 0;
  int anual = 0;

  int totalDias = 0;

  void actualizarVariablesDesdeControladores() {
    capital = double.tryParse(_capitalController.text) ?? 0;
    tasainteres = double.tryParse(_tasaController.text) ?? 0;
    anios = int.tryParse(_aniosController.text) ?? 0;
    meses = int.tryParse(_mesesController.text) ?? 0;
    dias = int.tryParse(_diasController.text) ?? 0;
    interes = double.tryParse(_interesController.text) ?? 0;
    monto = double.tryParse(_montoController.text) ?? 0;
  }

  void calcularInteres() {
    actualizarVariablesDesdeControladores();
    double calculatedInteres = 0.0;
    double interes = 0.0;
    String calculatedValueDescription = '';

    calculatedInteres =
        capital * (tasainteres / 100) * (anios + meses / 12 + dias / 360);
    calculatedValueDescription = 'Interes ';

    if (selectedRateType == 'Anualmente') {
      calculatedInteres =
          capital * (tasainteres / 100) * (anios + meses / 12 + dias / 365);
      calculatedValueDescription = 'Interes  anual';
    }

    if (selectedRateType == 'Mensualmente') {
      calculatedInteres =
          capital * (tasainteres / 100) * (anios * 12 + meses + dias / 30);
      calculatedValueDescription = 'Interes  mensual';
    }

    if (selectedRateType == 'Trimestralmente') {
      calculatedInteres = capital *
          (tasainteres / 100) *
          (anios * 4 + meses / 3 + dias / 91.25);
      calculatedValueDescription = 'Interes  trimestral';
    }

    if (selectedRateType == 'Cuatrimestralmente') {
      calculatedInteres = capital *
          (tasainteres / 100) *
          (anios * 4 + meses / 4 + dias / 91.25);
      calculatedValueDescription = 'Interes  cuatrimestral';
    }
    if (selectedRateType == 'Semestralmente') {
      calculatedInteres = capital *
          (tasainteres / 100) *
          (anios * 2 + meses / 6 + dias / 182.5);
      calculatedValueDescription = 'Interes  semestral';
    }

    _montoSimpleController.text = calculatedInteres.toStringAsFixed(2);
    _resultadoController.text =
        "Valor del $calculatedValueDescription: ${calculatedInteres.toStringAsFixed(2)}";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Resultado"),
          content: Text(
            "Valor del $calculatedValueDescription: ${calculatedInteres.toStringAsFixed(2)}",
          ),
        );
      },
    );
    setState(() {});
  }

  void calcularCapital() {
    actualizarVariablesDesdeControladores();
    double calculatedCapital = 0.0;
    String calculatedValueDescription = '';

    if (selectedRateType == 'Anualmente') {
      calculatedCapital =
          interes / ((tasainteres / 100) * (anios + meses / 12 + dias / 360));
      calculatedValueDescription = 'capital anual';
    }

    if (selectedRateType == 'Mensualmente') {
      calculatedCapital =
          interes / ((tasainteres / 100) * (anios * 12 + meses + dias / 30));

      calculatedValueDescription = 'capital mensual';
    }

    if (selectedRateType == 'Trimestralmente') {
      calculatedCapital = interes /
          ((tasainteres / 100) * (anios * 4 + meses / 3 + dias / 91.25));

      calculatedValueDescription = 'capital trimestral';
    }

    if (selectedRateType == 'Cuatrimestralmente') {
      calculatedCapital = interes /
          ((tasainteres / 100) * (anios * 4 + meses / 4 + dias / 91.25));
      calculatedValueDescription = 'Interes  cuatrimestral';
    }
    if (selectedRateType == 'Semestralmente') {
      calculatedCapital = interes /
          ((tasainteres / 100) * (anios * 2 + meses / 6 + dias / 182.5));
      calculatedValueDescription = 'Interes  cuatrimestral';
    }

    _montoSimpleController.text = calculatedCapital.toStringAsFixed(2);
    _resultadoController.text =
        "Valor del $calculatedValueDescription: ${calculatedCapital.toStringAsFixed(2)}";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Resultado"),
          content: Text(
            "Valor del $calculatedValueDescription: ${calculatedCapital.toStringAsFixed(2)}",
          ),
        );
      },
    );
    setState(() {});
  }

  void calcularTasa() {
    actualizarVariablesDesdeControladores();
    double calculatedTasa = 0.0;
    String calculatedValueDescription = '';

    if (selectedRateType == 'Anualmente') {
      calculatedTasa =
          interes / ((capital) * (anios + meses / 12 + dias / 360));
      calculatedValueDescription = 'tasa de interes anual';
    }

    if (selectedRateType == 'Mensualmente') {
      calculatedTasa = interes / ((capital) * (anios * 12 + meses + dias / 30));
      calculatedValueDescription = 'tasa de interes mensual';
    }

    if (selectedRateType == 'Trimestralmente') {
      calculatedTasa =
          interes / ((capital) * (anios * 4 + meses / 3 + dias / 91.25));
      calculatedValueDescription = 'tasa de interes trimestral';
    }

    if (selectedRateType == 'Cuatrimestralmente') {
      calculatedTasa =
          interes / ((capital) * (anios * 4 + meses / 4 + dias / 91.25));
      calculatedValueDescription = 'tasa de interes  cuatrimestral';
    }
    if (selectedRateType == 'Semestralmente') {
      calculatedTasa =
          interes / ((capital) * (anios * 2 + meses / 6 + dias / 182.5));
      calculatedValueDescription = 'tasa de interes semestral';
    }

    _montoSimpleController.text = calculatedTasa.toStringAsFixed(2);
    _resultadoController.text =
        "Valor del $calculatedValueDescription: ${calculatedTasa.toStringAsFixed(2)}";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Resultado"),
          content: Text(
            "Valor del $calculatedValueDescription: ${calculatedTasa.toStringAsFixed(2)}",
          ),
        );
      },
    );
    setState(() {});
  }

  void calcularMonto() {
    actualizarVariablesDesdeControladores();
    double calculatedMonto = 0.0;
    String calculatedValueDescription = '';

    if (selectedRateType == 'Anualmente') {
      calculatedMonto =
          capital * (1 + tasainteres / 100 * anios * meses / 12 * dias / 365);

      calculatedValueDescription = 'Monto anual';
    }

    if (selectedRateType == 'Mensualmente') {
      calculatedMonto =
          capital * (1 + tasainteres / 100 * anios * 12 + meses + dias / 30);
      calculatedValueDescription = 'Monto mensual';
    }

    if (selectedRateType == 'Trimestralmente') {
      calculatedMonto = capital *
          (1 + tasainteres / 100 * anios * 4 + meses / 3 + dias / 91.25);

      calculatedValueDescription = 'Monto trimestral';
    }

    if (selectedRateType == 'Cuatrimestralmente') {
      calculatedMonto = capital *
          (1 + tasainteres / 100 * anios * 4 + meses / 4 + dias / 91.25);

      calculatedValueDescription = 'Monto  cuatrimestral';
    }
    if (selectedRateType == 'Semestralmente') {
      calculatedMonto = capital *
          (1 + tasainteres / 100 * anios * 2 + meses / 6 + dias / 182.5);

      calculatedValueDescription = 'Monto semestral';
    }

    _montoSimpleController.text = calculatedMonto.toStringAsFixed(2);
    _resultadoController.text =
        "Valor del $calculatedValueDescription: ${calculatedMonto.toStringAsFixed(2)}";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Resultado"),
          content: Text(
            "Valor del $calculatedValueDescription: ${calculatedMonto.toStringAsFixed(2)}",
          ),
        );
      },
    );
    setState(() {});
  }

  void calcularTiempo() {
    actualizarVariablesDesdeControladores();
    double calculatedTiempo = 0.0;
    String calculatedValueDescription = '';

    calculatedTiempo = interes / (capital * (tasainteres / 100));
    calculatedValueDescription = 'tiempo';

    _montoSimpleController.text = calculatedTiempo.toStringAsFixed(2);
    _resultadoController.text =
        "Valor del $calculatedValueDescription: ${calculatedTiempo.toStringAsFixed(2)}";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Resultado"),
          content: Text(
            "Valor del $calculatedValueDescription: ${calculatedTiempo.toStringAsFixed(2)}",
          ),
        );
      },
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interes Simple"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(28.0),
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
              const Padding(
                padding: EdgeInsets.all(10.0),
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
              const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(1.0),
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
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
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
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
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
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
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
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
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
              SizedBox(height: 10),
              Container(
                child: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Center(
                    child: Text(
                      "C: Capital ,  i: interes ",
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
                  'Anualmente',
                  'Mensualmente',
                  'Trimestralmente',
                  'Cuatrimestralmente',
                  'Semestralmente',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 30),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _capitalController,
                      decoration: const InputDecoration(
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
                  decoration: const InputDecoration(
                    hintText: 'Ingrese la tasa de interes',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _aniosController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese la cantidad de años',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _diasController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese la cantidad de dias',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _mesesController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese la cantidad de meses',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _interesController,
                  decoration: const InputDecoration(
                    hintText: 'Ingrese el Interes',
                  ),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            width: MediaQuery.of(context).size.width * 1.5,
                            child: GridView.count(
                              crossAxisCount: 2, // Dos columnas
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    calcularInteres();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .white, // Cambia el color del botón aquí
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('assets/interes.png'),
                                      Text(
                                        'Interés',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight
                                              .bold, // Cambia el color del texto aquí
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    calcularCapital();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .white, // Cambia el color del botón aquí
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('assets/Capital.png'),
                                      Text(
                                        'Capital',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight
                                              .bold, // Cambia el color del texto aquí
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    calcularTasa();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .white, // Cambia el color del botón aquí
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('assets/Tasa interes.png'),
                                      Text(
                                        'Tasa de interes',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight
                                              .bold, // Cambia el color del texto aquí
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    calcularMonto();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .white, // Cambia el color del botón aquí
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('assets/monto.png'),
                                      Text(
                                        'Monto',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight
                                              .bold, // Cambia el color del texto aquí
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    calcularTiempo();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors
                                        .white, // Cambia el color del botón aquí
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('assets/tiempo.png'),
                                      Text(
                                        'Tiempo',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight
                                              .bold, // Cambia el color del texto aquí
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text('Calcular'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _limpiarCampos();
                      });
                    },
                    child: const Text('Limpiar Campos'),
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

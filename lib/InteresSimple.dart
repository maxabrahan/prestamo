import 'package:flutter/material.dart';

class FechasModal extends StatefulWidget {
  @override
  _FechasModalState createState() => _FechasModalState();
}

class _FechasModalState extends State<FechasModal> {
  TextEditingController _fechaInicialController = TextEditingController();
  TextEditingController _fechaFinalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monto"),
      ),
    );
  }
}

class InteresSimple extends StatefulWidget {
  @override
  _InteresSimpleState createState() => _InteresSimpleState();
}

class _InteresSimpleState extends State<InteresSimple> {
  String selectedRateType = 'interes';

  final _resultadoController = TextEditingController();
  final _capitalController = TextEditingController();
  final _tasaController = TextEditingController();
  final _aniosController = TextEditingController();
  final _mesesController = TextEditingController();
  final _diasController = TextEditingController();
  final _interesController = TextEditingController();
  TextEditingController _montoSimpleController = TextEditingController();
  final _tiempoController = TextEditingController();
  final _montoController = TextEditingController();
  void _calcularMonto() {
    double capital = double.tryParse(_capitalController.text) ?? 0;
    double tasainteres = double.tryParse(_tasaController.text) ?? 0;
    int anios = int.tryParse(_aniosController.text) ?? 0;
    int meses = int.tryParse(_mesesController.text) ?? 0;
    int dias = int.tryParse(_diasController.text) ?? 0;
    double interes = double.tryParse(_interesController.text) ?? 0;
    double monto = double.tryParse(_montoController.text) ?? 0;
    int tiempo = int.tryParse(_tiempoController.text) ?? 0;

    if (selectedRateType == 'interes') {
      double monto =
          capital * (tasainteres / 100) * (anios + meses / 12 + dias / 360);
      _montoSimpleController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'capital') {
      double monto =
          interes / ((tasainteres / 100) * (anios + meses / 12 + dias / 360));
      _montoSimpleController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'tasa de interes') {
      double monto = interes / ((capital) * (anios + meses / 12 + dias / 360));
      _montoSimpleController.text = monto.toStringAsFixed(2);
    }
    if (selectedRateType == 'tiempo') {
      double monto = interes / (capital * (tasainteres / 100));
      _montoSimpleController.text = monto.toStringAsFixed(2);
    }

    if (selectedRateType == 'monto') {
      double monto = capital * (1 + interes / 100 * tiempo / 365);
      _montoSimpleController.text = monto.toStringAsFixed(2);
    }

    setState(() {}); // Agrega esta línea para actualizar la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interes Simple"),
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
                      fontWeight: FontWeight.bold,
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
                        border: OutlineInputBorder(),
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
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese la tasa de interes',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _aniosController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese la cantidad de años',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _mesesController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese la cantidad de meses',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _diasController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese la cantidad de dias',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _interesController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
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
              SizedBox(height: 20),
              Text('Resultado: ${_montoSimpleController.text}'),
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

import 'dart:math';
import 'package:flutter/material.dart';

class Anualidades extends StatefulWidget {
  @override
  _AnualidadesState createState() => _AnualidadesState();
}

class _AnualidadesState extends State<Anualidades> {
  String selectedAnnuityType = 'Anticipada';
  double capital = 0.0;
  double tasainteres = 0.0;
  DateTime? selectedDate;

  TextEditingController capitalController = TextEditingController();
  TextEditingController tasaInteresController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anualidades'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Anualidades: Pagos iguales realizados a intervalos regulares.',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 10),
            Text(
              'Ejemplos de fórmulas:',
              style: TextStyle(fontSize: 14),
            ),
            Text(
                'Valor actual (PV): PV = C × [1 - (1 + r/n)^-t * (r/n)] / (1 + r/n)',
                style: TextStyle(fontSize: 14)),
            Text(
                'Valor futuro (FV): FV = C × [(1 + r/n)^t - 1 * (r/n)] / (1 + r/n)',
                style: TextStyle(fontSize: 14)),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedAnnuityType,
              hint: Text('Selecciona el tipo de Anualidad'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedAnnuityType = newValue ?? '';
                });
              },
              items: <String>['Anticipada', 'Diferida', 'Vencida', 'Ordinaria']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              controller: capitalController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  capital = double.parse(value);
                });
              },
              decoration: InputDecoration(labelText: 'Capital '),
            ),
            TextField(
              controller: tasaInteresController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  tasainteres = double.parse(value) / 100;
                });
              },
              decoration: InputDecoration(labelText: 'Tasa de Interés (%)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: Text(selectedDate != null
                  ? 'Fecha seleccionada: ${selectedDate!.toString().substring(0, 10)}'
                  : 'Seleccionar fecha'),
            ),
            SizedBox(height: 20),
            Row(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    if (selectedAnnuityType.isNotEmpty &&
                        capital != 0.0 &&
                        tasainteres != 0.0) {
                      // Calcular Valor Presente
                      double result = calcularValorPresente(capital,
                          tasainteres, selectedDate!, selectedAnnuityType);
                      _showResult('Valor Presente', result);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Por favor completa todos los campos'),
                        ),
                      );
                    }
                  },
                  child: Text('Calcular PV'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (selectedAnnuityType.isNotEmpty &&
                        capital != 0.0 &&
                        tasainteres != 0.0) {
                      // Calcular Valor Futuro
                      double result = calcularValorFuturo(capital, tasainteres,
                          selectedDate!, selectedAnnuityType);
                      _showResult('Valor Futuro', result);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Por favor completa todos los campos'),
                        ),
                      );
                    }
                  },
                  child: Text('Calcular FV'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double calcularValorPresente(double capital, double tasaInteres,
      DateTime tiempo, String selectedType) {
    double yearsDifference = _calculateTimePeriod(tiempo);
    double resultInteres = tasaInteres / 100;
    double factor = pow(1 + resultInteres, yearsDifference).toDouble();

    if (selectedType == 'Anticipada') {
      double factor = pow(1 + resultInteres, -1).toDouble();
      return capital / factor;
    } else if (selectedType == 'Diferida') {
      return capital * factor;
    } else if (selectedType == 'Vencida') {
      return capital * (1 - 1 / factor) / resultInteres;
    } else {
      return capital * (1 - 1 / factor) / resultInteres;
    }
  }

  double calcularValorFuturo(double capital, double tasaInteres,
      DateTime tiempo, String selectedType) {
    double yearsDifference = _calculateTimePeriod(tiempo);
    double resultInteres = tasaInteres / 100;
    double factor = pow(1 + resultInteres, yearsDifference).toDouble();
    if (selectedType == 'Anticipada') {
      double factor = pow(1 + resultInteres, -yearsDifference).toDouble();
      return capital * factor;
    } else if (selectedType == 'Diferida') {
      return capital * pow(factor, yearsDifference);
    } else if (selectedType == 'Vencida') {
      return capital *
          ((pow(1 + resultInteres, yearsDifference) - 1) / resultInteres);
    } else {
      double factor = pow(1 + resultInteres, -yearsDifference).toDouble();
      return capital * (1 - 1 / factor) / (resultInteres);
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      // Calcular el tiempo total antes de la fecha seleccionada
      double totalYears = _calculateTimePeriod(selectedDate!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Han transcurrido $totalYears años desde la fecha seleccionada.'),
        ),
      );
    }
  }

  double _calculateTimePeriod(DateTime selectedDate) {
    DateTime currentDate = DateTime.now();
    int daysDifference = currentDate.difference(selectedDate).inDays;
    double yearsDifference = daysDifference / 365;
    return yearsDifference;
  }

  void _showResult(String title, double result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text('Resultado: $result'),
        );
      },
    );
  }
}

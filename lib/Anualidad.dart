import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnualidadesForm extends StatefulWidget {
  @override
  _AnualidadesFormState createState() => _AnualidadesFormState();
}

class InputControl extends StatelessWidget {
  final String labelName;
  final String inputName;
  final Function handleInputChange;
  final String value;
  final String type;

  const InputControl({
    required this.labelName,
    required this.inputName,
    required this.handleInputChange,
    required this.value,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelName),
      onChanged: (value) => handleInputChange(inputName, double.parse(value)),
      initialValue: value,
      keyboardType:
          TextInputType.number, // or any other appropriate type based on 'type'
    );
  }
}

enum FrecuenciaPago {
  Anual,
  Mensual,
  Trimestral,
  Semestral,
}

enum TipoCalculo {
  ValorPresente,
  ValorFuturo,
  Monto,
  Capital,
}

class _AnualidadesFormState extends State<AnualidadesForm> {
  double capital = 0;
  double interes = 0;
  double tiempo = 0;
  FrecuenciaPago frecuenciaPago = FrecuenciaPago.Anual;

  double? resultVa;
  double? resultVf;
  double? resultMonto;
  double? resultCapital;
  String? error;
  TipoCalculo tipoCalculo = TipoCalculo.ValorPresente;

  void handleInputChange(String name, double value) {
    setState(() {
      switch (name) {
        case "capital":
          capital = value;
          break;
        case "interes":
          interes = value;
          break;
        case "tiempo":
          tiempo = value;
          break;
        case "frecuenciaPago":
          frecuenciaPago = FrecuenciaPago.values[value.toInt()];
          break;
      }
    });
  }

  double calcularAnualidadesVa(
      double capital, double interes, double tiempo, int frecuencia) {
    final double tasaInteresPorcentual = interes / 100;
    final double convertirTiempo = tiempo * frecuencia / 12;
    final double anualidades = capital /
        (((1 + tasaInteresPorcentual) *
                    math.pow(1 + tasaInteresPorcentual, convertirTiempo) -
                1) /
            tasaInteresPorcentual);
    return anualidades;
  }

  double calcularAnualidadesVf(
      double capital, double interes, double tiempo, int frecuencia) {
    final double tasaInteresPorcentual = interes / 100;
    final double convertirTiempo = tiempo * frecuencia / 12;
    final double valorFuturo = capital *
        (math.pow(1 + tasaInteresPorcentual, convertirTiempo) - 1) /
        tasaInteresPorcentual;
    return valorFuturo;
  }

  double calcularMontoAnualidad(
      double capital, double interes, double tiempo, int frecuencia) {
    final double tasaInteresPorcentual = interes / 100;
    final double convertirTiempo = tiempo * frecuencia / 12;
    final double factorAnualidad =
        (1 - math.pow(1 + tasaInteresPorcentual, -convertirTiempo)) /
            tasaInteresPorcentual;
    final double montoAnualidad = capital * factorAnualidad;
    return montoAnualidad;
  }

  double calcularCapital(double capital, double interes, double tiempo) {
    final double tasaInteresDecimal = interes / 100;
    final double capitalan = capital *
        ((1 - math.pow(1 + tasaInteresDecimal / 12, -tiempo)) /
            (tasaInteresDecimal / 12));
    return capitalan;
  }

  void onSubmit() {
    try {
      if (tipoCalculo == TipoCalculo.ValorPresente) {
        resultVa = calcularAnualidadesVa(
            capital, interes, tiempo, frecuenciaPago.index + 1);
      } else if (tipoCalculo == TipoCalculo.ValorFuturo) {
        resultVf = calcularAnualidadesVf(
            capital, interes, tiempo, frecuenciaPago.index + 1);
      } else if (tipoCalculo == TipoCalculo.Monto) {
        resultMonto = calcularMontoAnualidad(
            capital, interes, tiempo, frecuenciaPago.index + 1);
      } else if (tipoCalculo == TipoCalculo.Capital) {
        resultCapital = calcularCapital(capital, interes, tiempo);
      }
      error = null;
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  String truncateDecimal(double? value) {
    if (value == null) return "";
    return value.toStringAsFixed(2);
  }

  Widget getDescripcion(TipoCalculo tipo) {
    return Column(
      children: [
        Text(
          tipo == TipoCalculo.ValorPresente
              ? "El Valor Presente (VP) es el valor actual de una serie de flujos de efectivo futuros, descontados a una tasa de interés específica. Representa cuánto vale una cantidad de dinero en el presente, considerando su valor futuro y la tasa de descuento aplicada."
              : tipo == TipoCalculo.ValorFuturo
                  ? "El Valor Futuro (VF) es el valor que una inversión tendrá en el futuro, después de acumular intereses o rendimientos a lo largo del tiempo. Representa la cantidad total que se espera que una inversión crezca, incluyendo tanto el principal inicial como los intereses o rendimientos generados."
                  : tipo == TipoCalculo.Monto
                      ? "El Monto de la Anualidad es el valor total de todos los pagos realizados o recibidos en una serie de pagos periódicos iguales, conocidos como anualidades. Es la suma de todos los pagos, incluyendo tanto el capital inicial como los intereses generados durante el período de tiempo especificado."
                      : "El Capital Inicial es la cantidad de dinero que se invierte inicialmente para generar una renta o un flujo de efectivo futuro.",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 12.0,
              color: Color.fromARGB(
                  255, 7, 7, 7)), // Cambiar tamaño y color de la letra
        ),
        if (tipo == TipoCalculo.Monto)
          Text("La fórmula para calcular el monto es:"),
        if (tipo != TipoCalculo.Monto)
          Image.asset(
              "assets/${tipo.toString().split('.').last.toLowerCase()}.png",
              width: 200,
              height: 200),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 169, 236, 245), // Cambiar color de fondo
      appBar: AppBar(
        title: Text('Ingeniería Económica',
            style: TextStyle(
                fontSize:
                    20.0)), // Cambiar tamaño de la letra en el título del app bar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      setState(() => tipoCalculo = TipoCalculo.ValorPresente),
                  child: Text("Calcular VP"),
                ),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => tipoCalculo = TipoCalculo.ValorFuturo),
                  child: Text("Calcular VF"),
                ),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => tipoCalculo = TipoCalculo.Monto),
                  child: Text("Calcular Monto"),
                ),
                ElevatedButton(
                  onPressed: () =>
                      setState(() => tipoCalculo = TipoCalculo.Capital),
                  child: Text("Calcular Capital"),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: getDescripcion(tipoCalculo),
            ),
            Column(
              children: [
                InputControl(
                    labelName: "Capital",
                    inputName: "capital",
                    handleInputChange: handleInputChange,
                    value: capital.toString(),
                    type: ""),
                InputControl(
                    labelName: "Tasa de Interés (%)",
                    inputName: "interes",
                    handleInputChange: handleInputChange,
                    value: interes.toString(),
                    type: ""),
                InputControl(
                    labelName: "Periodos",
                    inputName: "tiempo",
                    handleInputChange: handleInputChange,
                    value: tiempo.toString(),
                    type: ""),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: "Frecuencia de Pago"),
                  value: frecuenciaPago,
                  onChanged: (value) =>
                      setState(() => frecuenciaPago = value as FrecuenciaPago),
                  items: FrecuenciaPago.values.map((frecuencia) {
                    return DropdownMenuItem(
                      value: frecuencia,
                      child: Text(frecuencia.toString().split(".").last),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: onSubmit,
                  child: Text("Calcular"),
                ),
                if (error != null)
                  Text(error!, style: TextStyle(color: Colors.red)),
                if (tipoCalculo == TipoCalculo.ValorPresente &&
                    resultVa != null)
                  Text(
                      "Valor Actual de las Anualidades: ${truncateDecimal(resultVa)}",
                      style: TextStyle(color: Color.fromARGB(255, 250, 6, 6))),
                if (tipoCalculo == TipoCalculo.ValorFuturo && resultVf != null)
                  Text(
                      "Valor Futuro de las Anualidades: ${truncateDecimal(resultVf)}",
                      style: TextStyle(color: Color.fromARGB(255, 252, 4, 4))),
                if (tipoCalculo == TipoCalculo.Monto && resultMonto != null)
                  Text(
                      "Monto de las Anualidades: ${truncateDecimal(resultMonto)}",
                      style: TextStyle(color: Color.fromARGB(255, 247, 6, 6))),
                if (tipoCalculo == TipoCalculo.Capital && resultCapital != null)
                  Text("Capital Inicial: ${truncateDecimal(resultCapital)}",
                      style: TextStyle(color: Color.fromARGB(255, 248, 6, 6))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

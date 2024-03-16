import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:core';

class CalcularMonto extends StatefulWidget {
  @override
  _CalcularMontoState createState() => _CalcularMontoState();
}

class _CalcularMontoState extends State<CalcularMonto> {
  TextEditingController _fechaInicialController = TextEditingController();
  TextEditingController _fechaFinalController = TextEditingController();
  int tiempo = 0;
  double interes = 0.0;
  double monto = 0.0;
  double vp = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Monto"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese la fecha inicial',
                  ),
                  controller: _fechaInicialController,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese la fecha final',
                  ),
                  controller: _fechaFinalController,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese el valor presente',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      vp = double.parse(value);
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Ingrese el interes',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      interes = double.parse(value);
                    });
                  },
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  calcularDiferencia();
                  setState(() {
                    monto = vp * (1 + interes / 100 * tiempo / 365);
                    monto = double.parse((monto).toStringAsFixed(2));
                  });

                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        // Contenido del BottomSheet
                        child: Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text('Monto final:$monto'),

                              // Agrega aquí los widgets que desees mostrar en el BottomSheet
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Text('Calcular'),
              ),

              // Agrega aquí los widgets que desees mostrar en el BottomSheet
            ],
          ),
        ),
      ),
    );
  }
 

  void calcularDiferencia() {
    String fechaInicialStr = _fechaInicialController.text;
    String fechaFinalStr = _fechaFinalController.text;

    DateTime fechaInicial = DateTime.parse(fechaInicialStr);
    DateTime fechaFinal = DateTime.parse(fechaFinalStr);

    setState(() {
      tiempo = fechaFinal.difference(fechaInicial).inDays;
    });
  }
}

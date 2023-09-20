import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class IMC {
  double peso;
  double altura;
  double valorIMC;

  IMC({required this.peso, required this.altura}) : valorIMC = 0.0;

  double calcularIMC() {
    return peso / (altura * altura);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  List<IMC> historicoIMC = [];

  void calcularEExibirIMC() {
    final peso = double.tryParse(pesoController.text);
    final altura = double.tryParse(alturaController.text);

    if (peso != null && altura != null && peso > 0 && altura > 0) {
      final imc = IMC(peso: peso, altura: altura);
      imc.valorIMC = imc.calcularIMC();

      setState(() {
        historicoIMC.add(imc);
        pesoController.clear();
        alturaController.clear();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('Peso e altura devem ser valores positivos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: pesoController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Peso (kg)'),
                  ),
                  TextField(
                    controller: alturaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Altura (m)'),
                  ),
                  ElevatedButton(
                    onPressed: calcularEExibirIMC,
                    child: Text('Calcular IMC'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: historicoIMC.length,
                itemBuilder: (context, index) {
                  final imc = historicoIMC[index];
                  return ListTile(
                    title: Text('Altura: ${imc.altura.toStringAsFixed(2)} m | Peso: ${imc.peso.toStringAsFixed(2)} kg'),
                    subtitle: Text('IMC: ${imc.valorIMC.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

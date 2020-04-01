import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController wheightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetFields() {
    wheightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculator() {
    setState(() {
      double wheight = double.parse(wheightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = wheight / (height * height);
      print(imc);
      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc > 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text("Calculadora de IMC", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Colors.orange,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(Icons.person_outline, size: 120, color: Colors.orange),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Digite seu peso (KG):",
                      labelStyle: TextStyle(color: Colors.orange),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 23),
                    controller: wheightController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Digite sua altura (CM):",
                        labelStyle: TextStyle(color: Colors.orange),
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 23),
                      controller: heightController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Insira sua Altura!";
                        }
                      }),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculator();
                          }
                        },
                        child: Text("Calcular",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                            )),
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )
                ],
              ),
            )));
  }
}

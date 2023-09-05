import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _storedNumber = "0.00";
  void _updateStoredNumber(String value) {
    setState(() {
      if (value == "C") {
        _storedNumber = "0.00";
      } else if (value == "Apagar") {
        if (_storedNumber.isNotEmpty) {
          _storedNumber = _storedNumber.substring(0, _storedNumber.length - 1);
        }
      } else {
        if (_storedNumber == "0.00") {
          _storedNumber = value;
        } else {
          _storedNumber += value;
        }
      }
    });
  }

  Widget _buildNumberButton(String label) {
    return ElevatedButton(
      onPressed: () {
        _updateStoredNumber(label);
      },
      child: Text(
        label,
        style: TextStyle(fontSize: 24),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(20),
        minimumSize: Size(80, 80),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Avaliação 1"),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.update,
                  color: Colors.white,
                ),
                onPressed: () {
                  // do something
                },
              )
            ],
          ),
          body: Column(children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Center(
                heightFactor: 2,
                child: Text('Valor',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                  padding: const EdgeInsets.only(
                    left: 30,
                    top: 5,
                    right: 30,
                    bottom: 0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
                          TextInputFormatter.withFunction(
                            (oldValue, newValue) => newValue.copyWith(
                              text: newValue.text.replaceAll('.', ','),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  padding: const EdgeInsets.only(
                    left: 60,
                    top: 15,
                    right: 30,
                    bottom: 0,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // background
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {},
                    child: const Text("Crédito"),
                  )),
              Container(
                  padding: const EdgeInsets.only(
                    left: 30,
                    top: 15,
                    right: 60,
                    bottom: 0,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // background
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {},
                    child: const Text("Débito"),
                  )),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'R\$ $_storedNumber',
                    style: TextStyle(fontSize: 24),
                  )),
            ]),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNumberButton("1"),
                        _buildNumberButton("2"),
                        _buildNumberButton("3"),
                        _buildNumberButton("-"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNumberButton("4"),
                        _buildNumberButton("5"),
                        _buildNumberButton("6"),
                        _buildNumberButton("_"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNumberButton("7"),
                        _buildNumberButton("8"),
                        _buildNumberButton("9"),
                        _buildNumberButton("x"),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNumberButton(","),
                        _buildNumberButton("0"),
                        _buildNumberButton("."),
                        _buildNumberButton("ok"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}

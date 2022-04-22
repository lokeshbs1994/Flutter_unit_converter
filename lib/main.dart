import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Converter(),
    );
  }
}

class Converter extends StatefulWidget {
  const Converter({Key? key}) : super(key: key);

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  late double userInput;
  String _startMeasure = "Choose a Unit";
  String _convertMeasures = "Choose a Unit";
  String resultMessage = ' ';

  final List<String> measures = [
    'Meters',
    'Kilometers',
    'Grams',
    'Kilograms (kg)',
    'Feet',
    'Miles',
    'Pounds (lbs)',
    'ounces',
    'Liter',
    'MilliLiter'
  ];

  final Map<String, int> measuresMap = {
    'Meters': 0,
    'Kilometers': 1,
    'Grams': 2,
    'Kilograms (kg)': 3,
    'Feet': 4,
    'Miles': 5,
    'Pounds (lbs)': 6,
    'ounces': 7,
    'Liter': 8,
    'MilliLiter': 9
  };

  dynamic formulas = {
    '0': [1, 0.001, 0, 0, 3.280, 0.0006213, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0, 6213, 0, 0],
    '2': [0, 0, 1, 0.001, 0, 0, 0.00220, 0.03, 0.001, 1],
    '3': [0, 0, 1000, 1, 0, 0, 2.2046, 35.274, 1, 1000],
    '4': [0.0348, 0.00030, 0, 0, 1, 0.000189],
    '5': [1609.34, 1.60934, 0, 05280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.4535, 0, 0, 1, 16, 0.45359, 453.59],
    '7': [0, 0, 28.3495, 0.02834, 0, 0, 0.0625, 1, 0.0295735, 29.5735],
    '8': [0, 0, 1000, 1, 0, 0, 2.2, 33.814, 1, 1000],
    '9': [0, 0, 1, 0.001, 0, 0, 0.0022, 0.033814, 0.001, 1]
  };

  void convert(double value, String from, String to) {
    int? nFrom = measuresMap[from];
    int? nTo = measuresMap[to];
    var multiplier = formulas[nFrom.toString()][nTo];
    var result = value * multiplier;

    if (result == 0) {
      resultMessage = 'Cannot Performed This Conversion';
    } else {
      resultMessage =
          '${userInput.toString()} $_startMeasure are ${result.toString()} $_convertMeasures';
    }
    setState(() {
      resultMessage = resultMessage;
    });
  }

  void initState() {
    userInput = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quantity Converter"),
        centerTitle: true,
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(children: <Widget>[
              Text("Enter a value",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: TextField(
                  onChanged: (text) {
                    var input = double.tryParse(text);
                    if (input != null) {
                      setState(() {
                        userInput = input;
                      });
                    }
                  },
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[300],
                      hintText: 'Enter Your Value',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'From',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      dropdownColor: Colors.black,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.amber),
                      hint: Center(
                        child: Text(_startMeasure,
                            style:
                                TextStyle(color: Colors.amber, fontSize: 20)),
                      ),
                      items: measures.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _startMeasure = value.toString();
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'To',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      dropdownColor: Colors.black,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.amber),
                      hint: Center(
                        child: Text(_convertMeasures,
                            style:
                                TextStyle(color: Colors.amber, fontSize: 20)),
                      ),
                      items: measures.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _convertMeasures = value.toString();
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FlatButton(
                onPressed: () {
                  if (_startMeasure.isEmpty ||
                      _convertMeasures.isEmpty ||
                      userInput == 0)
                    return;
                  else
                    convert(userInput, _startMeasure, _convertMeasures);
                },
                child: Container(
                  alignment: AlignmentDirectional.center,
                  width: 200,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'Convert',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 40,
                        color: Colors.amber),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text((resultMessage == null) ? "" : resultMessage,
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 30)),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

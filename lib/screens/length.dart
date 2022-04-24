import 'package:flutter/material.dart';

class Length extends StatefulWidget {
  const Length({Key? key}) : super(key: key);

  @override
  State<Length> createState() => _LengthState();
}

class _LengthState extends State<Length> {
  late double userInput;
  String _startMeasure = "Choose a Unit";
  String _convertMeasures = "Choose a Unit";
  String resultMessage = "Result";

  final List<String> measures = [
    'Meter',
    'Kilometer',
    'Centimeter',
    'Milimeter',
    'Micrometers',
    'Mile',
    'Foot',
    'Inch'
  ];

  final Map<String, int> measuresMap = {
    'Meter': 0,
    'Kilometer': 1,
    'Centimeter': 2,
    'Milimeter': 3,
    'Micrometers': 4,
    'Mile': 5,
    'Foot': 6,
    'Inch': 7
  };

  dynamic formulas = {
    '0': [1, 0.001, 100, 1000, 1000000, 0.000621371, 3.28084, 39.3701],
    '1': [1000, 1, 100000, 1000000, 1000000000, 0.621371, 3280.84, 39370.1],
    '2': [0.01, 0.00001, 1, 10, 10000, 0.0000062137, 0.0328084, 0.393701],
    '3': [0.001, 0.000001, 0.1, 1, 1000, 0.00000062137, 0.00328084, 0.0393701],
    '4': [
      0.000001,
      0.000000001,
      0.0001,
      0.001,
      1,
      0.00000000062137,
      0.0000032808,
      0.0000393701
    ],
    '5': [1609.34, 1.60934, 160934, 1609350, 1609350000, 1, 5280, 63360],
    '6': [0.3048, 0.0003048, 30.48, 304.8, 304800, 0.000189394, 1, 12],
    '7': [0.0254, 0.0000254, 2.54, 25.4, 25400, 0.0000157828, 0.0833333, 1]
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
              Text("Enter Length",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.w700)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: TextField(
                  textAlign: TextAlign.center,
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
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text((resultMessage == null) ? "" : resultMessage,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 25)),
                ),
              ),
              SizedBox(
                height: 95,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
                  Widget>[
                Container(
                  child: Card(
                    color: Colors.white,
                    elevation: 5.0,
                    child: Container(
                      height: 90,
                      width: 120,
                      child: Stack(
                        children: [
                          Center(
                            child: Image.asset('assets/Images/scale.png'),
                          ),
                          Container(
                              margin:
                                  EdgeInsets.only(left: 30, right: 20, top: 70),
                              child: Text('Length',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)))
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => {Navigator.pushNamed(context, '/temperature')},
                  child: Container(
                    child: Card(
                      color: Colors.white,
                      elevation: 5.0,
                      child: Container(
                        height: 90,
                        width: 120,
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset('assets/Images/hot.png'),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 70, left: 15),
                                child: Text('Temperature',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => {Navigator.pushNamed(context, '/volume')},
                  child: Container(
                    child: Card(
                      color: Colors.white,
                      elevation: 5.0,
                      child: Container(
                        height: 90,
                        width: 120,
                        child: Stack(
                          children: [
                            Center(
                              child: Image.asset('assets/Images/volumeBW.png'),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 70, left: 30),
                                child: Text('Volume',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 1,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

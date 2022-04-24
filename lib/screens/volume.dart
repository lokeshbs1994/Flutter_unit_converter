import 'package:flutter/material.dart';

class Volume extends StatefulWidget {
  const Volume({Key? key}) : super(key: key);

  @override
  State<Volume> createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {
  late double userInput;
  String _startMeasure = "Choose a Unit";
  String _convertMeasures = "Choose a Unit";
  String resultMessage = "Result";

  final List<String> measures = ['cubicmtrs', 'litres', 'galons'];

  final Map<String, int> measuresMap = {
    'cubicmtrs': 0,
    'litres': 1,
    'galons': 2
  };

  dynamic formulas = {
    '0': [1.0, 1000.0, 264.172],
    '1': [0.001, 1.0, 0.264172],
    '2': [0.00378, 3.78541, 1.0]
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
              Text("Enter Volume",
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      onTap: () => {Navigator.pushNamed(context, '/length')},
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
                                  child: Image.asset('assets/Images/scale.png'),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 30, right: 20, top: 70),
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
                    ),
                    InkWell(
                      onTap: () =>
                          {Navigator.pushNamed(context, '/temperature')},
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
                                child: Image.asset('assets/Images/volume.png'),
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

import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  //const EmiScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List _tenureTypes = ['Month(s)', 'Year(s)'];
  String _tenureType = "Year(s)";
  String _emiResult = "";

  final TextEditingController principalAmount = TextEditingController();
  final TextEditingController interestRate = TextEditingController();
  final TextEditingController _tenure = TextEditingController();

  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //       appBar: AppBar(
//          backgroundColor: Colors.deepPurple,
//          title: const Text("EMI Calculator"),
//        ),
        body: Center(
            child: Column(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: principalAmount,
              decoration:
                  const InputDecoration(labelText: "Enter Principal Amount"),
              keyboardType: TextInputType.number,
            )),
        Container(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: interestRate,
              decoration:
                  const InputDecoration(labelText: "Enter Rate of Interest"),
              keyboardType: TextInputType.number,
            )),
        Container(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: <Widget>[
                Flexible(
                    flex: 4,
                    fit: FlexFit.tight,
                    child: TextField(
                      controller: _tenure,
                      decoration:
                          const InputDecoration(labelText: "Enter Tenure"),
                      keyboardType: TextInputType.number,
                    )),
                Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(_tenureType,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Switch(
                          value: _switchValue,
                          onChanged: (bool value) {
                            // ignore: avoid_print
                            print(value);

                            if (value) {
                              _tenureType = _tenureTypes[1];
                            } else {
                              _tenureType = _tenureTypes[0];
                            }

                            setState(() {
                              _switchValue = value;
                            });
                          },
                        )
                      ],
                    ))
              ],
            )),
        Flexible(
            fit: FlexFit.loose,
            child: ElevatedButton(
              onPressed: calculation,
              child: const Text("Calculate"),
            )),
        emiResultWidget(_emiResult)
      ],
    )));
  }

  void calculation() {
    double A = 0.0;
    int P = int.parse(principalAmount.text);
    double r = double.parse(interestRate.text) / 12 / 100;
    int n = _tenureType == "Year(s)"
        ? int.parse(_tenure.text) * 12
        : int.parse(_tenure.text);
    A = (P * r * pow((1 + r), n) / (pow((1 + r), n) - 1));

    _emiResult = A.toStringAsFixed(2);

    setState(() {});
  }

  Widget emiResultWidget(emiResult) {
    bool canShow = false;
    String _emiResult = emiResult;

    if (_emiResult.length > 0) {
      canShow = true;
    }

    return Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: canShow
            ? Column(children: [
                const Text("Your monthly EMI is",
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Text(_emiResult,
                    style: const TextStyle(
                        fontSize: 48.0, fontWeight: FontWeight.bold)),
              ])
            : Container());
  }
}

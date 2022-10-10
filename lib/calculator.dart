// ignore_for_file: avoid_unnecessary_containers

import 'dart:math';

import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({
    Key? key,
  }) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  // int principalAmount = 0;

//  double interestRate = 0.0;

  // double tenure = 0;

  // double emiResult = 0.0;

  final List tenureTypes = ['Month(s)', 'Year(s)'];
  String tenureType = "Year(s)";
  String _emiResult = "";

  final TextEditingController principalAmount = TextEditingController();
  final TextEditingController interestRate = TextEditingController();
  final TextEditingController tenure = TextEditingController();

  bool _switchValue = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: principalAmount,
                decoration: const InputDecoration(
                    labelText: "Enter Principal Amount :"),
              )),
          Container(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: interestRate,
                decoration:
                    const InputDecoration(labelText: "Enter Interest Rate :"),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .65,
                child: TextField(
                  controller: tenure,
                  decoration: const InputDecoration(labelText: "Enter Tenure"),
                  keyboardType: TextInputType.number,
                ),
              ),
              Column(
                children: [
                  Text(tenureType),
                  Switch(
                    value: _switchValue,
                    onChanged: (bool value) {
                      // ignore: avoid_print
                      print(value);

                      if (value) {
                        tenureType = tenureTypes[1];
                      } else {
                        tenureType = tenureTypes[0];
                      }

                      setState(() {
                        _switchValue = value;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
          Container(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                  onPressed: calculation,
                  //               interestRate = interestRate / 12 / 100;
                  //             int n = tenureType == "Year(s)"
                  //                  ? int.parse(tenure.text) * 12
                  //                  : int.parse(tenure.text);
                  //              emiResult = ((principalAmount *
                  //                          interestRate *
                  //                          pow((1 + interestRate), n)) /
                  //                      (pow((1 + interestRate), n) - 1)) /
                  //                 12;
                  child: const Text("Calculate"))),
          emiResultWidget(_emiResult)
        ],
      ),
    );
  }

  void calculation() {
    double er = 0.0;
    int pa = int.parse(principalAmount.text);
    double ir = double.parse(interestRate.text) / 12 / 100;
    int t = tenureType == "Year(s)"
        ? int.parse(tenure.text) * 12
        : int.parse(tenure.text);
    er = (pa * ir * pow((1 + ir), t) / (pow((1 + ir), t) - 1));

    _emiResult = er.toStringAsFixed(2);

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

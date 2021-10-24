import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BillSplitter extends StatefulWidget {
  BillSplitter({Key? key}) : super(key: key);

  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPrecent = 0;
  int _personCounter = 1;
  double _billAmount = 0;
  final Color _purple = HexColor('#690BD6');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(20.5),
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                color: _purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.5)),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Totol Per Person',
                      style: TextStyle(
                          color: _purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0)),
                  Text(
                      "\$ ${calculateTotalPerPerson(_billAmount, _personCounter, _tipPrecent)}",
                      style: TextStyle(
                          color: _purple,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0))
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.blueGrey.shade100,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: <Widget>[
                  TextField(
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(color: _purple),
                      decoration:
                          InputDecoration(prefixIcon: Icon(Icons.attach_money)),
                      onChanged: (String value) {
                        try {
                          _billAmount = double.parse(value);
                        } catch (e) {
                          _billAmount = 0.0;
                        }
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Split',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.1)),
                              child: Center(
                                child: Text("-",
                                    style: TextStyle(
                                        color: _purple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                              ),
                            ),
                          ),
                          Text(
                            "$_personCounter",
                            style: TextStyle(
                                color: _purple,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCounter++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _purple.withOpacity(0.1)),
                              child: Center(
                                child: Text("+",
                                    style: TextStyle(
                                        color: _purple,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Tip",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text(
                            "\$ ${calculateTotalTip(_billAmount, _personCounter, _tipPrecent)}",
                            style: TextStyle(
                                color: _purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0)),
                      )
                    ],
                  ),
                  //Slider
                  Column(
                    children: <Widget>[
                      Text("$_tipPrecent%",
                          style: TextStyle(
                              color: _purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0))
                    ],
                  ),
                  Slider(
                      min: 0,
                      max: 100,
                      activeColor: _purple,
                      inactiveColor: Colors.grey,
                      divisions: 20,
                      value: _tipPrecent.toDouble(),
                      onChanged: (double value) {
                        setState(() {
                          _tipPrecent = value.round();
                        });
                      })
                ],
              ))
        ],
      ),
    ));
  }

  calculateTotalPerPerson(double BillAmount, int splitBy, tipPercentage) {
    var totalPerPerson =
        (calculateTotalTip(BillAmount, splitBy, tipPercentage) + BillAmount) /
            splitBy;

    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billamount, int splitBy, int tipPercentage) {
    double totalTip = 0.0;
    if (billamount > 0 ||
        billamount.toString().isNotEmpty ||
        // ignore: unnecessary_null_comparison
        billamount != null) {
      totalTip = (billamount * tipPercentage) / 100;
    }

    return totalTip;
  }
}

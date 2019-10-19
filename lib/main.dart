import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Simple Interest Cal",
    debugShowCheckedModeBanner: false,
    home: SIForm(),
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        accentColor: Colors.indigo),
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formKey = GlobalKey<FormState>();

  var _currencies = ['Rupees', 'Dollors', 'Pounds'];
  final _minimumPadding = 5.0;
  var _currentlySelectedItem = '';
  var displayResult = "";

  @override
  void initState() {
    super.initState();
    _currentlySelectedItem = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Interest Calculator"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
            padding: EdgeInsets.all(_minimumPadding * 2),
            child: ListView(
              children: <Widget>[
                getImage(),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      style: textStyle,
                      controller: principalController,
                      keyboardType: TextInputType.number,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please Enter principal amount!";
                        }
                      },
                      decoration: InputDecoration(
                          labelText: "Principal",
                          hintText: "Enter principle ex: 12000",
                          labelStyle: textStyle,
                          errorStyle: TextStyle(fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: TextFormField(
                      style: textStyle,
                      controller: roiController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please Enter Rate of Interest!";
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Rate of Interest",
                          hintText: "In percent",
                          labelStyle: textStyle,
                          errorStyle: TextStyle(fontSize: 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: _minimumPadding, top: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          style: textStyle,
                          controller: termController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please Enter Term!";
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Term",
                              hintText: "Time in years",
                              labelStyle: textStyle,
                              errorStyle: TextStyle(fontSize: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0))),
                        )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: textStyle,
                              ),
                            );
                          }).toList(),
                          value: _currentlySelectedItem,
                          onChanged: (String newValueSelected) {
                            _onDropDownItemSelected(newValueSelected);
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                              color: Colors.lightBlue,
                              child: Text(
                                'Calculate',
                                style: textStyle,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    this.displayResult =
                                        _calculateTotalReturns();
                                  }
                                });
                              }),
                        ),
                        Container(
                          width: _minimumPadding * 2,
                        ),
                        Expanded(
                          child: RaisedButton(
                              color: Colors.red,
                              child: Text(
                                'Reset',
                                style: textStyle,
                              ),
                              onPressed: () {
                                setState(() {
                                  _reset();
                                });
                              }),
                        )
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    displayResult,
                    style: textStyle,
                  ),
                )
              ],
            )),
      ),
    );
  }

  Widget getImage() {
    AssetImage assetImage = AssetImage('images/bank.png');
    Image image = Image(
      image: assetImage,
      width: 125.0,
      height: 125.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 10),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentlySelectedItem = newValueSelected;
    });
  }

  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double total = principal + (principal * roi * term) / 100;

    String result =
        "After $term Years, Your Investment will be worth $total $_currentlySelectedItem";
    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    termController.text = "";
    displayResult = "";
    _currentlySelectedItem = _currencies[0];
  }
}

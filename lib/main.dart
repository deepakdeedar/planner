import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calculator',
    home: SIform(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent
    ),
  ));
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SIformState();
  }
}

class SIformState extends State<SIform> {
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final double _minimumPadding = 5.0;
  var _currentItemSelected='Rupees';
  var displayResult='';
  var _formKey=GlobalKey<FormState>();

  TextEditingController principal=TextEditingController();
  TextEditingController rate=TextEditingController();
  TextEditingController term=TextEditingController();


  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child:Padding(
          padding: EdgeInsets.all(_minimumPadding*2),
        child: ListView(
          children: <Widget>[
            getImageAssest(),
            Padding(
              padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                child: TextFormField(
                  style: textStyle,
              keyboardType: TextInputType.number,
              controller: principal,
                  validator: (String value)
                  {
                    if(value.isEmpty) {
                      return "Please Enter Principal Amount";
                    }
                  },
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  color: Colors.yellowAccent
                ),
                  labelText: 'Principal',
                  hintText: 'Enter Principal e.g. 12000',
                  labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            )),
            Padding(
                padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                child: TextFormField(
                  style: textStyle,
                  controller: rate,
                  keyboardType: TextInputType.number,
                  validator: (String value)
                  {
                    if(value.isEmpty)
                      return "Please Enter Rate Of Interest";
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent
                    ),
                      labelText: 'Rate Of Interest',
                      hintText: 'In Percent',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                child: Row(
              children: <Widget>[
                Expanded(child: TextFormField(
                  style: textStyle,
                  controller: term,
                  keyboardType: TextInputType.number,
                  validator: (String value)
                  {
                    if(value.isEmpty)
                      return "Please Enter Time in Year(s)";
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.yellowAccent
                    ),
                      labelText: 'Term',
                      hintText: 'Time in years',
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                )),

                Container(width: _minimumPadding*5),

                Expanded(child: DropdownButton<String>(
                  items: _currencies.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: _currentItemSelected,
                  onChanged: (String newValue)
                  {
                    _onDropDown(newValue);
                  },

                ))
              ],
            )),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text("Calculate",textScaleFactor: 1.5,),
                      onPressed: (){
                        setState(() {
                          if(_formKey.currentState.validate()) {
                            this.displayResult = _calculateTotal();
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text("Reset",textScaleFactor: 1.5,),
                      onPressed: (){
                        setState(() {
                          reset();
                        });
                      },
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(_minimumPadding*2),
              child: Text(this.displayResult,style: textStyle,),
            )

          ],
        )),
      ),
    );
  }

  Widget getImageAssest() {
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

  void _onDropDown(String newValue)
  {
    setState(() {
      this._currentItemSelected=newValue;
    });
  }

  String  _calculateTotal()
  {
    double prin= double.parse(principal.text);
    double roi=double.parse(rate.text);
    double t=double.parse(term.text);

    double total=prin+(prin*roi*t)/100;

    String result='After $t years, your investment will be worth $total $_currentItemSelected';
    return result;
  }

  void reset()
  {
    principal.text='';
    rate.text='';
    term.text='';
    displayResult='';
    _currentItemSelected=_currencies[0];
  }
}

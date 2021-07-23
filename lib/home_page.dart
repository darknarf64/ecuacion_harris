import 'package:ecuacion_harris/page_background.dart';
import 'package:ecuacion_harris/text_resultados.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  //variables de uso
  String _peso = '';
  String _talla = '';
  String _edad = '';
  int _genero = 1;
  String _factorActividad = '';

//variables de resultados
  double _imc = 0.0;
  double tmbDB = 0.0;
  double reqTotal = 0.0;

  bool _visibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text('Calcular energía y nutrientes')),
        body: Stack(
          children: [
            PageBackground(
              colorprimario: Colors.greenAccent,
              colorsecunadrio: Colors.green,
            ),
            _crearListado(context)
          ],
        ));
  }

  Widget _crearListado(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          Text(
              'Ecuación de Harris-Benedict revisadas por Mifflin y St Jeor en 1990'),
          Divider(),
          _crearInputPeso(),
          Divider(),
          _crearInputTalla(),
          Divider(),
          _crearInputEdad(),
          Divider(),
          _crearRadioListTileSexo(),
          Divider(),
          _crearInputFA(),
          Divider(),
          _botonCalcular(),
          Divider(),
          _listadeResultados()
        ],
      ),
    );
  }

  //crea el input del peso
  Widget _crearInputPeso() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: 'Peso en Kg',
          labelText: 'Peso',
          helperText: '$_peso kg',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_balance),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onChanged: (valor) {
        setState(() {
          _peso = valor;
        });
      },
    );
  }

//crea el input de la talla
  Widget _crearInputTalla() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: 'Talla en cm',
          labelText: 'Talla',
          helperText: '$_talla cm',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_balance),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onChanged: (valor) {
        setState(() {
          _talla = valor;
        });
      },
    );
  }

  //crea el input del edad
  Widget _crearInputEdad() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: 'Edad en años',
          labelText: 'Edad',
          helperText: '$_edad',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_balance),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onChanged: (valor) {
        setState(() {
          _edad = valor;
        });
      },
    );
  }

  Widget _botonCalcular() {
    return ElevatedButton(
        child: Text('Calcular'),
        onPressed: _revisarLlenadocompleto()
            ? null
            : () {
                _imc = _calcularIMC(_peso, _talla);
                tmbDB = _calcularReqEner(_peso, _talla, _edad, _genero);
                reqTotal = _calcularRET(tmbDB, _factorActividad);
                setState(() {
                  _visibility = true;
                });
                FocusScope.of(context).requestFocus(new FocusNode());
              });
  }

  bool _revisarLlenadocompleto() {
    if (_peso.isEmpty ||
        _talla.isEmpty ||
        _edad.isEmpty ||
        _factorActividad.isEmpty ||
        double.tryParse(_peso) == null ||
        double.tryParse(_talla) == null ||
        double.tryParse(_edad) == null ||
        double.tryParse(_factorActividad) == null) {
      return true;
    } else {
      return false;
    }
  }

  //crea la lista de resultados
  Visibility _listadeResultados() {
    return Visibility(
      visible: _visibility,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue, width: 3)),
        child: Column(
          children: [
            TextoResultados(
              title: Text(_imc.toString()),
              subtitle: Text('IMC'),
              icon: Icon(Icons.check),
            ),
            TextoResultados(
              title: Text(tmbDB.toString()),
              subtitle: Text('Taza metabólica Basal'),
              icon: Icon(Icons.check),
            ),
            TextoResultados(
              title: Text(reqTotal.toString()),
              subtitle: Text('Requerimiento energético total'),
              icon: Icon(Icons.check),
            ),
            SizedBox(
              height: 5.0,
            ),
            _crearBotonMacro(context)
          ],
        ),
      ),
    );
  }

  //crea el input de la talla
  Widget _crearInputFA() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: '1.375',
          labelText: 'Factor de actividad',
          helperText: '$_factorActividad cm',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_balance),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onChanged: (valor) {
        setState(() {
          _factorActividad = valor;
        });
      },
    );
  }

  //crea los botones de sexo
  Widget _crearRadioListTileSexo() {
    return Container(
      child: Column(
        children: <Widget>[
          RadioListTile(
              value: 1,
              groupValue: _genero,
              title: Text('Masculino'),
              onChanged: (value) {
                setState(() {
                  _genero = value as int;
                });
              }),
          RadioListTile(
              value: 2,
              groupValue: _genero,
              title: Text('Femenino'),
              onChanged: (value) {
                setState(() {
                  _genero = value as int;
                });
              })
        ],
      ),
    );
  }

  //calcular el IMC

  double _calcularIMC(String pesoST, String tallaST) {
    double peso = double.parse(pesoST);
    double talla = double.parse(tallaST);
    talla = talla / 100;
    double tallaCuadrado = talla * talla;
    double imc = peso / tallaCuadrado;
    imc = imc * 10;
    imc = (imc.roundToDouble()) / 10;
    return imc;
  }

  double _calcularReqEner(
      String pesoST, String tallaST, String edadST, int sexo) {
    //Hombres	TMB = (10 x peso en kg) + (6,25 × altura en cm) - (5 × edad en años) + 5
    //Mujeres	TMB = (10 x peso en kg) + (6,25 × altura en cm) - (5 × edad en años) - 161
    int _sexo = sexo;
    double peso = double.parse(pesoST);
    double talla = double.parse(tallaST);
    double edad = double.parse(edadST);
    double _tmb;

    switch (_sexo) {
      case 1:
        {
          _tmb = (10 * peso) + (6.25 * talla) - (5 * edad) + 5;
        }
        break;
      case 2:
        {
          _tmb = (10 * peso) + (6.25 * talla) - (5 * edad) - 161;
        }
        break;

      default:
        _tmb = 0.0;
    }

    _tmb = _tmb.roundToDouble();

    return _tmb;
  }

  double _calcularRET(double tmbDB, String factorActividad) {
    double ret;
    ret = tmbDB * double.parse(factorActividad);
    ret = ret.roundToDouble();
    return ret;
  }

  Widget _crearBotonMacro(BuildContext context) {
    return ElevatedButton(
      child: Text('Calcular Macronutrientes'),
      onPressed: _revisarLlenadocompleto()
          ? null
          : () {
              Navigator.pushNamed(context, 'macronutrientes',
                  arguments: <String, dynamic>{'tmb': reqTotal, 'peso': _peso});
            },
    );
  }
}

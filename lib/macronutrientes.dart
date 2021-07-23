import 'package:ecuacion_harris/page_background.dart';
import 'package:ecuacion_harris/text_resultados.dart';
import 'package:flutter/material.dart';

class Macronutrientes extends StatefulWidget {
  @override
  _MacronutrientesState createState() => _MacronutrientesState();
}

class _MacronutrientesState extends State<Macronutrientes> {
  late String _peso;
  late double _ret;
  String _grasaPORTXT = '30.0';
  bool _visibility = false;
  String _prot = '0.85';

//resultados
  double protgramos = 0.0;
  double protPorcient = 0.0;
  double chogramos = 0.0;
  double choPorciento = 0.0;
  double grasaGramos = 0.0;

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    _peso = arguments['peso'];
    _ret = arguments['tmb'];

    return Scaffold(
        appBar: AppBar(
          title: Text('Macronutrientes'),
          backgroundColor: Colors.green[400],
        ),
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
          Text('Calcular Macronutrientes'),
          Divider(),
          _crearInputProt(),
          Divider(),
          _crearInputGrasaPorciento(),
          Divider(),
          _crearBotonCalcular(),
          Divider(),
          _listadeResultados()
        ],
      ),
    );
  }

  Widget _crearInputProt() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: 'Kg de proteína por Kg de peso',
          labelText: '0.85g Prot/kg/día',
          helperText: '$_prot',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_balance),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onChanged: (valor) {
        setState(() {
          _prot = valor;
        });
      },
    );
  }

  Widget _crearInputGrasaPorciento() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: '% de grasa a usar',
          labelText: '30% de grasas del VCT',
          helperText: '$_grasaPORTXT',
          suffixIcon: Icon(Icons.accessibility),
          icon: Icon(Icons.account_balance),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
      onChanged: (valor) {
        setState(() {
          _grasaPORTXT = valor;
        });
      },
    );
  }

  _crearBotonCalcular() {
    return ElevatedButton(
        child: Text('Calcular'),
        onPressed: _revisarLlenadocompleto()
            ? null
            : () {
                _accionesCalcular();
                setState(() {
                  _visibility = true;
                });
                FocusScope.of(context).requestFocus(new FocusNode());
              });
  }

  bool _revisarLlenadocompleto() {
    if (_prot.isEmpty ||
        _grasaPORTXT.isEmpty ||
        double.tryParse(_prot) == null ||
        double.tryParse(_grasaPORTXT) == null) {
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
              title: Text(protgramos.toString()),
              subtitle: Text('Gramos de proteína'),
              icon: Icon(Icons.check),
            ),
            TextoResultados(
              title: Text(protPorcient.toString()),
              subtitle: Text('% proteína del VCT'),
              icon: Icon(Icons.check),
            ),
            TextoResultados(
              title: Text(chogramos.toString()),
              subtitle: Text('Gramos de Carbohidratos'),
              icon: Icon(Icons.check),
            ),
            TextoResultados(
              title: Text(choPorciento.toString()),
              subtitle: Text('% Carbohidratos del VCT'),
              icon: Icon(Icons.check),
            ),
            TextoResultados(
              title: Text(grasaGramos.toString()),
              subtitle: Text('Gramos de grasa'),
              icon: Icon(Icons.check),
            ),
            TextoResultados(
              title: Text(_grasaPORTXT),
              subtitle: Text('% Grasas del VCT'),
              icon: Icon(Icons.check),
            ),
          ],
        ),
      ),
    );
  }

  void _accionesCalcular() {
    protgramos = double.parse(_peso) * double.parse(_prot);
    protgramos = redondear1(protgramos);
    protPorcient = porciento((protgramos * 4), _ret);
    grasaGramos = (double.parse(_grasaPORTXT) / 100.0) * _ret;
    grasaGramos = grasaGramos / 9;
    grasaGramos = redondear1(grasaGramos);
    choPorciento = 100 - double.parse(_grasaPORTXT) - protPorcient;
    chogramos = (choPorciento / 100) * _ret;
    chogramos = chogramos / 4;
    chogramos = redondear1(chogramos);
  }

  double redondear1(double numero) {
    numero = numero * 10;
    numero = (numero.roundToDouble()) / 10;
    return numero;
  }

  double porciento(double numerador, double denominador) {
    double resultado = numerador / denominador;
    resultado = resultado * 100;
    resultado = redondear1(resultado);
    return resultado;
  }
}

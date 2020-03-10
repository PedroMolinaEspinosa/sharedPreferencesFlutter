import 'package:flutter/material.dart';
import 'package:preferenciasusuarioapp/src/share_prefs/preferencias_usuario.dart';
import 'package:preferenciasusuarioapp/src/widgets/menu_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  static final String routeName = "settings";

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _colorSecundario = true;
  int _genero;
  String _nombre;
  TextEditingController _textController;
  final prefs = new PreferenciasUsuario();
  @override
  void initState() {
    super.initState();
    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;

    _textController = new TextEditingController(text: prefs.nombre);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
          title: Text("Preferencias"),
        ),
        drawer: MenuWidget(),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'Preferencias',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(),
            SwitchListTile(
              value: _colorSecundario,
              title: Text('Color de la interfaz'),
              onChanged: (value) {
                setState(() {
                  _colorSecundario = value;
                  prefs.colorSecundario = value;
                });
              },
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Elige tu género (si puedes)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            RadioListTile(
              value: 1,
              groupValue: _genero,
              title: Text("Masculino"),
              onChanged: _setSelectedRadio,
            ),
            RadioListTile(
              value: 2,
              groupValue: _genero,
              title: Text("Femenino"),
              onChanged: _setSelectedRadio,
            ),
            RadioListTile(
              value: 3,
              groupValue: _genero,
              title: Text(
                  "Personas con notable retraso madurativo que pretenden cambiar el lenguaje del resto del mundo para que ellas no se sientan ofendidas"),
              onChanged: _setSelectedRadio,
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(20),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  helperText: 'Nombre del usuario',
                ),
                onChanged: (value) {
                  prefs.nombre = value;
                },
              ),
            )
          ],
        ));
  }

  _setSelectedRadio(int valor) async {
    prefs.genero = valor;
    _genero = valor;
    setState(() {});
  }
}

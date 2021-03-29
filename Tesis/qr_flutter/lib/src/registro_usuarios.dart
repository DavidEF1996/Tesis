import 'package:flutter/material.dart';
import 'package:qr_flutter/preferences/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/utils/generate_user.dart';
import 'package:qr_flutter/utils/utils.dart';

import 'package:qr_flutter/validations/popupRegistroUsuarios.dart';
import 'package:qr_flutter/src/login.dart';
import 'package:qr_flutter/validations/validacionesRegistro.dart';

import 'package:qr_flutter/model/doctor.dart';

class insertar_usuarios extends StatefulWidget {
  @override
  insertar createState() => insertar();
}

class insertar extends State<insertar_usuarios> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController cedula = new TextEditingController();
  TextEditingController nombres = new TextEditingController();
  TextEditingController apellidos = new TextEditingController();
  TextEditingController idDoctor = new TextEditingController();
  TextEditingController especialidad = new TextEditingController();

  Validaciones val = Validaciones();
  popupRegistroUsuario popRegUsuario = popupRegistroUsuario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Registrar Usuario'),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(10.0),
            child: new Form(
              key: keyForm,
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        formItemsDesign(
            Icons.person_add_alt,
            TextFormField(
              controller: cedula,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Cédula',
              ),
              maxLength: 10,
              validator: (value) {
                bool recibir = val.validarCedula(value);
                if (recibir == true) {
                  return null;
                } else {
                  return "Cédula no válida";
                }
              },
            )),
        formItemsDesign(
            Icons.sort_outlined,
            TextFormField(
              controller: nombres,
              decoration: new InputDecoration(
                labelText: 'Nombres',
              ),
              validator: val.validateName,
            )),
        formItemsDesign(
            Icons.sort_outlined,
            TextFormField(
              controller: apellidos,
              decoration: new InputDecoration(
                labelText: 'Apellidos',
              ),
              validator: val.validateName,
            )),
        formItemsDesign(
            Icons.drive_file_rename_outline,
            Column(children: <Widget>[
              new ListTile(
                title: const Text('Fecha de nacimiento'),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(currentDate.year.toString() +
                            "/" +
                            currentDate.month.toString() +
                            "/" +
                            currentDate.day.toString()),
                        IconButton(
                          onPressed: () => selectDate(context),
                          icon: Icon(Icons.date_range),
                          iconSize: 30,
                        ),
                      ],
                    )
                  ],
                ),
              ),

              // Text("Edad: "+ ),
            ])),
        formItemsDesign(
            Icons.medical_services_rounded,
            TextFormField(
              controller: idDoctor,
              decoration: new InputDecoration(
                labelText: 'ID Doctor',
              ),
              validator: val.validarCamposVacios,
            )),
        formItemsDesign(
            Icons.medical_services_rounded,
            TextFormField(
              controller: especialidad,
              decoration: new InputDecoration(
                labelText: 'Especialidad',
              ),
              validator: val.validateName,
            )),
        Container(
          child: Column(
            children: [
              Row(
                children: [],
              ),
              GestureDetector(
                  onTap: () {
                    save();
                  },
                  child: Container(
                    margin: new EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      gradient: LinearGradient(colors: [
                        Color(0xFF0EDED2),
                        Color(0xFF03A0FE),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: Text("Guardar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                  )),
              GestureDetector(
                  onTap: () {
                    final _preferences = new Preferences();
                    _preferences.id = "";
                    final route = MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    });
                    Navigator.pushReplacement(context, route);
                  },
                  child: Container(
                    margin: new EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      gradient: LinearGradient(colors: [
                        Color(0xFF0EDED2),
                        Color(0xFF03A0FE),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: Text("Cancelar",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500)),
                    padding: EdgeInsets.only(top: 16, bottom: 16),
                  ))
            ],
          ),
        )
      ],
    );
  }

  int age = 0;
  int months = 0;
  DateTime currentDate = DateTime.now();
  Future<String> selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1930),
        lastDate: DateTime(2100));

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
    return currentDate.toString();
  }

  calcularEdad(DateTime value) {
    DateTime currentDate = DateTime.now();
    //print("actual" + currentDate.year.toString());
    age = currentDate.year - value.year;
    int month1 = currentDate.month;
    int month2 = value.month;

    if (month2 > month1) {
      months = 12 - (month2 - month1);
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = value.day;
      if (day2 > day1) {
        age--;
      }
    }
  }

  save() {
    List<String> credenciales = generateUser(nombres.text, apellidos.text);
    Doctor d = Doctor();
    d.cedula = cedula.text;
    d.nombres = nombres.text;
    d.apellidos = apellidos.text;
    d.fechaNacimiento = currentDate;
    d.idDoctor = idDoctor.text;
    d.especialidad = especialidad.text;
    d.user = credenciales[0];
    print(credenciales[1]); //prueba
    d.password = encode(credenciales[1]);
    print(d.password); //prueba3

    if (keyForm.currentState.validate()) {
      popRegUsuario.menuConfirmacionDatos(d, context);
    } else {
      popRegUsuario.handleClickMe(context, 'Falta llenar algunos campos');
    }
  }
}

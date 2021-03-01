import 'package:flutter/material.dart';
import 'package:qr_flutter/src/homebotones.dart';
import 'package:qr_flutter/src/registro_cirujias.dart';
import 'package:qr_flutter/src/validacionesRegistro.dart';

class insertar_usuarios extends StatefulWidget {
  @override
  insertar createState() => insertar();
}

class insertar extends State<insertar_usuarios> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController cedula = new TextEditingController();
  TextEditingController nombres = new TextEditingController();
  TextEditingController apellidos = new TextEditingController();
  TextEditingController fechaNacimiento = new TextEditingController(); //----
  TextEditingController idDoctor = new TextEditingController();
  TextEditingController especialidad = new TextEditingController();

  Validaciones val = Validaciones();

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
            Icons.date_range_outlined,
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
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Años: " + age.toString()),
                                  Text("   "),
                                  Text("Meses:" + meses.toString()),
                                ],
                              )
                            ],
                          ),
                        )
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
            )),
        formItemsDesign(
            Icons.medical_services_rounded,
            TextFormField(
              controller: especialidad,
              decoration: new InputDecoration(
                labelText: 'Especialidad',
              ),
            )),
        /* formItemsDesign(
            Icons.person_pin,
            TextFormField(
              controller: user,
              decoration: new InputDecoration(
                labelText: 'Nombre de Usuario',
              ),
              // validator: validateName,
            )),
        formItemsDesign(
            Icons.mode_sharp,
            TextFormField(
              controller: password,
              decoration: new InputDecoration(
                labelText: 'Contraseña',
              ),
              //validator: validateName,
            )),
        formItemsDesign(
            Icons.mode_sharp,
            TextFormField(
              controller: repassword,
              decoration: new InputDecoration(
                labelText: 'Repetir contraseña',
              ),
              validator: (value) {
                return val.validatePassword(value, password.text);
              },
            )),*/
        GestureDetector(
            onTap: () {
              save();
            },
            child: Container(
              margin: new EdgeInsets.all(30.0),
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
            ))
      ],
    );
  }

  DateTime currentDate = DateTime.now();

  Future<String> selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2050));

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        print('llegue');
        print(calcularEdad(currentDate));
      });
    return currentDate.toString();
  }

  int age = 0;
  int meses = 0;
  calcularEdad(DateTime value) {
    DateTime currentDate = DateTime.now();
    print("actual" + currentDate.year.toString());
    age = currentDate.year - value.year;
    int month1 = currentDate.month;
    int month2 = value.month;

    if (month2 > month1) {
      meses = 12 - (month2 - month1);
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
    if (keyForm.currentState.validate()) {
      print("Cédula: " + cedula.text);
      print("Nombres:  " + nombres.text.toString());
      print("Apellidos: " + apellidos.text);
      String fecha = currentDate.year.toString() +
          "/" +
          currentDate.month.toString() +
          "/" +
          currentDate.day.toString();
      print("Fecha de nacimiento: " + fecha);
      print("Id Doctor: " + idDoctor.text);
      print("Especialidad: " + especialidad.text);

      keyForm.currentState.reset();
      final route = MaterialPageRoute(builder: (context) {
        return insertar_usuarios();
      });
      Navigator.push(context, route);
    }
  }
}

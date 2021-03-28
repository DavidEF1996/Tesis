import 'dart:core';
import 'package:flutter/material.dart';
import 'package:qr_flutter/model/registro_cirujias_modelo.dart';
import 'package:qr_flutter/src/homebotones.dart';
import 'package:qr_flutter/validations/popupRegistroCirujias.dart';
import 'package:qr_flutter/validations/usuarioLogueado.dart';
import 'package:qr_flutter/validations/validacionesRegistro.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:numberpicker/numberpicker.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController cirujano = new TextEditingController();
  TextEditingController ayudante = new TextEditingController();
  TextEditingController observaciones = new TextEditingController();
  TextEditingController equipoMaterial = new TextEditingController();
  TextEditingController fechaNacimiento = new TextEditingController(); //----
  TextEditingController procedimientoMedico = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController mobileCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  TextEditingController repeatPassCtrl = new TextEditingController();
  TextEditingController enfermedad = new TextEditingController();
  int _horas = 3;
  int _minutos = 10;
  String nombreEnfermedad = "";

  String tipoCirujia = 'cirujia';
  String grupoNecesidadSangre = 'necSangre';
  String grupoExamenesSangre = 'exaSangre';
  String grupoRadiografiasTorax = 'radTorax';
  String grupoExaECG = 'exaEcg';
  String grupoCuantitativosCovid = 'cuantitativos';

  Validaciones val = Validaciones();
  UsuarioLogueado usuariologueado = UsuarioLogueado();
  popupRegistroCirujias popRegCirugias = popupRegistroCirujias();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //return MaterialApp(
    //home: new Scaffold(
    return Scaffold(
      appBar: new AppBar(
        title: Container(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Text(
                "Bienvenido    ",
                style: TextStyle(fontSize: 17),
              ),
              usuariologueado.userloguin2(),
              usuariologueado.userloguin(),
              Text("  "),
              usuariologueado.botonSalir(context),
            ],
          ),
        ),
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
    );
    // );
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
        Container(
          child: Column(
            children: [
              new ListTile(title: const Text('Datos Paciente')),
            ],
          ),
        ),
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: new InputDecoration(
                labelText: 'Nombre del Paciente',
              ),
              validator: val.validateName,
            )),
        formItemsDesign(
            Icons.mode_outlined,
            Column(children: <Widget>[
              new ListTile(
                title: const Text('Fecha de nacimiento'),
              ),
              Container(
                child: Column(
                  children: [
                    Row(
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
                      ],
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Años: " + age.toString()),
                        Text("   "),
                        Text("Meses:" + meses.toString()),
                      ],
                    )
                  ],
                ),
              )

              // Text("Edad: "+ ),
            ])),
        Container(
          child: Column(
            children: [
              new ListTile(title: const Text('Tipo de Cirujía')),
            ],
          ),
        ),
        formItemsDesign(
            Icons.picture_in_picture_alt_outlined,
            Container(
              child: Column(
                children: [
                  Wrap(
                    children: [
                      crearRadio('emergencia', 'Emergencia'),
                      crearRadio('emergenciaDiferible', 'E. Diferible'),
                      crearRadio('electiva', 'Electiva'),
                      crearRadio('privada', 'Privada'),
                      crearRadio('rpis', 'RPIS'),
                    ],
                  ),
                ],
              ),
            )),
        formItemsDesign(
          Icons.dry_outlined,
          FindDropdown(
            items: ["Gripe", "Sida", "Covid 19", "Cáncer", "Diabetes"],
            label: "Seleccionar Enfermedad",
            onChanged: (item) {
              nombreEnfermedad = item;
              print(item);
            },
            selectedItem: "Enfermedad",
            validate: (item) {
              if (item == null)
                return "Falta seleccionar";
              else if (item == "Enfermedad")
                return "Campo no válido";
              else
                return null; //return null to "no error"
            },
          ),
        ),
        formItemsDesign(
            Icons.coronavirus,
            TextFormField(
              controller: procedimientoMedico,
              decoration: new InputDecoration(
                labelText: 'Procedimiento a Realizar: ',
              ),
              //keyboardType: TextInputType.,
              maxLength: 255,
            )),
        formItemsDesign(
          Icons.mode_outlined,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                new ListTile(
                  title: const Text('Fecha del Procedimiento: '),
                ),
                Row(
                  children: [
                    Text(fechaProcedimiento.year.toString() +
                        "/" +
                        fechaProcedimiento.month.toString() +
                        "/" +
                        fechaProcedimiento.day.toString()),
                    IconButton(
                      onPressed: () => selectDateProcess(context),
                      icon: Icon(Icons.date_range),
                    ),
                    /*Container(
                      child: Column(
                        children: [
                          TimePickerSpinner(
                              is24HourMode: true,
                              normalTextStyle:
                                  TextStyle(fontSize: 12, color: Colors.black),
                              highlightedTextStyle:
                                  TextStyle(fontSize: 14, color: Colors.black),
                              spacing: 2,
                              itemHeight: 20,
                              isForce2Digits: true,
                              onTimeChange: (time) {
                                setState(() {
                                  DateTime _dateTime = DateTime.now();
                                  _dateTime = time;
                                  print("las horas son:" + time.toString());
                                });
                              })
                        ],
                      ),
                    ),*/
                  ],
                ),
                Row(
                  children: [
                    Text('Horas:'),
                    Container(
                      width: 35,
                      child: Column(
                        children: [
                          NumberPicker(
                            itemHeight: 25,
                            value: _horas,
                            minValue: 0,
                            maxValue: 60,
                            textStyle:
                                TextStyle(fontSize: 15, color: Colors.black),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            onChanged: (value) =>
                                setState(() => _horas = value),
                          ),
                        ],
                      ),
                    ),
                    Text('    Minutos:'),
                    Container(
                      width: 35,
                      child: Column(
                        children: [
                          NumberPicker(
                            itemHeight: 25,
                            value: _minutos,
                            minValue: 0,
                            maxValue: 60,
                            textStyle:
                                TextStyle(fontSize: 15, color: Colors.black),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            onChanged: (value) =>
                                setState(() => _minutos = value),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        formItemsDesign(
            Icons.picture_in_picture_alt_outlined,
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Necesidad de Sangre:    ",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      necesidadSangre('si', 'SI'),
                      necesidadSangre('no', 'NO'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Exámenes de Sangre:     ",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      examenesSangre('si', 'SI'),
                      examenesSangre('no', 'NO'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Radiografías de Torax:  ",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      radiografiasTorax('si', 'SI'),
                      radiografiasTorax('no', 'NO'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ECG:                                  ",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      examenEcg('si', 'SI'),
                      examenEcg('no', 'NO'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cuantitativos COVID-19: ",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      cuantitativosCovid('si', 'SI'),
                      cuantitativosCovid('no', 'NO'),
                    ],
                  ),
                ],
              ),
            )),
        formItemsDesign(
            Icons.mode_outlined,
            TextFormField(
              controller: cirujano,
              decoration: new InputDecoration(
                labelText: 'Cirujano',
              ),
              validator: val.validateName,
            )),
        formItemsDesign(
            Icons.mode_outlined,
            TextFormField(
              controller: ayudante,
              decoration: new InputDecoration(
                labelText: 'Ayudante',
              ),
              validator: val.validateName,
            )),
        formItemsDesign(
            Icons.mode_outlined,
            TextFormField(
              controller: equipoMaterial,
              decoration: new InputDecoration(
                labelText: 'Equipo o Material necesario',
              ),
            )),
        formItemsDesign(
            Icons.mode_outlined,
            TextFormField(
              controller: observaciones,
              decoration: new InputDecoration(
                labelText: 'Observaciones',
              ),
              validator: val.validateEmail,
            )),
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
              final route = MaterialPageRoute(builder: (context) {
                return Botones();
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
    );
  }

//Variables Globales -------------------------
  var eleccionRadioButton;
  var eleccionExamenesSangre;
  var eleccionNecesidadDeSangre;
  var eleccionRadiografiaTorax;
  var eleccionExaEcg;
  var eleccionCuantitativos;
// -------------------------------------------

//Mètodos
  Container crearRadio(String value, String text) {
    return Container(
      width: 145,
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: tipoCirujia,
            onChanged: (value) {
              setState(() {
                tipoCirujia = value;
                eleccionRadioButton = value;
              });
            },
          ),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }

  Container necesidadSangre(String value, String text) {
    return Container(
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: grupoNecesidadSangre,
            onChanged: (value) {
              setState(() {
                grupoNecesidadSangre = value;
                eleccionNecesidadDeSangre = value;
              });
            },
          ),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }

  Container examenesSangre(String value, String text) {
    return Container(
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: grupoExamenesSangre,
            onChanged: (value) {
              setState(() {
                grupoExamenesSangre = value;
                eleccionExamenesSangre = value;
              });
            },
          ),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }

  Container radiografiasTorax(String value, String text) {
    return Container(
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: grupoRadiografiasTorax,
            onChanged: (value) {
              setState(() {
                grupoRadiografiasTorax = value;

                eleccionRadiografiaTorax = value;
              });
            },
          ),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }

  Container examenEcg(String value, String text) {
    return Container(
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: grupoExaECG,
            onChanged: (value) {
              setState(() {
                grupoExaECG = value;

                eleccionExaEcg = value;
              });
            },
          ),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }

  Container cuantitativosCovid(String value, String text) {
    return Container(
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: grupoCuantitativosCovid,
            onChanged: (value) {
              setState(() {
                grupoCuantitativosCovid = value;

                eleccionCuantitativos = value;
              });
            },
          ),
          Text(
            text,
            style: TextStyle(fontSize: 14),
          )
        ],
      ),
    );
  }

  DateTime currentDate = DateTime.now();

  DateTime fechaProcedimiento = DateTime.now();

  int age = 0;
  int meses = 0;
  calcularEdad(DateTime value) {
    List<int> intArr = [1, 2, 3, 4, 5];
    print(intArr);
    DateTime currentDate = DateTime.now();
    print("actual" + currentDate.year.toString());
    age = currentDate.year - value.year;
    int month1 = currentDate.month;
    int month2 = value.month;

    if (month2 > month1) {
      print("mes de nacimiento mayor al actual");
      meses = 12 - (month2 - month1);
      age--;
    } else if (month2 < month1) {
      print("mes de nacimiento menor al actual");
      meses = month1 - month2;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = value.day;
      if (day2 > day1) {
        meses = 11;
        age--;
      } else if (day2 <= day1) {
        meses = 0;
      }
    }

    print('La edad es' + age.toString() + 'y los meses' + meses.toString());
    return age;
  }

  Future<void> selectDate(BuildContext context) async {
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
  }

  Future<void> selectDateProcess(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: fechaProcedimiento,
        firstDate: DateTime(2021),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        fechaProcedimiento = pickedDate;
      });
  }

  save() {
    if (keyForm.currentState.validate()) {
      /* print("----------------------------------------------------");
      print("Nombre ${nameCtrl.text}");
      print("Edad del paciente en años: " +
          age.toString() +
          "y meses: " +
          meses.toString());

      print("Tipo de cirujía:" + eleccionRadioButton);
      print("Enfermedad que tiene: " + nombreEnfermedad);
      print("Procedimiento a realizar: " + procedimientoMedico.text);
      print("Fecha del procedimiento:" +
          fechaProcedimiento.year.toString() +
          "/" +
          fechaProcedimiento.month.toString() +
          "/" +
          fechaProcedimiento.day.toString());
      print("Tiempo del procedimiento: " +
          "Horas: " +
          _horas.toString() +
          "Minutos: " +
          _minutos.toString());

      print("Necesita sangre:" + eleccionNecesidadDeSangre);
      print("Tiene examenes de sangre:" + eleccionExamenesSangre);
      print("Posee radiografias de torax: " + eleccionRadiografiaTorax);
      print("ECG: " + eleccionExaEcg);
      print("Cuantitativos covid: " + eleccionCuantitativos);

      print("nombre cirujano: ${cirujano.text}");
      print("nombre ayudante: ${ayudante.text}");
      print("equipo necesario: ${equipoMaterial.text}");
      print("observaciones: ${observaciones.text}");
      print("----------------------------------------------------");
      keyForm.currentState.reset();*/

      RegistroCirujias r = RegistroCirujias();
      r.nombres = nameCtrl.text;
      r.fechaNacimiento = currentDate;
      r.anos = age;
      r.meses = meses;
      r.tipoCirujia = tipoCirujia;
      r.enfermedad = nombreEnfermedad;
      r.procedimientoRealizar = procedimientoMedico.text;
      r.fechaProcedimiento = fechaProcedimiento;
      r.horasProcedimiento = _horas;
      r.minutosProcedimiento = _minutos;
      r.necesidadSangre = eleccionNecesidadDeSangre;
      r.examenesSangre = eleccionExamenesSangre;
      r.radiografiasTorax = eleccionRadiografiaTorax;
      r.ecg = eleccionExaEcg;
      r.cuantitativosCovid = eleccionCuantitativos;
      r.nombreCirujano = cirujano.text;
      r.nombreAyudante = ayudante.text;
      r.equipoMaterialNecesario = equipoMaterial.text;
      r.observaciones = observaciones.text;

      if (keyForm.currentState.validate()) {
        if (age > 0) {
          popRegCirugias.menuConfirmacionDatos(r, context);
        } else {
          popRegCirugias.handleClickMe(context, 'Falta llenar algunos campos');
        }
      }
    }
  }
}

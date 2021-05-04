import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/dao/diagnostico_dao.dart';
import 'package:qr_flutter/dao/doctor_dao.dart';
import 'package:qr_flutter/model/api_response.dart';
import 'package:qr_flutter/model/cirujiasPrincipal.dart';
import 'package:qr_flutter/model/diagnostico.dart';
import 'package:qr_flutter/model/modelo_doctor.dart';
import 'package:qr_flutter/src/homebotones.dart';
import 'package:qr_flutter/utils/responsive.dart';
import 'package:qr_flutter/validations/cabecera.dart';
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
  TextEditingController duracion = new TextEditingController();
  int _horasInicio = 3;
  int _minutosInicio = 10;
  final focus = FocusNode();
  int _horasFin = 3;
  int _minutosFin = 10;
  String codigoEnfermedad = "";

  String tipoCirujia = 'cirujia';
  String numeroQuirofano = '';
  String grupoNecesidadSangre = 'necSangre';
  String grupoExamenesSangre = 'exaSangre';
  String grupoRadiografiasTorax = 'radTorax';
  String grupoExaECG = 'exaEcg';
  String grupoCuantitativosCovid = 'cuantitativos';
  APIResponse<List<DoctorModelo>> _apiResponse;
  APIResponse<List<Diagnostico>> _apiResponseDgn;
  Validaciones val = Validaciones();
  UsuarioLogueado usuariologueado = UsuarioLogueado();
  popupRegistroCirujias popRegCirugias = popupRegistroCirujias();
  DoctorDao ddao = new DoctorDao();
  DiagnosticoDao dgndao = new DiagnosticoDao();
  String nombres_parametro;
  List<Doctore> doctores = [];
  DiagnosticoCp diagnosticoCp = new DiagnosticoCp();
  MainAxisAlignment portr;

  @override
  void initState() {
    //cargarDoctores("a");
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    nombres_parametro = "a";
  }

  cargarDoctores(String nombres) async {
    print("llega al m[etodo");
    _apiResponse = await ddao.listarDoctores(nombres);
    print("llega aca");
    print(_apiResponse.toString());
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    //return MaterialApp(
    //home: new Scaffold(
    if (data.orientation == Orientation.portrait) {
      portr = MainAxisAlignment.spaceEvenly;
    } else {
      portr = MainAxisAlignment.center;
    }
    return Scaffold(
      appBar: new AppBar(
        title: Container(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: portr,
              children: [
                Cabecera(),
                SizedBox(width: 5),
                usuariologueado.botonSalir(context),
              ],
            ),
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
    final Responsive responsive = Responsive.of(context);
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
            Icons.picture_in_picture_alt_outlined,
            Container(
              child: Column(
                children: [
                  Wrap(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            elegirQuirofano('1', 'Uno'),
                            elegirQuirofano('2', 'Dos'),
                            elegirQuirofano('3', 'Tres'),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )),
        formItemsDesign(
            Icons.person,
            TextFormField(
              controller: nameCtrl,
              decoration: new InputDecoration(
                labelText: 'Nombre del Paciente',
              ),
              onFieldSubmitted: (v) {
                FocusScope.of(context).requestFocus(focus);
              },
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: FindDropdown(
                  label: "Escriba el código",
                  onFind: (String filter) async {
                    _apiResponseDgn = await dgndao.getDiagnosticos(filter);
                    List<String> datos = [];

                    int valor;
                    if (_apiResponseDgn.data == null) {
                      valor = 0;
                    } else {
                      valor = _apiResponseDgn.data.length;
                    }

                    for (var i = 0; i < valor; i++) {
                      String doctor;

                      doctor = utf8.decode(
                          latin1.encode(
                              _apiResponseDgn.data.elementAt(i).codigoCuatro +
                                  " " +
                                  _apiResponseDgn.data
                                      .elementAt(i)
                                      .nombreCuatroCaracteres),
                          allowMalformed: true);

                      datos.add(doctor);
                    }
                    return datos;
                  },
                  onChanged: (data) {
                    diagnosticoCp.nombreCuatroCaracteres = data.toString();
                    setState(() => enfermedad.text = data);
                  },
                ),
              ),
            )),
        formItemsDesign(
            Icons.coronavirus,
            TextFormField(
              focusNode: focus,
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
            width: responsive.diagonalPorcentaje(5),
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
                  ],
                ),
                Row(
                  children: [
                    Text('Hora de Inicio:'),
                    Container(
                      width: 35,
                      child: Column(
                        children: [
                          NumberPicker(
                            itemHeight: 25,
                            value: _horasInicio,
                            minValue: 1,
                            maxValue: 24,
                            textStyle:
                                TextStyle(fontSize: 15, color: Colors.black),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            onChanged: (value) =>
                                setState(() => _horasInicio = value),
                          ),
                        ],
                      ),
                    ),
                    Text(':'),
                    Container(
                      width: responsive.diagonalPorcentaje(5),
                      child: Column(
                        children: [
                          NumberPicker(
                            itemHeight: 25,
                            value: _minutosInicio,
                            minValue: 0,
                            maxValue: 60,
                            textStyle:
                                TextStyle(fontSize: 15, color: Colors.black),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            onChanged: (value) =>
                                setState(() => _minutosInicio = value),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: duracion,
                        decoration: new InputDecoration(
                          labelText: 'Duración',
                        ),
                      )
                    ],
                  ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Necesidad de Sangre:",
                        style: TextStyle(
                            fontSize: responsive.diagonalPorcentaje(1.6),
                            color: Colors.black),
                      ),
                      necesidadSangre('si', 'SI', responsive),
                      necesidadSangre('no', 'NO', responsive),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Exámenes de Sangre:",
                        style: TextStyle(
                            fontSize: responsive.diagonalPorcentaje(1.6),
                            color: Colors.black),
                      ),
                      examenesSangre('si', 'SI', responsive),
                      examenesSangre('no', 'NO', responsive),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Radiografías de Torax:",
                        style: TextStyle(
                            fontSize: responsive.diagonalPorcentaje(1.6),
                            color: Colors.black),
                      ),
                      radiografiasTorax('si', 'SI', responsive),
                      radiografiasTorax('no', 'NO', responsive),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ECG:                                ",
                        style: TextStyle(
                            fontSize: responsive.diagonalPorcentaje(1.6),
                            color: Colors.black),
                      ),
                      examenEcg('si', 'SI', responsive),
                      examenEcg('no', 'NO', responsive),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Cuantitativos COVID-19:",
                        style: TextStyle(
                            fontSize: responsive.diagonalPorcentaje(1.55),
                            color: Colors.black),
                      ),
                      cuantitativosCovid('si', 'SI', responsive),
                      cuantitativosCovid('no', 'NO', responsive),
                    ],
                  ),
                ],
              ),
            )),
        formItemsDesign(
          Icons.dry_outlined,
          FindDropdown(
            label: "Cirujano",
            onFind: (nombres_parametro) async {
              _apiResponse = await ddao.listarDoctores(nombres_parametro);
              List<String> datos = [];

              int valor;
              if (_apiResponse.data == null) {
                valor = 0;
              } else {
                valor = _apiResponse.data.length;
              }
              String cedula;
              for (var i = 0; i < valor; i++) {
                String doctor;
                doctor = utf8.decode(
                    latin1.encode(_apiResponse.data.elementAt(i).nombres +
                        " " +
                        _apiResponse.data.elementAt(i).apellidos),
                    allowMalformed: true);

                datos.add(doctor);
                cedula = _apiResponse.data.elementAt(i).cedula;
              }
              print(cedula);
              return datos;
            },
            onChanged: (item) {
              Doctore doctore = new Doctore();

              doctore.nombres = item;
              doctores.add(doctore);
              setState(() => cirujano.text = item);
            },
            selectedItem: "Cirujano",
            validate: (item) {
              if (item == null)
                return "Falta seleccionar";
              else if (item == "Cirujano")
                return "Campo no válido";
              else
                return null; //return null to "no error"
            },
          ),
        ),
        formItemsDesign(
          Icons.dry_outlined,
          FindDropdown(
            label: "Ayudante",
            onFind: (nombres_parametro) async {
              _apiResponse = await ddao.listarDoctores(nombres_parametro);
              List<String> datos = [];

              int valor;
              if (_apiResponse.data == null) {
                valor = 0;
              } else {
                valor = _apiResponse.data.length;
              }

              for (var i = 0; i < valor; i++) {
                String doctor;

                doctor = utf8.decode(
                    latin1.encode(_apiResponse.data.elementAt(i).nombres +
                        " " +
                        _apiResponse.data.elementAt(i).apellidos),
                    allowMalformed: true);

                datos.add(doctor);
              }
              return datos;
            },
            onChanged: (item) {
              Doctore doctore = new Doctore();

              doctore.nombres = item;
              doctores.add(doctore);
              setState(() => ayudante.text = item);
            },
            selectedItem: "Ayudante",
            validate: (item) {
              if (item == null)
                return "Falta seleccionar";
              else if (item == "Ayudante")
                return "Campo no válido";
              else
                return null; //return null to "no error"
            },
          ),
        ),
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
          ),
        ),
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
  String eleccionNumeroQuirofano;
  var eleccionExamenesSangre;
  var eleccionNecesidadDeSangre;
  var eleccionRadiografiaTorax;
  var eleccionExaEcg;
  var eleccionCuantitativos;
// -------------------------------------------
  Responsive responsive;
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

  Container elegirQuirofano(String value, String text) {
    return Container(
      width: 80,
      child: Row(
        children: [
          Radio(
            value: value,
            groupValue: numeroQuirofano,
            onChanged: (value) {
              setState(() {
                numeroQuirofano = value;
                eleccionNumeroQuirofano = value;
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

  Container necesidadSangre(String value, String text, Responsive responsive) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
            style: TextStyle(fontSize: responsive.diagonalPorcentaje(1.4)),
          )
        ],
      ),
    );
  }

  Container examenesSangre(String value, String text, Responsive responsive) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
            style: TextStyle(fontSize: responsive.diagonalPorcentaje(1.4)),
          )
        ],
      ),
    );
  }

  Container radiografiasTorax(
      String value, String text, Responsive responsive) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
            style: TextStyle(fontSize: responsive.diagonalPorcentaje(1.4)),
          )
        ],
      ),
    );
  }

  Container examenEcg(String value, String text, Responsive responsive) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
            style: TextStyle(fontSize: responsive.diagonalPorcentaje(1.4)),
          )
        ],
      ),
    );
  }

  Container cuantitativosCovid(
      String value, String text, Responsive responsive) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
            style: TextStyle(fontSize: responsive.diagonalPorcentaje(1.4)),
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
    DateTime currentDate = DateTime.now();
    age = currentDate.year - value.year;
    int month1 = currentDate.month;
    int month2 = value.month;
    if (month2 > month1) {
      age--;
      print("Mes de cumple mayor a mes actual");
      print(meses);
      int diaActual = currentDate.day;
      int diaCumpleanos = value.day;

      if (diaActual >= diaCumpleanos) {
        //meses = value.month - currentDate.month;
        meses = 12 - (value.month - currentDate.month);
      } else if (diaActual < diaCumpleanos) {
        //meses = (value.month - currentDate.month) - 1;
        meses = (12 - (value.month - currentDate.month) - 1);
      }
    } else if (month2 < month1) {
      print("Mes de cumple menor a mes actual");
      int diaActual = currentDate.day;
      int diaCumpleanos = value.day;
      if (diaActual >= diaCumpleanos) {
        //meses = value.month - currentDate.month;
        meses = currentDate.month - value.month;
      } else if (diaActual < diaCumpleanos) {
        //meses = (value.month - currentDate.month) - 1;
        meses = (currentDate.month - value.month) - 1;
      }
    } else if (month1 == month2) {
      print("meses iguales");
      int day1 = currentDate.day;
      int day2 = value.day;
      if (day2 >= day1) {
        meses = 11;
        age--;
      } else if (day2 < day1) {
        meses = 0;
      }
    }
    return age;
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1910),
        lastDate: DateTime(2100));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        print('llegue');
        print(calcularEdad(currentDate));
      });
  }

  DateTime fechAux = DateTime.now();
  Future<void> selectDateProcess(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: fechaProcedimiento,
        firstDate: DateTime(fechAux.year, fechAux.month, fechAux.day),
        lastDate: DateTime(fechAux.year, fechAux.month, fechAux.day + 8));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        fechaProcedimiento = pickedDate;
      });
  }

  save() {
    Cirujias r = Cirujias();
    r.quirofano = int.parse(eleccionNumeroQuirofano);
    r.paciente = nameCtrl.text;
    r.fechaNacimiento = currentDate.microsecondsSinceEpoch;
    r.anios = age;
    r.meses = meses;
    r.tipoCirujia = tipoCirujia;
    r.diagnostico = diagnosticoCp;
    r.procedimiento = procedimientoMedico.text;
    //var date = DateTime.fromMillisecondsSinceEpoch( * 1000);
    r.fechaCirujia = fechaProcedimiento.millisecondsSinceEpoch;

    r.horaInicio = _horasInicio.toString();
    var auxDuracion = int.parse(duracion.text);
    if (_minutosInicio != 0) {
      auxDuracion += 1;
    }

    r.duracion = auxDuracion.toString();
    _horasFin = _horasInicio + auxDuracion;
    r.horaFin = _horasFin.toString();

    r.necesidadSangre = eleccionNecesidadDeSangre;
    r.examenSangre = eleccionExamenesSangre;
    r.examenTorax = true;
    r.crjEcj = true;
    r.covid = true;
    r.doctores = doctores;
    r.observaciones = observaciones.text;
    r.materiales = equipoMaterial.text;
    r.edadPaciente = age;
    if (keyForm.currentState.validate()) {
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

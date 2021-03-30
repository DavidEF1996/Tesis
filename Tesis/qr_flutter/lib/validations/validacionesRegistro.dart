import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:crypto/crypto.dart';

class Validaciones {
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }

  //TextEditingController parametro = new TextEditingController();
  String validatePassword(String value, String parametro) {
    print("Repas" + value);
    print("Contra" + parametro);
    if (value != parametro) {
      print("Son diferentes");
      return "Las contraseñas no coinciden";
    } else {
      print("Son iguales");
      print("Repas" + value);
      print("Contra" + parametro);
      return null;
    }
  }

  String validateName(String value) {
    //String pattern = r"[ 0-9A-Za-zñÑáéíóúÁÉÍÓÚ¡!¿?@#$%()=+-€/.,]{1,50}";
    String pattern = r'(^[a-zA-Z-ñÑáéíóúÁÉÍÓÚ ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El campo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El campo debe contener solo letras";
    }
    return null;
  }

  String validarCamposVacios(String value) {
    if (value.length == 0) {
      return "El campo es necesario";
    }
    return null;
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "El telefono es necesariod";
    } else if (value.length != 10) {
      return "El numero debe tener 10 digitos";
    }
    return null;
  }

  bool validarCedula(String cedula) {
    int digito = -1;
    int suma = 0;
    int resta = -1;

    for (int i = 0; i < cedula.length; i++) {
      digito = cedula.codeUnitAt(i) - 48;
      if (i % 2 == 0) digito = (digito * 2) > 9 ? (digito * 2) - 9 : digito * 2;

      if (i < cedula.length - 1) suma += digito;
    }
    suma = suma % 10;
    resta = (digito == 0) ? suma : 10 - suma;
    return (resta == digito);
  }

  Future redireccionar(BuildContext context) async {
    Navigator.of(context).pushNamed('/Botones');
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}

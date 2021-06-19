import 'package:flutter/material.dart';
import 'package:qr_flutter/model/cirujiasPrincipal.dart';

import 'package:qr_flutter/model/modeloDatosCirujia.dart';
import 'package:qr_flutter/utils/CirujiasTarjeta.dart';

class ListNotices extends StatefulWidget {
  final List<Cirujias> dataCirujia;

  const ListNotices({Key key, this.dataCirujia}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ListNoticesState();
}

class ListNoticesState extends State<ListNotices> {
  List<Cirujias> noticias = [];

  @override
  void initState() {
    super.initState();
    noticias = (widget.dataCirujia == null) ? null : widget.dataCirujia;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: noticias.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: ObjectKey(noticias[index]),
              child: CardCirujias(noticias[index]),
              onDismissed: (direction) {
                setState(() {
                  noticias.remove(index);
                });
              },
            );
          }),
    );
  }
}

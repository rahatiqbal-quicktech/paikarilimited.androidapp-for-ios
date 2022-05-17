import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:androidapp/Fixed%20Variables/fixedvariables.dart';

import 'commonwidgets.dart';

class QuantityWidget extends StatefulWidget {
  String tempname;
  int tempprice;
  String tempimage;
  String temppid;
  QuantityWidget(
      {required this.tempname,
      required this.tempprice,
      required this.tempimage,
      required this.temppid});
  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  int _itemcount = 0;
  // Q abc = Q();
  // int? quantity = Q().q;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _itemcount != 0
            ? new IconButton(
                onPressed: () => setState(() {
                      // quantity = (quantity! - 1);
                      _itemcount--;
                    }),
                icon: new Icon(Ionicons.remove_circle_outline))
            : new Container(),
        whitespace(context, 0, 1),
        _itemcount != 0 ? Text(_itemcount.toString()) : Container(),
        IconButton(
            onPressed: () => setState(() {
                  // quantity = (quantity! + 1);
                  _itemcount++;
                }),
            icon: new Icon(
              Ionicons.add_circle_outline,
              color: redcolor,
            ))
      ],
    );
  }
}

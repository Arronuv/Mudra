import 'package:flutter/material.dart';
import '../helper.dart';
import '../theme.dart';
class DropDown extends StatelessWidget {
  const DropDown({
    Key? key,
    required this.appTheme,
    required this.helper,
    required this.value, required this.callback,
  }) : super(key: key);

  final AppTheme appTheme;
  final Helper helper;
  final value;
  final Function callback;
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        hint: Text('Currency',style: appTheme.fontWeightW100(20.0),),
        underline: Container(),
        dropdownColor: appTheme.foreground,
        style: appTheme.fontWeightW100(20.0),
        focusColor: appTheme.inactive,
        items: helper.dropItems,
        value: value,
        onChanged: (dynamic s){
          callback(s);
        });
  }
}
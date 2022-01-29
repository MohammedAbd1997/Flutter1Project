import 'package:flutter/material.dart';


class CustomTextfield extends StatelessWidget {
  String labelText;
  Function validationFun;
  TextEditingController controller;
  TextInputType textInputType;

  CustomTextfield(
      {this.labelText,
        this.validationFun,
        this.controller,
        this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        keyboardType: textInputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validationFun,
        decoration: InputDecoration(
            label: Text(labelText,style: TextStyle(color: Colors.white),),

            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}

class CustomTextfieldDec extends StatelessWidget {
  String labelText;
  Function validationFun;
  TextEditingController controller;
  TextInputType textInputType;

  CustomTextfieldDec(
      {this.labelText,
      this.validationFun,
      this.controller,
      this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          maxLines: 8,
          keyboardType: textInputType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: (value) => validationFun(value),
          decoration: InputDecoration(
            hintText: '$labelText',

          ),
        ));
  }
}
class CustomTextfieldTitle extends StatelessWidget {
  String labelText;
  Function validationFun;
  TextEditingController controller;
  TextInputType textInputType;

  CustomTextfieldTitle(
      {this.labelText,
        this.validationFun,
        this.controller,
        this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(
          maxLines: 4,
          keyboardType: textInputType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: (value) => validationFun(value),
          decoration: InputDecoration(
            hintText: '$labelText',

          ),
        ));
  }
}

class CustomTextfield3 extends StatelessWidget {
  String labelText;
  Function validationFun;
  TextEditingController controller;
  TextInputType textInputType;

  CustomTextfield3(
      {this.labelText,
        this.validationFun,
        this.controller,
        this.textInputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 200,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: TextFormField(

          keyboardType: textInputType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: (value) => validationFun(value),
          decoration: InputDecoration(
            label: Text(labelText),
          ),
        ));
  }
}

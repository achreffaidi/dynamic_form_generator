import 'package:dynamic_form_generator/Model/DartConstraint.dart';
import 'package:dynamic_form_generator/Model/GenericField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class DTextFieldNumber extends GenericField {

  TextEditingController _controller ;
  InputDecoration _inputDecoration ;
  DTextFieldNumber(Map<String,dynamic> map , {TextField textField}){

    initFromJson(map);
    initializationRoutine();
    if(textField!=null)
    initInputDecoration(textField.decoration);

    _controller = new TextEditingController();
     widget = new TextField(
       controller: _controller,
       decoration:  _inputDecoration,
     );
     _controller.addListener(() {
       value = _controller.text;
     });
  }



  @override
  bool checkJsConstraints() {
    // TODO: implement checkJsConstraints
    throw UnimplementedError();
  }

  @override
  dartConstraintsToJson() {
    // TODO: implement dartConstraintsToJson
    throw UnimplementedError();
  }

  @override
  Widget getPropertiesWidget() {
    // TODO: implement getPropertiesWidget
    throw UnimplementedError();
  }
  @override
   loadSupportedDartConstrains(){
     supportedConstraints.addAll({
       "SOE":(List<dynamic> args) => args[0] <= args[1] ,
     }
     ) ;
   }


  @override
  void initDefaultValue(value) {
    _controller.text = value;
  }

  @override
  void initFromJson(Map<String,dynamic> map) {
    super.initFromJson(map);
    //load contraines
  }

  @override
  void initPlaceHolder(value) {
        placeHolder = value ;
  }

  @override
  void loadJsConstraints() {
    // TODO: implement loadJsConstraints
  }

  @override
  propertiesToJson() {
    // TODO: implement propertiesToJson
    throw UnimplementedError();
  }

  @override
  Map<String,dynamic> saveToJson() {
   return super.saveToJson();
    }

  void initInputDecoration(InputDecoration inputDecoration) {
    _inputDecoration = inputDecoration.copyWith(hintText: placeHolder);
  }

  @override
  List getArgs(Constraint constraint) {
    List<dynamic> args = [];
    //TODO initialize arguments for each constraint !!
  }


}
import 'package:dynamic_form_generator/Model/DartConstraint.dart';
import 'package:dynamic_form_generator/Model/GenericField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';



class DTextField extends GenericField {
  TextField textField;
  Map<String,dynamic> map;
  DTextField(this.map , {this.textField});

  @override
  _DTextFieldState createState() => _DTextFieldState(map,textField: textField);
}

class _DTextFieldState extends GenericFieldState {
  @override
  Widget build(BuildContext context) {
    return getDefaultLayout(new TextField(
      controller: _controller,
      decoration:  new InputDecoration(
        errorText: _errorText,
        hintText: placeHolder
      ),
    ));
  }
  TextEditingController _controller ;
  String _errorText;
  InputDecoration _inputDecoration ;

  _DTextFieldState(Map<String,dynamic> map , {TextField textField}){
    initFromJson(map);
  }


 @override
  void initState() {
    super.initState();
    _controller = new TextEditingController();
    _controller.addListener(() {
      value = _controller.text;
      _errorText = checkDartConstraints();
      setState(() {
      });
    });
    initializationRoutine();
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
    _inputDecoration = inputDecoration.copyWith(hintText: placeHolder,errorText:_errorText,  );
  }

  @override
  List getArgs(Constraint constraint) {
    List<dynamic> args = [];
    if(constraint.name == "not_empty_string") args = [(value as String).trim().length,1];
    if(constraint.name == "one_word") args = [(value as String).trim().replaceAll(" ", "").length,(value as String).trim().length];
    return args;
    //TODO Switch instead of IF ELSE
  }

}

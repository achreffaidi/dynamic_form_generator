import 'package:dynamic_form_generator/Model/DartConstraint.dart';
import 'package:flutter/widgets.dart';

abstract class GenericField extends Widget{
  String id;
  Widget widget ;
  String title ;
  bool showDartConstraintAlerts;
  bool showJsConstraintAlerts;
  dynamic placeHolder ;
  dynamic value;

  bool translateTitle = false;
  bool translateError = false;
  bool checkConstraintsOnDataChange = false ;
  bool Function(String)  translate;

  List<Constraint> _constraints = new List<Constraint>();

  void initDefaultValue(dynamic value);
  void initPlaceHolder(dynamic value);

  void initializationRoutine(){
    loadSupportedDartConstrains();
    if(value!=null) initDefaultValue(value);
    if(placeHolder!=null) initPlaceHolder(placeHolder);
  }

  //Constraints
  void loadSupportedDartConstrains();
  void addConstraint(Map<String,dynamic> map){
    var name = map["name"];
    if(supportedConstraints.containsKey(name)){
      map["validate"] = supportedConstraints[name] ;
      _constraints.add(Constraint(map["name"], map["error"], map["validate"],map["arg"]));
    }

  } //params Constraint


  List<dynamic> getArgs(Constraint constraint);
  void loadJsConstraints(); //File Js

  bool checkDartConstraints(){
    for(Constraint constraint in _constraints){
      if(!constraint.validate(getArgs(constraint))) return false;
    }
    return true;
  }

  bool checkJsConstraints();

  dynamic dartConstraintsToJson();
  Map<String,Function> getSupportedConstraints ;

  // TO and FROM Json
  void initFromJson(Map<String,dynamic> map){
   id = map["id"];
   title = map.containsKey("title")? map["title"]:null;
   placeHolder = map.containsKey("placeHolder")? map["placeHolder"]:null;
   value = map.containsKey("value")? map["value"]:null;
  }

  Map<String,dynamic> saveToJson(){
    Map<String,dynamic> map = new Map();
    map["id"] = id ;
    map["value"] = value ;
    return map;
  }

  Widget getPropertiesWidget();
  dynamic propertiesToJson();

  @override
  Element createElement() {
    return widget.createElement();
  }


    Map<String,Function> supportedConstraints = {
    "BOE":(List<dynamic> args) => args[0] >= args[1] ,
  };
}
import 'package:dynamic_form_generator/Model/DartConstraint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


abstract class GenericField extends StatefulWidget {

}

abstract class GenericFieldState extends State<GenericField> {

  String id;
  Widget customWidget ;
  String title ;
  bool showDartConstraintAlerts;
  bool showJsConstraintAlerts;
  dynamic placeHolder ; //to remove
  dynamic value;

  bool translateTitle = false;
  bool translateError = false;
  bool checkConstraintsOnDataChange = false ;
  String Function(String)  translate;
  Function onUpdate;

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
    var function = map["function"];
    if(supportedConstraints.containsKey(function)){
      _constraints.add(Constraint(map["name"], map["error"], supportedConstraints[function]));
    }

  } //params Constraint

  void loadDartConstraintFromJson(Map<String,dynamic> map){
    if(map.containsKey("dart_constraints")){
      var constraints = map["dart_constraints"];
      for(var constraint in constraints){
        addConstraint(constraint);
      }
    }
  }
  List<dynamic> getArgs(Constraint constraint);
  void loadJsConstraints(); //File Js

  String checkDartConstraints(){
    for(Constraint constraint in _constraints){
      if(!constraint.validate(getArgs(constraint))) return constraint.error;
    }
    return null;
  }

  bool checkJsConstraints();

  dynamic dartConstraintsToJson();
  Map<String,Function> getSupportedConstraints ;

  // TO and FROM Json
  void initFromJson(Map<String,dynamic> map){
    id = map["id"];
    title = map.containsKey("title")? map["title"]:"";
    placeHolder = map.containsKey("placeHolder")? map["placeHolder"]:null;
    value = map.containsKey("value")? map["value"]:null;
    loadDartConstraintFromJson(map);
  }

  Map<String,dynamic> saveToJson(){
    Map<String,dynamic> map = new Map();
    map["id"] = id ;
    map["value"] = value ;
    return map;
  }

  Widget getPropertiesWidget();
  dynamic propertiesToJson();

  Map<String,Function> supportedConstraints = {
    "BOE":(List<dynamic> args) => args[0] >= args[1] as bool,
  };
  Widget getDefaultLayout(Widget widget){
    return Card(
      child: Container(padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Text(title,style: TextStyle(fontSize: 22),),
        widget,
      ],),),
    );
  }
}

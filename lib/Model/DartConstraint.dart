class Constraint{
  final String name;
  final String error;
  final bool Function([List<dynamic> args]) validate;
  final String arg;
  Constraint(this.name,this.error,this.validate,this.arg);
}



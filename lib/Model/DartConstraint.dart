class Constraint{
  final String name;
  final String error;
  final bool Function(List<dynamic> args) validate;
  Constraint(this.name,this.error,this.validate);
}



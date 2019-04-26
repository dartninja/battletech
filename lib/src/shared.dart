const String idField = "id";

abstract class AIDClass {
  final String id;
  const AIDClass(this.id);
}

String enumToString(dynamic input) {
  return input.toString().split(".")[1];
}
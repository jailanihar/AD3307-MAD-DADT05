import 'dart:io';

void main() {
  print('Hello World!');
  print('Type in your name:');
  String? name = stdin.readLineSync();
  print('Name you typed is ' + name!);
  print('Name you typed is $name');
  print('Name you typed is ${name.toUpperCase()}');
  bool test = false;
  print(!test);
}
import 'package:hetu_xx/hetu_xx.dart';

void main() {
  final hetu = Hetu();
  hetu.init();
  hetu.eval(r'''
    var i = 42
  ''');
  hetu.eval(r'''
    var j = 'hello, guest no.${i}, next guest is no.${i+1}!'
  ''');
  hetu.eval(r'''
    print(j)
  ''');
}

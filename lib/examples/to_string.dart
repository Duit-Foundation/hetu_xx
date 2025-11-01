import 'package:hetu_xx/hetu_xx.dart';

void main() {
  final hetu = Hetu();

  hetu.init();

  hetu.eval(r'''
    class Name {
      var firstName = 'Adam'
      var familyName = 'Christ'
      function toString {
        return '${firstName} ${familyName}'
      }
    }
    class Person {
      function greeting {
        return 6 * 7
      }
      var name = Name()
    }
    function main {
      var j = Person()
      j.name.familyName = 'Luke'
      print(j.name) // Will use overrided toString function in script class
    }
  ''', invoke: 'main');
}

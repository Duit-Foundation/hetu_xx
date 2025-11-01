import 'package:test/test.dart';
import 'package:hetu_xx/hetu_xx.dart';

void main() {
  final hetu = Hetu(
    config: HetuConfig(
      printPerformanceStatistics: false,
    ),
  );
  hetu.init();

  group('struct -', () {
    test('basics', () {
      final result = hetu.eval(r'''
        var foo = {
          value: 42,
          greeting: 'hi!'
        }
        foo.value = 'ha!'
        foo.world = 'everything'
        foo.toString()
      ''');
      expect(
        result,
        r'''{
  value: 'ha!',
  greeting: 'hi!',
  world: 'everything'
}''',
      );
    });
    test('fromJson', () {
      final jsonData = {
        "name": "Aleph",
        "type": "novel",
        "volumes": 7,
      };
      final result = hetu.eval(
          r'''
            function fromJsonTest(data) {
              final obj = Object.fromJSON(data)
              return obj.volumes
            }
          ''',
          invoke: 'fromJsonTest',
          positionalArgs: [jsonData]);
      expect(
        result,
        7,
      );
    });
    test('containsKey', () {
      final result = hetu.eval(r'''
        var ht = {
          name: 'Hetu',
          age: 1
        }
        ht.hasOwnProperty('toJSON') // false
      ''');
      expect(
        result,
        false,
      );
    });
    test('named', () {
      final result = hetu.eval(r'''
        struct Named {
          var name = 'Unity'
          var age = 17
        }
        final n = Named()
        n.age = 42
        Named.age
      ''');
      expect(
        result,
        17,
      );
    });

    test('named constructor', () {
      final result = hetu.eval(r'''
        struct DialogContentData {
          constructor ({
            localeKeys,
          }) {
            this.localeKeys = localeKeys
          }

          constructor fromData(data) : this(
            localeKeys: data.localeKeys,
          ) {}
        }

        final dlg = DialogContentData.fromData({
          localeKeys: ['a', 'b']
        })

        dlg.localeKeys
      ''');
      expect(result, ['a', 'b']);
    });

    test('assign & merge', () {
      final result = hetu.eval(r'''
        
        let a = {a: 1}
        let b = {a: 4, b: 4}
        let c = {a: 42, c: 5}

        Object.assign(a, b)
        a.a
      ''');
      expect(result, 4);
    });
  });
}

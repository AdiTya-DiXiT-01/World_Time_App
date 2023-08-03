import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:project_2/services/world_time.dart';

void main() {
  late WorldTime worldTime;

  setUp(() {
    worldTime = WorldTime(location: 'Test Location', flag: 'Test Flag', url: 'Test/Timezone');
  });

  group('WorldTime -', () {
    group('getTime function', () {
      test('given WorldTime class when getTime is called and status code is 200 then time should be returned', () async {
        String mockResponse = '{"datetime": "2023-08-03T12:34:56.789Z", "utc_offset": "+05:30"}';
        worldTime.client = MockClient((request) async {
          return http.Response(mockResponse, 200);
        });

        await worldTime.getTime();

        expect(worldTime.time, isNotNull);
        expect(worldTime.time, isNotEmpty);
      });

      test('given WorldTime class when getTime is called and status code is not 200 then "could not get time" should be returned', () async {
      
        worldTime.client = MockClient((request) async {
          return http.Response('Error', 404);
        });

        await worldTime.getTime();

        expect(worldTime.time, 'could not get time');
      });
    });
  });
}

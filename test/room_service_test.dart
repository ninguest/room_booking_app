// test/services/room_service_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:room_booking/services/room_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late RoomService roomService;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    roomService = RoomService();
  });

  group('RoomService Tests', () {
    final sampleResponse = '''
    [
      {
        "name": "Test Room",
        "capacity": "4",
        "level": "1",
        "availability": {
          "08:00": "1",
          "08:30": "0"
        }
      }
    ]
    ''';

    test('fetchRooms returns list of rooms on success', () async {
      when(mockHttpClient.get(any)).thenAnswer((_) async =>
          http.Response(sampleResponse, 200));

      final rooms = await roomService.fetchRooms();

      expect(rooms, isNotEmpty);
      expect(rooms.first.name, equals('Test Room'));
      expect(rooms.first.capacity, equals(4));
      expect(rooms.first.level, equals('1'));
      expect(rooms.first.availability['08:00'], equals('1'));
      expect(rooms.first.availability['08:30'], equals('0'));
    });

    test('fetchRooms throws exception on error response', () async {
      when(mockHttpClient.get(any)).thenAnswer((_) async =>
          http.Response('Error', 404));

      expect(
            () => roomService.fetchRooms(),
        throwsException,
      );
    });

    test('fetchRooms throws exception on network error', () async {
      when(mockHttpClient.get(any)).thenThrow(Exception('Network error'));

      expect(
            () => roomService.fetchRooms(),
        throwsException,
      );
    });

    test('fetchRooms parses different room availabilities correctly', () async {
      final complexResponse = '''
      [
        {
          "name": "Room 1",
          "capacity": "8",
          "level": "7",
          "availability": {
            "08:00": "1",
            "08:30": "1",
            "09:00": "0",
            "09:30": "0"
          }
        },
        {
          "name": "Room 2",
          "capacity": "4",
          "level": "8",
          "availability": {
            "08:00": "0",
            "08:30": "0",
            "09:00": "1",
            "09:30": "1"
          }
        }
      ]
      ''';

      when(mockHttpClient.get(any)).thenAnswer((_) async =>
          http.Response(complexResponse, 200));

      final rooms = await roomService.fetchRooms();

      expect(rooms.length, equals(2));
      expect(rooms[0].name, equals('Room 1'));
      expect(rooms[0].availability['08:00'], equals('1'));
      expect(rooms[1].name, equals('Room 2'));
      expect(rooms[1].availability['08:00'], equals('0'));
    });

    test('fetchRooms handles empty response correctly', () async {
      when(mockHttpClient.get(any)).thenAnswer((_) async =>
          http.Response('[]', 200));

      final rooms = await roomService.fetchRooms();
      expect(rooms, isEmpty);
    });

    test('fetchRooms handles malformed JSON correctly', () async {
      when(mockHttpClient.get(any)).thenAnswer((_) async =>
          http.Response('{"invalid": "json"}', 200));

      expect(
            () => roomService.fetchRooms(),
        throwsException,
      );
    });
  });
}
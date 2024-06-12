// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:heathtrack/services/authService.dart';
// import 'package:mockito/mockito.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

// import 'package:heathtrack/models/heathData.dart';
// import 'package:heathtrack/providers/userProvider.dart';
// import 'package:heathtrack/services/patientServices.dart';
// import 'package:heathtrack/constants/utils.dart';

// class MockClient extends Mock implements http.Client {}

// class MockUserProvider extends Mock implements UserProvider {}

// void main() {
//   group('fetchHeathData', () {
//     final mockClient = MockClient();
//     final mockUserProvider = MockUserProvider();
//     final patientServices = PatientServices();

//     const userId = '66574e3336172719641028eb';
//     const token =
//         'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NTc0ZTMzMzYxNzI3MTk2NDEwMjhlYiIsImlhdCI6MTcxNzA0MTQ2MX0.b6xq1Bxqd0JpGPbWKqy4gtPNV9M0XkaH8ltzRQ-t2cE';

//     setUp(() {});

//     test('returns health data if the http call completes successfully',
//         () async {
//       final mockResponse = [
//         {
//           'heartRate': 68,
//           'spb': 97,
//           'dbp': 66,
//           'oxygen': 97.24,  
//           'temperature': 37,
//           'glucose': 81,
//           'step': 1023,
//           'timestamp': '2024-03-12T16:05:27.714Z',
//           'userId': userId,
//         },
//       ];

//       when(mockClient.get(
//         Uri.parse('$uri/api/get-heath-data?userId=$userId'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': token,
//         },
//       )).thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

//       final context = MockBuildContext();
//       final healthData = await patientServices.fetchHeathData(context);

//       expect(healthData, isA<List<HeathData>>());
//       expect(healthData.length, 1);
//       expect(healthData[0].heartRate, 70);
//       expect(healthData[0].spb, 120);
//       expect(healthData[0].dbp, 80);
//       expect(healthData[0].oxygen, 98.5);
//       expect(healthData[0].temperature, 36.6);
//       expect(healthData[0].glucose, 90);
//       expect(healthData[0].step, 10000);
//       expect(healthData[0].timestamp, '2023-01-01T12:00:00Z');
//       expect(healthData[0].userId, userId);
//     });

//     test('throws an exception if the http call completes with an error',
//         () async {
//       when(mockClient.get(
//         Uri.parse('http://example.com/api/get-heath-data?userId=$userId'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': token,
//         },
//       )).thenAnswer((_) async => http.Response('Not Found', 404));

//       final context = MockBuildContext();

//       expect(patientServices.fetchHeathData(context), throwsException);
//     });

//     test('shows snackbar if an exception is thrown', () async {
//       when(mockClient.get(
//         Uri.parse('http://example.com/api/get-heath-data?userId=$userId'),
//         headers: {
//           'Content-Type': 'application/json; charset=UTF-8',
//           'x-auth-token': token,
//         },
//       )).thenThrow(Exception('Failed to fetch data'));

//       final context = MockBuildContext();

//       await patientServices.fetchHeathData(context);

//       verify(showSnackBar(context, 'Exception: Failed to fetch data'))
//           .called(1);
//     });
//   });
// }

// class MockBuildContext extends Mock implements BuildContext {}

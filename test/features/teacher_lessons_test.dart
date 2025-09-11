// import 'package:flutter_test/flutter_test.dart';
// import 'package:lmc_app/core/di/shared_pref.dart';
// import 'package:lmc_app/core/networking/api_service.dart';
// import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/data/models/tacher_course_lessons_model.dart';
// import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/logic/cubit/teacher_lessons_cubit.dart';
// import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/logic/cubit/teacher_lessons_state.dart';
// import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/logic/usecases/teacher_lessons_usescase.dart';
// import 'package:lmc_app/features/teacher_features/teacher_schedule/data/models/teacher_schedule_model.dart';
// import 'package:mockito/mockito.dart';
// import 'package:mockito/annotations.dart';
// import 'package:bloc_test/bloc_test.dart';
// import 'package:dio/dio.dart';

// // Generate mocks - run: flutter packages pub run build_runner build
// @GenerateMocks([ApiService, GetTeacherLessonsUsecase, Dio, LocalStorage])
// import 'teacher_lessons_test.mocks.dart';

// void main() {
//   group('TacherCourseLessonsModel Tests', () {
//     test('should create model from JSON correctly', () {
//       // Arrange
//       final json = {
//         'CourseId': 'course1',
//         'Lessons': [
//           {
//             'id': 1,
//             'CourseId': 1,
//             'Title': 'Flutter Basics',
//             'Date': '2024-01-15',
//             'Start_Time': '10:00',
//             'End_Time': '11:30',
//             'created_at': '2024-01-01T10:00:00Z',
//             'updated_at': '2024-01-02T10:00:00Z',
//             'course': {
//               'id': 1,
//               'TeacherId': 1,
//               'LanguageId': 1,
//               'Description': 'Learn Flutter',
//               'Photo': 'photo.jpg',
//               'Status': 'active',
//               'Level': 'beginner',
//               'created_at': '2024-01-01T10:00:00Z',
//               'updated_at': '2024-01-02T10:00:00Z',
//               'language': {
//                 'id': 1,
//                 'Name': 'English',
//                 'Description': 'English Language',
//                 'created_at': '2024-01-01T10:00:00Z',
//                 'updated_at': '2024-01-02T10:00:00Z',
//               },
//               'user': {
//                 'id': 1,
//                 'name': 'John Teacher',
//                 'email': 'john@example.com',
//                 'email_verified_at': null,
//                 'role_id': 2,
//                 'created_at': '2024-01-01T10:00:00Z',
//                 'updated_at': '2024-01-02T10:00:00Z',
//                 'deleted_at': null,
//               },
//             },
//           },
//         ],
//       };

//       // Act
//       final model = TacherCourseLessonsModel.fromJson(json);

//       // Assert
//       expect(model.courseId, equals('course1'));
//       expect(model.lessons, isNotNull);
//       expect(model.lessons!.length, equals(1));

//       final lesson = model.lessons!.first;
//       expect(lesson.id, equals(1));
//       expect(lesson.courseId, equals(1));
//       expect(lesson.title, equals('Flutter Basics'));
//       expect(lesson.date, equals('2024-01-15'));
//       expect(lesson.startTime, equals('10:00'));
//       expect(lesson.endTime, equals('11:30'));
//       expect(lesson.course, isNotNull);
//       expect(lesson.course!.description, equals('Learn Flutter'));
//       expect(lesson.course!.language, isNotNull);
//       expect(lesson.course!.language!.name, equals('English'));
//       expect(lesson.course!.user, isNotNull);
//       expect(lesson.course!.user!.name, equals('John Teacher'));
//     });

//     test(
//       'should create model with null lessons when lessons array is null',
//       () {
//         // Arrange
//         final json = {'CourseId': 'course1', 'Lessons': null};

//         // Act
//         final model = TacherCourseLessonsModel.fromJson(json);

//         // Assert
//         expect(model.courseId, equals('course1'));
//         expect(model.lessons, isNull);
//       },
//     );

//     test('should convert model to JSON correctly', () {
//       // Arrange
//       final user = User(
//         id: 1,
//         name: 'John Teacher',
//         email: 'john@example.com',
//         roleId: 2,
//         createdAt: '2024-01-01T10:00:00Z',
//         updatedAt: '2024-01-02T10:00:00Z',
//       );

//       final language = Language(
//         id: 1,
//         name: 'English',
//         description: 'English Language',
//         createdAt: '2024-01-01T10:00:00Z',
//         updatedAt: '2024-01-02T10:00:00Z',
//       );

//       final course = Course(
//         id: 1,
//         teacherId: 1,
//         languageId: 1,
//         description: 'Learn Flutter',
//         photo: 'photo.jpg',
//         status: 'active',
//         level: 'beginner',
//         createdAt: '2024-01-01T10:00:00Z',
//         updatedAt: '2024-01-02T10:00:00Z',
//         language: language,
//         user: user,
//       );

//       final lesson = Lessons(
//         id: 1,
//         courseId: 1,
//         title: 'Flutter Basics',
//         date: '2024-01-15',
//         startTime: '10:00',
//         endTime: '11:30',
//         createdAt: '2024-01-01T10:00:00Z',
//         updatedAt: '2024-01-02T10:00:00Z',
//         course: course,
//       );

//       final model = TacherCourseLessonsModel(
//         courseId: 'course1',
//         lessons: [lesson],
//       );

//       // Act
//       final json = model.toJson();

//       // Assert
//       expect(json['CourseId'], equals('course1'));
//       expect(json['Lessons'], isNotNull);
//       expect(json['Lessons'], isList);
//       expect((json['Lessons'] as List).length, equals(1));

//       final lessonJson = (json['Lessons'] as List).first;
//       expect(lessonJson['id'], equals(1));
//       expect(lessonJson['Title'], equals('Flutter Basics'));
//       expect(lessonJson['course'], isNotNull);
//     });
//   });

//   group('Lessons Model Tests', () {
//     test('should create lesson from JSON correctly', () {
//       // Arrange
//       final json = {
//         'id': 1,
//         'CourseId': 1,
//         'Title': 'Flutter Basics',
//         'Date': '2024-01-15',
//         'Start_Time': '10:00',
//         'End_Time': '11:30',
//         'created_at': '2024-01-01T10:00:00Z',
//         'updated_at': '2024-01-02T10:00:00Z',
//         'course': null,
//       };

//       // Act
//       final lesson = Lessons.fromJson(json);

//       // Assert
//       expect(lesson.id, equals(1));
//       expect(lesson.courseId, equals(1));
//       expect(lesson.title, equals('Flutter Basics'));
//       expect(lesson.date, equals('2024-01-15'));
//       expect(lesson.startTime, equals('10:00'));
//       expect(lesson.endTime, equals('11:30'));
//       expect(lesson.createdAt, equals('2024-01-01T10:00:00Z'));
//       expect(lesson.updatedAt, equals('2024-01-02T10:00:00Z'));
//       expect(lesson.course, isNull);
//     });

//     test('should convert lesson to JSON correctly', () {
//       // Arrange
//       final lesson = Lessons(
//         id: 1,
//         courseId: 1,
//         title: 'Flutter Basics',
//         date: '2024-01-15',
//         startTime: '10:00',
//         endTime: '11:30',
//         createdAt: '2024-01-01T10:00:00Z',
//         updatedAt: '2024-01-02T10:00:00Z',
//       );

//       // Act
//       final json = lesson.toJson();

//       // Assert
//       expect(json['id'], equals(1));
//       expect(json['CourseId'], equals(1));
//       expect(json['Title'], equals('Flutter Basics'));
//       expect(json['Date'], equals('2024-01-15'));
//       expect(json['Start_Time'], equals('10:00'));
//       expect(json['End_Time'], equals('11:30'));
//       expect(json['created_at'], equals('2024-01-01T10:00:00Z'));
//       expect(json['updated_at'], equals('2024-01-02T10:00:00Z'));
//       expect(json['course'], isNull);
//     });
//   });

//   group('Course Model Tests', () {
//     test('should create course from JSON correctly', () {
//       // Arrange
//       final json = {
//         'id': 1,
//         'TeacherId': 1,
//         'LanguageId': 1,
//         'Description': 'Learn Flutter',
//         'Photo': 'photo.jpg',
//         'Status': 'active',
//         'Level': 'beginner',
//         'created_at': '2024-01-01T10:00:00Z',
//         'updated_at': '2024-01-02T10:00:00Z',
//         'language': null,
//         'user': null,
//       };

//       // Act
//       final course = Course.fromJson(json);

//       // Assert
//       expect(course.id, equals(1));
//       expect(course.teacherId, equals(1));
//       expect(course.languageId, equals(1));
//       expect(course.description, equals('Learn Flutter'));
//       expect(course.photo, equals('photo.jpg'));
//       expect(course.status, equals('active'));
//       expect(course.level, equals('beginner'));
//       expect(course.language, isNull);
//       expect(course.user, isNull);
//     });

//     test('should convert course to JSON correctly', () {
//       // Arrange
//       final course = Course(
//         id: 1,
//         teacherId: 1,
//         languageId: 1,
//         description: 'Learn Flutter',
//         photo: 'photo.jpg',
//         status: 'active',
//         level: 'beginner',
//         createdAt: '2024-01-01T10:00:00Z',
//         updatedAt: '2024-01-02T10:00:00Z',
//       );

//       // Act
//       final json = course.toJson();

//       // Assert
//       expect(json['id'], equals(1));
//       expect(json['TeacherId'], equals(1));
//       expect(json['LanguageId'], equals(1));
//       expect(json['Description'], equals('Learn Flutter'));
//       expect(json['Photo'], equals('photo.jpg'));
//       expect(json['Status'], equals('active'));
//       expect(json['Level'], equals('beginner'));
//     });
//   });

//   group('Language Model Tests', () {
//     test('should create language from JSON correctly', () {
//       // Arrange
//       final json = {
//         'id': 1,
//         'Name': 'English',
//         'Description': 'English Language',
//         'created_at': '2024-01-01T10:00:00Z',
//         'updated_at': '2024-01-02T10:00:00Z',
//       };

//       // Act
//       final language = Language.fromJson(json);

//       // Assert
//       expect(language.id, equals(1));
//       expect(language.name, equals('English'));
//       expect(language.description, equals('English Language'));
//       expect(language.createdAt, equals('2024-01-01T10:00:00Z'));
//       expect(language.updatedAt, equals('2024-01-02T10:00:00Z'));
//     });

//     test('should convert language to JSON correctly', () {
//       // Arrange
//       final language = Language(
//         id: 1,
//         name: 'English',
//         description: 'English Language',
//         createdAt: '2024-01-01T10:00:00Z',
//         updatedAt: '2024-01-02T10:00:00Z',
//       );

//       // Act
//       final json = language.toJson();

//       // Assert
//       expect(json['id'], equals(1));
//       expect(json['Name'], equals('English'));
//       expect(json['Description'], equals('English Language'));
//       expect(json['created_at'], equals('2024-01-01T10:00:00Z'));
//       expect(json['updated_at'], equals('2024-01-02T10:00:00Z'));
//     });
//   });

//   group('User Model Tests', () {
//     test('should create user from JSON correctly', () {
//       // Arrange
//       final json = {
//         'id': 1,
//         'name': 'John Teacher',
//         'email': 'john@example.com',
//         'email_verified_at': null,
//         'role_id': 2,
//         'created_at': '2024-01-01T10:00:00Z',
//         'updated_at': '2024-01-02T10:00:00Z',
//         'deleted_at': null,
//       };

//       // Act
//       final user = User.fromJson(json);

//       // Assert
//       expect(user.id, equals(1));
//       expect(user.name, equals('John Teacher'));
//       expect(user.email, equals('john@example.com'));
//       expect(user.emailVerifiedAt, isNull);
//       expect(user.roleId, equals(2));
//       expect(user.createdAt, equals('2024-01-01T10:00:00Z'));
//       expect(user.updatedAt, equals('2024-01-02T10:00:00Z'));
//       expect(user.deletedAt, isNull);
//     });

//     test('should convert user to JSON correctly', () {
//       // Arrange
//       final user = User(
//         id: 1,
//         name: 'John Teacher',
//         email: 'john@example.com',
//         roleId: 2,
//         createdAt: '2024-01-01T10:00:00Z',
//         updatedAt: '2024-01-02T10:00:00Z',
//       );

//       // Act
//       final json = user.toJson();

//       // Assert
//       expect(json['id'], equals(1));
//       expect(json['name'], equals('John Teacher'));
//       expect(json['email'], equals('john@example.com'));
//       expect(json['role_id'], equals(2));
//       expect(json['created_at'], equals('2024-01-01T10:00:00Z'));
//       expect(json['updated_at'], equals('2024-01-02T10:00:00Z'));
//     });
//   });

//   group('ApiService getTeacherLessons Tests', () {
//     late MockDio mockDio;
//     late MockLocalStorage mockLocalStorage;
//     late ApiService apiService;

//     const String baseUrl = 'http://10.34.151.150:8000/api';
//     const String testToken =
//         '15|xravor4I5NNVpBjv7cGDVxonF6WtcSs8b61rFL275db95ff5';
//     const int courseId = 1;

//     setUp(() {
//       mockDio = MockDio();
//       mockLocalStorage = MockLocalStorage();
//       // Initialize ApiService with your actual constructor parameters
//       apiService = ApiService();
//     });

//     group('Successful API Calls', () {
//       test(
//         'should return list of lessons when API call is successful',
//         () async {
//           // Arrange
//           final responseData = {
//             'CourseId': '1',
//             'Lessons': [
//               {
//                 'id': 1,
//                 'CourseId': 1,
//                 'Title': 'Flutter Basics',
//                 'Date': '2024-01-15',
//                 'Start_Time': '10:00',
//                 'End_Time': '11:30',
//                 'created_at': '2024-01-01T10:00:00Z',
//                 'updated_at': '2024-01-02T10:00:00Z',
//                 'course': null,
//               },
//               {
//                 'id': 2,
//                 'CourseId': 1,
//                 'Title': 'Advanced Flutter',
//                 'Date': '2024-01-16',
//                 'Start_Time': '14:00',
//                 'End_Time': '15:30',
//                 'created_at': '2024-01-01T10:00:00Z',
//                 'updated_at': '2024-01-02T10:00:00Z',
//                 'course': null,
//               },
//             ],
//           };

//           final response = Response(
//             data: responseData,
//             statusCode: 200,
//             requestOptions: RequestOptions(path: '/getCourseLessons/$courseId'),
//           );

//           when(mockLocalStorage.getToken()).thenAnswer((_) async => testToken);
//           when(
//             mockDio.get('$baseUrl/getCourseLessons/$courseId', options: any),
//           ).thenAnswer((_) async => response);

//           // Act
//           final result = await apiService.getTeacherLessons(courseId);

//           // Assert
//           expect(result, isA<List<Lessons>>());
//           expect(result.length, equals(2));
//           expect(result.first.title, equals('Flutter Basics'));
//           expect(result.last.title, equals('Advanced Flutter'));

//           verify(mockLocalStorage.getToken()).called(1);
//           verify(
//             mockDio.get(
//               '$baseUrl/getCourseLessons/$courseId',
//               options: argThat(isA<Options>(), named: 'options'),
//             ),
//           ).called(1);
//         },
//       );

//       test('should return empty list when lessons array is null', () async {
//         // Arrange
//         final responseData = {'CourseId': '1', 'Lessons': null};

//         final response = Response(
//           data: responseData,
//           statusCode: 200,
//           requestOptions: RequestOptions(path: '/getCourseLessons/$courseId'),
//         );

//         when(mockLocalStorage.getToken()).thenAnswer((_) async => testToken);
//         when(
//           mockDio.get('$baseUrl/getCourseLessons/$courseId', options: any),
//         ).thenAnswer((_) async => response);

//         // Act
//         final result = await apiService.getTeacherLessons(courseId);

//         // Assert
//         expect(result, isA<List<Lessons>>());
//         expect(result, isEmpty);

//         verify(mockLocalStorage.getToken()).called(1);
//         verify(mockDio.get(any, options: any)).called(1);
//       });

//       test('should include correct authorization header', () async {
//         // Arrange
//         final responseData = {'CourseId': '1', 'Lessons': []};
//         final response = Response(
//           data: responseData,
//           statusCode: 200,
//           requestOptions: RequestOptions(path: '/getCourseLessons/$courseId'),
//         );

//         when(mockLocalStorage.getToken()).thenAnswer((_) async => testToken);
//         when(mockDio.get(any, options: any)).thenAnswer((_) async => response);

//         // Act
//         await apiService.getTeacherLessons(courseId);

//         // Assert
//         final captured =
//             verify(
//               mockDio.get(
//                 captureThat(equals('$baseUrl/getCourseLessons/$courseId')),
//                 options: captureAnyNamed('options'),
//               ),
//             ).captured;

//         final capturedOptions = captured[1] as Options;
//         expect(
//           capturedOptions.headers!['Authorization'],
//           equals('Bearer $testToken'),
//         );
//       });
//     });

//     group('Error Handling', () {
//       test('should throw exception when status code is not 200', () async {
//         // Arrange
//         final response = Response(
//           data: {'error': 'Course not found'},
//           statusCode: 404,
//           requestOptions: RequestOptions(path: '/getCourseLessons/$courseId'),
//         );

//         when(mockLocalStorage.getToken()).thenAnswer((_) async => testToken);
//         when(mockDio.get(any, options: any)).thenAnswer((_) async => response);

//         // Act & Assert
//         expect(
//           () async => await apiService.getTeacherLessons(courseId),
//           throwsA(
//             isA<Exception>().having(
//               (e) => e.toString(),
//               'message',
//               contains('Failed to load lessons'),
//             ),
//           ),
//         );

//         verify(mockLocalStorage.getToken()).called(1);
//         verify(mockDio.get(any, options: any)).called(1);
//       });

//       test('should throw DioException when network error occurs', () async {
//         // Arrange
//         final dioError = DioException(
//           requestOptions: RequestOptions(path: '/getCourseLessons/$courseId'),
//           message: 'Network error',
//           type: DioExceptionType.connectionTimeout,
//         );

//         when(mockLocalStorage.getToken()).thenAnswer((_) async => testToken);
//         when(mockDio.get(any, options: any)).thenThrow(dioError);

//         // Act & Assert
//         expect(
//           () async => await apiService.getTeacherLessons(courseId),
//           throwsA(
//             isA<Exception>().having(
//               (e) => e.toString(),
//               'message',
//               contains('Network error'),
//             ),
//           ),
//         );

//         verify(mockLocalStorage.getToken()).called(1);
//         verify(mockDio.get(any, options: any)).called(1);
//       });
//     });
//   });

//   group('GetTeacherLessonsUsecase Tests', () {
//     late MockApiService mockApiService;
//     late GetTeacherLessonsUsecase usecase;

//     setUp(() {
//       mockApiService = MockApiService();
//       usecase = GetTeacherLessonsUsecase(mockApiService);
//     });

//     test('should return list of lessons when API call is successful', () async {
//       // Arrange
//       const courseId = 1;
//       final expectedLessons = [
//         Lessons(
//           id: 1,
//           courseId: 1,
//           title: 'Flutter Basics',
//           date: '2024-01-15',
//           startTime: '10:00',
//           endTime: '11:30',
//         ),
//         Lessons(
//           id: 2,
//           courseId: 1,
//           title: 'Advanced Flutter',
//           date: '2024-01-16',
//           startTime: '14:00',
//           endTime: '15:30',
//         ),
//       ];

//       when(
//         mockApiService.getTeacherLessons(courseId),
//       ).thenAnswer((_) async => expectedLessons);

//       // Act
//       final result = await usecase.execute(courseId);

//       // Assert
//       expect(result, equals(expectedLessons));
//       expect(result.length, equals(2));
//       expect(result.first.title, equals('Flutter Basics'));
//       expect(result.last.title, equals('Advanced Flutter'));
//       verify(mockApiService.getTeacherLessons(courseId)).called(1);
//     });

//     test('should throw exception when API call fails', () async {
//       // Arrange
//       const courseId = 1;
//       const errorMessage = 'Network error';

//       when(
//         mockApiService.getTeacherLessons(courseId),
//       ).thenThrow(Exception(errorMessage));

//       // Act & Assert
//       expect(
//         () async => await usecase.execute(courseId),
//         throwsA(
//           isA<Exception>().having(
//             (e) => e.toString(),
//             'message',
//             contains('Error getting lessons'),
//           ),
//         ),
//       );
//       verify(mockApiService.getTeacherLessons(courseId)).called(1);
//     });

//     test('should return empty list when API returns empty list', () async {
//       // Arrange
//       const courseId = 1;
//       final expectedLessons = <Lessons>[];

//       when(
//         mockApiService.getTeacherLessons(courseId),
//       ).thenAnswer((_) async => expectedLessons);

//       // Act
//       final result = await usecase.execute(courseId);

//       // Assert
//       expect(result, isEmpty);
//       verify(mockApiService.getTeacherLessons(courseId)).called(1);
//     });
//   });

//   group('TeacherLessonsState Tests', () {
//     group('LessonsInitial', () {
//       test('should extend TeacherLessonsState', () {
//         expect(LessonsInitial(), isA<TeacherLessonsState>());
//       });

//       test('props should be empty', () {
//         expect(LessonsInitial().props, equals([]));
//       });

//       test('two instances should be equal', () {
//         expect(LessonsInitial(), equals(LessonsInitial()));
//       });
//     });

//     group('LessonsLoading', () {
//       test('should extend TeacherLessonsState', () {
//         expect(LessonsLoading(), isA<TeacherLessonsState>());
//       });

//       test('props should be empty', () {
//         expect(LessonsLoading().props, equals([]));
//       });

//       test('two instances should be equal', () {
//         expect(LessonsLoading(), equals(LessonsLoading()));
//       });
//     });

//     group('LessonsSuccess', () {
//       final mockLessons = [
//         Lessons(id: 1, title: 'Lesson 1', courseId: 1),
//         Lessons(id: 2, title: 'Lesson 2', courseId: 1),
//       ];

//       test('should extend TeacherLessonsState', () {
//         expect(LessonsSuccess(mockLessons), isA<TeacherLessonsState>());
//       });

//       test('props should contain myLessons', () {
//         final state = LessonsSuccess(mockLessons);
//         expect(state.props, equals([mockLessons]));
//       });

//       test('should have correct myLessons property', () {
//         final state = LessonsSuccess(mockLessons);
//         expect(state.myLessons, equals(mockLessons));
//         expect(state.myLessons.length, equals(2));
//       });

//       test('two instances with same data should be equal', () {
//         final state1 = LessonsSuccess(mockLessons);
//         final state2 = LessonsSuccess(mockLessons);
//         expect(state1, equals(state2));
//       });

//       test('two instances with different data should not be equal', () {
//         final otherLessons = [Lessons(id: 3, title: 'Lesson 3', courseId: 456)];
//         final state1 = LessonsSuccess(mockLessons);
//         final state2 = LessonsSuccess(otherLessons);
//         expect(state1, isNot(equals(state2)));
//       });
//     });

//     group('LessonsFailure', () {
//       const errorMessage = 'Something went wrong';

//       test('should extend TeacherLessonsState', () {
//         expect(LessonsFailure(errorMessage), isA<TeacherLessonsState>());
//       });

//       test('props should contain error', () {
//         final state = LessonsFailure(errorMessage);
//         expect(state.props, equals([errorMessage]));
//       });

//       test('should have correct error property', () {
//         final state = LessonsFailure(errorMessage);
//         expect(state.error, equals(errorMessage));
//       });

//       test('two instances with same error should be equal', () {
//         final state1 = LessonsFailure(errorMessage);
//         final state2 = LessonsFailure(errorMessage);
//         expect(state1, equals(state2));
//       });

//       test('two instances with different errors should not be equal', () {
//         const otherError = 'Different error';
//         final state1 = LessonsFailure(errorMessage);
//         final state2 = LessonsFailure(otherError);
//         expect(state1, isNot(equals(state2)));
//       });
//     });
//   });

//   group('TeacherLessonsCubit Tests', () {
//     late MockGetTeacherLessonsUsecase mockGetLessonsUsecase;
//     late TeacherLessonsCubit cubit;

//     setUp(() {
//       mockGetLessonsUsecase = MockGetTeacherLessonsUsecase();
//       cubit = TeacherLessonsCubit(mockGetLessonsUsecase);
//     });

//     tearDown(() {
//       cubit.close();
//     });

//     test('initial state should be LessonsInitial', () {
//       expect(cubit.state, equals(LessonsInitial()));
//     });

//     group('fetchLessons', () {
//       const courseId = 1;
//       final mockLessons = [
//         Lessons(
//           id: 1,
//           courseId: 1,
//           title: 'Flutter Basics',
//           date: '2024-01-15',
//           startTime: '10:00',
//           endTime: '11:30',
//         ),
//         Lessons(
//           id: 2,
//           courseId: 1,
//           title: 'Advanced Flutter',
//           date: '2024-01-16',
//           startTime: '14:00',
//           endTime: '15:30',
//         ),
//       ];

//       blocTest<TeacherLessonsCubit, TeacherLessonsState>(
//         'emits [LessonsLoading, LessonsSuccess] when fetchLessons is successful',
//         build: () {
//           when(
//             mockGetLessonsUsecase.execute(courseId),
//           ).thenAnswer((_) async => mockLessons);
//           return cubit;
//         },
//         act: (cubit) => cubit.fetchLessons(courseId),
//         expect: () => [LessonsLoading(), LessonsSuccess(mockLessons)],
//         verify: (_) {
//           verify(mockGetLessonsUsecase.execute(courseId)).called(1);
//         },
//       );

//       blocTest<TeacherLessonsCubit, TeacherLessonsState>(
//         'emits [LessonsLoading, LessonsFailure] when fetchLessons fails',
//         build: () {
//           when(
//             mockGetLessonsUsecase.execute(courseId),
//           ).thenThrow(Exception('Network error'));
//           return cubit;
//         },
//         act: (cubit) => cubit.fetchLessons(courseId),
//         expect:
//             () => [
//               LessonsLoading(),
//               LessonsFailure('Exception: Network error'),
//             ],
//         verify: (_) {
//           verify(mockGetLessonsUsecase.execute(courseId)).called(1);
//         },
//       );

//       blocTest<TeacherLessonsCubit, TeacherLessonsState>(
//         'emits [LessonsLoading, LessonsSuccess] with empty list when no lessons found',
//         build: () {
//           when(
//             mockGetLessonsUsecase.execute(courseId),
//           ).thenAnswer((_) async => []);
//           return cubit;
//         },
//         act: (cubit) => cubit.fetchLessons(courseId),
//         expect: () => [LessonsLoading(), LessonsSuccess([])],
//         verify: (_) {
//           verify(mockGetLessonsUsecase.execute(courseId)).called(1);
//         },
//       );

//       blocTest<TeacherLessonsCubit, TeacherLessonsState>(
//         'emits [LessonsLoading, LessonsFailure] when usecase throws string error',
//         build: () {
//           when(
//             mockGetLessonsUsecase.execute(courseId),
//           ).thenThrow('String error message');
//           return cubit;
//         },
//         act: (cubit) => cubit.fetchLessons(courseId),
//         expect:
//             () => [LessonsLoading(), LessonsFailure('String error message')],
//         verify: (_) {
//           verify(mockGetLessonsUsecase.execute(courseId)).called(1);
//         },
//       );

//       blocTest<TeacherLessonsCubit, TeacherLessonsState>(
//         'calls usecase with correct courseId',
//         build: () {
//           when(
//             mockGetLessonsUsecase.execute(any),
//           ).thenAnswer((_) async => mockLessons);
//           return cubit;
//         },
//         act: (cubit) => cubit.fetchLessons(456), // Different courseId
//         expect: () => [LessonsLoading(), LessonsSuccess(mockLessons)],
//         verify: (_) {
//           verify(mockGetLessonsUsecase.execute(456)).called(1);
//           verifyNever(mockGetLessonsUsecase.execute(1));
//         },
//       );

//       blocTest<TeacherLessonsCubit, TeacherLessonsState>(
//         'can handle multiple consecutive calls',
//         build: () {
//           when(
//             mockGetLessonsUsecase.execute(any),
//           ).thenAnswer((_) async => mockLessons);
//           return cubit;
//         },
//         act: (cubit) async {
//           await cubit.fetchLessons(1);
//           await cubit.fetchLessons(456);
//         },
//         expect:
//             () => [
//               LessonsLoading(),
//               LessonsSuccess(mockLessons),
//               LessonsLoading(),
//               LessonsSuccess(mockLessons),
//             ],
//         verify: (_) {
//           verify(mockGetLessonsUsecase.execute(1)).called(1);
//           verify(mockGetLessonsUsecase.execute(456)).called(1);
//         },
//       );

//       test('should handle timeout errors', () async {
//         // Arrange
//         when(mockGetLessonsUsecase.execute(courseId)).thenAnswer((_) async {
//           await Future.delayed(Duration(seconds: 1));
//           throw Exception('Timeout');
//         });

//         // Act & Assert
//         expect(
//           cubit.stream,
//           emitsInOrder([
//             LessonsLoading(),
//             LessonsFailure('Exception: Timeout'),
//           ]),
//         );

//         await cubit.fetchLessons(courseId);
//       });
//     });

//     group('State Transitions', () {
//       test(
//         'should maintain state after error until next fetchLessons call',
//         () async {
//           // Arrange
//           const courseId = 1;
//           when(
//             mockGetLessonsUsecase.execute(courseId),
//           ).thenThrow(Exception('Network error'));

//           // Act
//           await cubit.fetchLessons(courseId);

//           // Assert
//           expect(cubit.state, isA<LessonsFailure>());
//           expect(
//             (cubit.state as LessonsFailure).error,
//             equals('Exception: Network error'),
//           );
//         },
//       );

//       test(
//         'should maintain state after success until next fetchLessons call',
//         () async {
//           // Arrange
//           const courseId = 1;
//           final mockLessons = [
//             Lessons(id: 1, title: 'Test Lesson', courseId: courseId),
//           ];
//           when(
//             mockGetLessonsUsecase.execute(courseId),
//           ).thenAnswer((_) async => mockLessons);

//           // Act
//           await cubit.fetchLessons(courseId);

//           // Assert
//           expect(cubit.state, isA<LessonsSuccess>());
//           expect(
//             (cubit.state as LessonsSuccess).myLessons,
//             equals(mockLessons),
//           );
//         },
//       );
//     });

//     group('Edge Cases', () {
//       test('should handle very large courseId', () async {
//         // Arrange
//         const largeCourseId = 999999999;
//         final mockLessons = [
//           Lessons(id: 1, title: 'Test Lesson', courseId: largeCourseId),
//         ];

//         when(
//           mockGetLessonsUsecase.execute(largeCourseId),
//         ).thenAnswer((_) async => mockLessons);

//         // Act
//         await cubit.fetchLessons(largeCourseId);

//         // Assert
//         expect(cubit.state, isA<LessonsSuccess>());
//         verify(mockGetLessonsUsecase.execute(largeCourseId)).called(1);
//       });

//       test('should handle zero courseId', () async {
//         // Arrange
//         const zeroCourseId = 0;
//         final mockLessons = <Lessons>[];

//         when(
//           mockGetLessonsUsecase.execute(zeroCourseId),
//         ).thenAnswer((_) async => mockLessons);

//         // Act
//         await cubit.fetchLessons(zeroCourseId);

//         // Assert
//         expect(cubit.state, isA<LessonsSuccess>());
//         expect((cubit.state as LessonsSuccess).myLessons, isEmpty);
//         verify(mockGetLessonsUsecase.execute(zeroCourseId)).called(1);
//       });

//       test('should handle negative courseId', () async {
//         // Arrange
//         const negativeCourseId = -1;

//         when(
//           mockGetLessonsUsecase.execute(negativeCourseId),
//         ).thenThrow(Exception('Invalid course ID'));

//         // Act
//         await cubit.fetchLessons(negativeCourseId);

//         // Assert
//         expect(cubit.state, isA<LessonsFailure>());
//         expect(
//           (cubit.state as LessonsFailure).error,
//           equals('Exception: Invalid course ID'),
//         );
//         verify(mockGetLessonsUsecase.execute(negativeCourseId)).called(1);
//       });
//     });

//     group('Performance Tests', () {
//       test('should handle large number of lessons efficiently', () async {
//         // Arrange
//         const courseId = 1;
//         final largeLessonsList = List.generate(
//           1000,
//           (index) => Lessons(
//             id: index + 1,
//             courseId: courseId,
//             title: 'Lesson ${index + 1}',
//             date: '2024-01-${(index % 28) + 1}',
//             startTime: '${(index % 12) + 8}:00',
//             endTime: '${(index % 12) + 9}:30',
//           ),
//         );

//         when(
//           mockGetLessonsUsecase.execute(courseId),
//         ).thenAnswer((_) async => largeLessonsList);

//         // Act & Assert - Should complete without timeout
//         await cubit.fetchLessons(courseId);

//         expect(cubit.state, isA<LessonsSuccess>());
//         expect((cubit.state as LessonsSuccess).myLessons.length, equals(1000));
//         verify(mockGetLessonsUsecase.execute(courseId)).called(1);
//       });

//       test('should not leak memory on repeated calls', () async {
//         // Arrange
//         const courseId = 1;
//         final mockLessons = [
//           Lessons(id: 1, title: 'Test Lesson', courseId: courseId),
//         ];

//         when(
//           mockGetLessonsUsecase.execute(courseId),
//         ).thenAnswer((_) async => mockLessons);

//         // Act - Make multiple calls
//         for (int i = 0; i < 100; i++) {
//           await cubit.fetchLessons(courseId);
//         }

//         // Assert
//         expect(cubit.state, isA<LessonsSuccess>());
//         verify(mockGetLessonsUsecase.execute(courseId)).called(100);
//       });
//     });
//   });

//   group('Integration Tests', () {
//     test('should work end-to-end with real-like data flow', () async {
//       // Arrange
//       final mockApiService = MockApiService();
//       final usecase = GetTeacherLessonsUsecase(mockApiService);
//       final cubit = TeacherLessonsCubit(usecase);

//       const courseId = 1;
//       final expectedLessons = [
//         Lessons(
//           id: 1,
//           courseId: 1,
//           title: 'Introduction to Flutter',
//           date: '2024-01-15',
//           startTime: '10:00',
//           endTime: '11:30',
//           createdAt: '2024-01-01T10:00:00Z',
//           updatedAt: '2024-01-02T10:00:00Z',
//         ),
//         Lessons(
//           id: 2,
//           courseId: 1,
//           title: 'Flutter Widgets Deep Dive',
//           date: '2024-01-16',
//           startTime: '14:00',
//           endTime: '15:30',
//           createdAt: '2024-01-01T10:00:00Z',
//           updatedAt: '2024-01-02T10:00:00Z',
//         ),
//       ];

//       when(
//         mockApiService.getTeacherLessons(courseId),
//       ).thenAnswer((_) async => expectedLessons);

//       // Act
//       await cubit.fetchLessons(courseId);

//       // Assert
//       expect(cubit.state, isA<LessonsSuccess>());
//       final successState = cubit.state as LessonsSuccess;
//       expect(successState.myLessons, equals(expectedLessons));
//       expect(successState.myLessons.length, equals(2));
//       expect(
//         successState.myLessons.first.title,
//         equals('Introduction to Flutter'),
//       );
//       expect(
//         successState.myLessons.last.title,
//         equals('Flutter Widgets Deep Dive'),
//       );

//       // Verify the complete chain was called
//       verify(mockApiService.getTeacherLessons(courseId)).called(1);

//       // Cleanup
//       await cubit.close();
//     });

//     test('should handle error propagation through all layers', () async {
//       // Arrange
//       final mockApiService = MockApiService();
//       final usecase = GetTeacherLessonsUsecase(mockApiService);
//       final cubit = TeacherLessonsCubit(usecase);

//       const courseId = 1;
//       const errorMessage = 'Network connection failed';

//       when(
//         mockApiService.getTeacherLessons(courseId),
//       ).thenThrow(Exception(errorMessage));

//       // Act
//       await cubit.fetchLessons(courseId);

//       // Assert
//       expect(cubit.state, isA<LessonsFailure>());
//       final failureState = cubit.state as LessonsFailure;
//       expect(failureState.error, contains('Error getting lessons'));

//       // Verify the error propagated through all layers
//       verify(mockApiService.getTeacherLessons(courseId)).called(1);

//       // Cleanup
//       await cubit.close();
//     });
//   });
// }

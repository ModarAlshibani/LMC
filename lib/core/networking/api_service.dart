import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/languages/data/model/language_model.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/data/model/lmc_info_model.dart';
import 'package:lmc_app/features/for_all/login/data/models/login_response.dart';
import 'package:lmc_app/features/logistic_features/show_tasks/data/models/all_tasks_model.dart'
    hide User;
import 'package:lmc_app/features/student_features/my_courses/show_lessons/data/models/lessons_model.dart';
import 'package:lmc_app/features/student_features/notes/data/models/note_model.dart';
import 'package:lmc_app/features/student_features/show_teachers/data/models/teacher_model.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/data/models/course_student_model.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/data/models/teacher_lesson_flashcards_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/data/models/tacher_course_lessons_model.dart'
    hide User;
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/data/model/my_courses_teacher_model.dart';
import 'package:mime/mime.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import 'package:lmc_app/core/di/shared_pref.dart';
import 'package:lmc_app/features/for_all/announsments/data/models/all_announsments.dart';
import 'package:lmc_app/features/for_all/available_courses/data/models/available_courses_model.dart';

import '../../features/student_features/my_courses/show_my_courses/data/models/stu_my_courses_model.dart'
    hide MyCourses;
import '../../features/teacher_features/lessons_management/teacher_selftests/teacher_lesson_selftests_screen/data/models/selftests_model.dart';
import 'api_constants.dart';
import 'network_error_handler.dart';

class ApiService {
  final Dio dio = Dio();
  final String baseUrl = ApiConstants.baseUrl;

  Future<Response> login(
    String username,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await dio.post(
        '$baseUrl/login',
        data: {'email': username, 'password': password},
      );
      print('Status Code: ${response.statusCode}');
      print('Body: ${response.data}');
      return response;
    } on DioException catch (e) {
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  Future<Response> registerGuest(
    String name,
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await dio.post(
        '$baseUrl/registerGuest',
        data: {'name': name, 'email': email, 'password': password},
      );
      return response;
    } on DioException catch (e) {
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  Future<List<Announcements>> getAllAnnouncements() async {
    try {
      print("inside the get announcements");
      // إرسال الطلب للحصول على جميع الإعلانات من الـ API
      final response = await dio.get(
        '$baseUrl/getAllAnnouncements',
      ); // Adjust endpoint if needed

      // التحقق من حالة الاستجابة
      if (response.statusCode == 200) {
        // تحويل البيانات إلى كائن من AllAnnounsmentsModel
        final data = AllAnnounsmentsModel.fromJson(response.data);
        print("modzzzz:  " + data.announcements.toString());
        return data.announcements ?? [];
      } else {
        throw Exception('Failed to load announcements');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  Future<List<AssignedTasks>> getAllTasks() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("user tokkkkkkkken is: $token");
      print("Fetching assigned tasks...");

      final response = await dio.get(
        '$baseUrl/staff/myTasks',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final allTasksModel = AllTasksModel.fromJson(response.data);
        return allTasksModel.assignedTasks ?? [];
      } else {
        throw Exception('Failed to load tasks');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  Future<Response> markTaskAsDone(int taskId, BuildContext context) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("user tokkkkkkkken is: $token");
      print("marking task $taskId as done...");

      final response = await dio.post(
        '$baseUrl/staff/completeUserTask/$taskId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response);
      return response;
    } on DioException catch (e) {
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  // ----------------------------------------------------------------------------
  Future<List<AvailableCourses>> getAvailableCourses({
    required String primaryUrl,
    required String fallbackUrl,
  }) async {
    final localStorage = LocalStorage();
    final token = await localStorage.getToken();

    print("User token: $token");
    print("Fetching available courses from primary URL...");

    try {
      final response = await dio.get(
        '$baseUrl$primaryUrl',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      print('Raw response: ${response.data}');
      print('Type: ${response.data.runtimeType}');

      if (response.statusCode == 200) {
        final coursesModel = AvailableCoursesModel.fromJson(response.data);
        return coursesModel.availableCourses ?? [];
      } else if (response.statusCode == 403) {
        print("Primary URL returned 403. Trying fallback URL...");

        final fallbackResponse = await dio.get(
          '$baseUrl$fallbackUrl',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
            validateStatus: (status) => status != null && status < 500,
          ),
        );

        if (fallbackResponse.statusCode == 200) {
          final fallbackModel = AvailableCoursesModel.fromJson(
            fallbackResponse.data,
          );
          return fallbackModel.availableCourses ?? [];
        } else {
          throw Exception(
            'Fallback request failed with status code: ${fallbackResponse.statusCode}',
          );
        }
      } else {
        throw Exception(
          'Primary request failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //===============================================================

  Future<Response> sendInvoice({
    required int taskId,
    required double amount,
    required File imageFile,
    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      final fileName = basename(imageFile.path);

      final formData = FormData.fromMap({
        'TaskId': taskId,
        'Amount': amount,
        'Image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await dio.post(
        '$baseUrl/logistic/createInvoice',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      markTaskAsDone(taskId, context);
      return response;
    } on DioException catch (e) {
      print(e.response.toString());
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  // ----------------------------------------------------------------------------
  //--------------------Teacher Functions---------------------------------------

  Future<Response> sendTaskToSec({
    required String description,
    required DateTime deadline,
    required int courseId,
    required int lessonId,
    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final formData = FormData.fromMap({
        'Description': description,
        'Deadline': deadline,
        'CourseId': courseId,
        'LessonId': lessonId,
      });

      final response = await dio.post(
        '$baseUrl/teacher/assignTaskToSecretary',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      print(e.response.toString());
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  //-----------------------------------------------------------------------------------

  Future<List<MyCourses>> getTeacherCourses() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching available courses...");

      final response = await dio.get(
        '$baseUrl/teacher/reviewMyCourses',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final coursesModel = MyCoursesTeacherModel.fromJson(response.data);
        return coursesModel.myCourses ?? [];
      } else {
        throw Exception('Failed to load your courses');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //--------------------------------------------------------------------------
  Future<Response> AddFlashcard({
    required int lessonId,
    required String content,
    required String translation,

    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final formData = FormData.fromMap({
        'LessonId': lessonId,
        'Content': content,
        'Translation': translation,
      });

      final response = await dio.post(
        '$baseUrl/teacher/addFlashcard',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print(e.response.toString());
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }
  //--------------------------------------------------------------------------

  Future<Response> AddSelfTest({
    required int lessonId,
    required String title,
    required String description,

    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final formData = FormData.fromMap({
        'LessonId': lessonId,
        'Title': title,
        'Description': description,
      });

      final response = await dio.post(
        '$baseUrl/teacher/addSelfTest',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print(e.response.toString());
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }
  //--------------------------------------------------------------------------

  Future<Response> AddSelfTestQuestion({
    required int selfTestId,
    File? media,
    required String questionText,
    required String type,
    List<String>? choices,
    required String correctAnswer,

    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final formData = FormData();

      formData.fields.addAll([
        MapEntry('SelfTestId', selfTestId.toString()),
        MapEntry('QuestionText', questionText),
        MapEntry('Type', type),
        MapEntry('CorrectAnswer', correctAnswer),
        MapEntry('Choices', jsonEncode(choices)),
      ]);

      if (media != null) {
        final mimeType = lookupMimeType(media.path!);
        final multipartFile = await MultipartFile.fromFile(
          media.path,
          filename: media.path.split('/').last,
          contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        );

        formData.files.add(MapEntry('Media', multipartFile));
      }
      final response = await dio.post(
        '$baseUrl/teacher/addSelfTestQuestion',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print(e.response.toString());
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  // ----------------------------------------------------------------------------

  Future<Response> EditFlashcard({
    required int flashcardId,
    required String content,
    required String translation,

    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final formData = FormData.fromMap({
        'FlashcardId': flashcardId,
        'Content': content,
        'Translation': translation,
      });

      final response = await dio.post(
        '$baseUrl/teacher/editFlashcard',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print(e.response.toString());
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  // ----------------------------------------------------------------------------

  Future<Response> DeleteFlashcard({
    required int flashcardId,
    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final formData = FormData.fromMap({'FlashcardId': flashcardId});

      final response = await dio.post(
        '$baseUrl/teacher/deleteFlashcard',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print(e.response.toString());
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  // ----------------------------------------------------------------------------

  Future<List<FlashCards>> getTeacherLessonFlashcards(int lessonId) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching available courses...");

      final response = await dio.get(
        '$baseUrl/teacher/viewLessonFlashCards/$lessonId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final flashcardsModel = TeacherLessonFlashcardsModel.fromJson(
          response.data,
        );
        return flashcardsModel.flashCards ?? [];
      } else {
        throw Exception('Failed to load flashcards');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  // ----------------------------------------------------------------------------

  Future<List<SelfTests>> getSelfTests(int lessonId) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching available courses...");

      final response = await dio.get(
        '$baseUrl/teacher-student/getSelfTestsByLesson/$lessonId',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print(response.statusCode);
      print(response.toString());
      if (response.statusCode == 200) {
        final selfTestModel = SelfTestsModel.fromJson(response.data);
        return selfTestModel.selfTests ?? [];
      } else {
        throw Exception('Failed to load self tests');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //=======================================================================

  Future<Response> markAttendance({
    required int lessonId,

    required int studentId,
    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final formData = FormData.fromMap({
        'LessonId': lessonId,
        'StudentId': studentId,
      });

      final response = await dio.post(
        '$baseUrl/teacher/markAttendance',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print(e.response.toString());
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  // ----------------------------------------------------------------------------
  Future<Response> enterBonus({
    required int lessonId,
    required int studentId,
    required double bonus,
    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final formData = FormData.fromMap({
        'LessonId': lessonId,
        'StudentId': studentId,
        'Bonus': bonus,
      });

      final response = await dio.post(
        '$baseUrl/teacher/enterBonus',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      print(e.response.toString());
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  //--------------------------------------------------------------------------
  //
  Future<List<Teachers>> getTeachersList() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("user tokkkkkkkken is: $token");
      print("Fetching teachers list...");

      final response = await dio.get(
        '$baseUrl/student/viewTeachers',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print("Raw API response: ${response.data}");
      // التحقق من حالة الاستجابة
      if (response.statusCode == 200) {
        // تحويل البيانات إلى كائن من TeacherModel
        final data = TeacherModel.fromJson(response.data);
        print("modzzzz:  " + data.teachers.toString());
        return data.teachers ?? [];
      } else {
        throw Exception('Failed to load teachers list');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //-------------------------------------
  Future<List<MyCoursesStu>> getStudentMyCourses() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching available courses...");

      final response = await dio.get(
        '$baseUrl/student/viewEnrolledCourses',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final coursesModelStu = MyCoursesModelStu.fromJson(response.data);
        print('Full API response: ${response.data}');
        return coursesModelStu.myCoursesStu ?? [];
      } else {
        throw Exception('Failed to load available courses');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //----------------------------------------------------------------------------------

  Future<List<Lesson>> getLessons(int courseId) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching Lessons for the $courseId course...");

      final response = await dio.get(
        '$baseUrl/student/viewMyLessons/$courseId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final lessonsModel = LessonsModel.fromJson(response.data);
        print('Full API response: ${response.data}');
        return lessonsModel.myLessons ?? [];
      } else {
        throw Exception('Failed to load lessons');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //----------------------------------------------------------------------------------

  Future<List<Lessons>> getTeacherLessons(int courseId) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching Lessons for the $courseId course...");

      final response = await dio.get(
        '$baseUrl/getCourseLessons/$courseId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final lessonsModel = TacherCourseLessonsModel.fromJson(response.data);
        print('Full API response: ${response.data}');
        return lessonsModel.lessons ?? [];
      } else {
        throw Exception('Failed to load lessons');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //----------------------------------------------------------------------------------

  Future<User> getUserName() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching my info...");

      final response = await dio.get(
        '$baseUrl/profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final userJson = response.data['user'];
        final userModel = User.fromJson(userJson);
        print("Response data: ${response.data}");
        return User.fromJson(userJson);
      } else {
        throw Exception('Failed to load info');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //----------------------------------------------------------------------------------

  Future<LmcInfoModel> getLmcInfo() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching Info...");

      final response = await dio.get(
        '$baseUrl/viewLMCInfo',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        print("Response data: ${response.data}");
        return LmcInfoModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load Info');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //----------------------------------------------------------------------------------

  Future<bool> addNote(Notes note) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching Info...");

      final response = await dio.post(
        '$baseUrl/student/addNote',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: note.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Response data: ${response.data}");
        return true;
      } else {
        throw Exception('Failed to add note');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //----------------------------------------------------------------------------------

  Future<NoteModel> getNotes() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching Info...");

      final response = await dio.get(
        '$baseUrl/student/viewMyNotes',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        print("Response data: ${response.data}");
        return NoteModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load Notes');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //----------------------------------------------------------------------------------

  Future<bool> deleteNote(int noteId) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching Info...");

      final response = await dio.get(
        '$baseUrl/student/deleteNote/$noteId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        print("Response data: ${response.data}");
        return true;
      } else {
        throw Exception('Failed to load Notes');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //----------------------------------------------------------------------------------

  Future<bool> editNote(Notes note) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching Info...");

      final response = await dio.post(
        '$baseUrl/student/editNote/${note.id}',
        data: note.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //----------------------------------------------------------------------------------

  Future<LanguageModel> getAllLanguages() async {
    try {
      final response = await dio.get('$baseUrl/showAllLanguage');

      if (response.statusCode == 200) {
        return LanguageModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load Languages');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //=================================================================
  // ----------------------------------------------------------------------------
  Future<List<Students>> getCourseStudents(int lessonId) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching available courses...");

      final response = await dio.get(
        '$baseUrl/teacher/reviewStudentsNames/$lessonId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final studentModel = CourseStudentModel.fromJson(response.data);
        return studentModel.students ?? [];
      } else {
        throw Exception('Failed to load students names');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  // ----------------------------------------------------------------------------
}

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/holidays/data/holidays_model.dart';
import 'package:lmc_app/features/for_all/login/data/models/login_response.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/languages/data/model/language_model.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/data/lang_files_model.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/data/languages_have_library_model.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/lmc_info/data/model/lmc_info_model.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/data/private_course_model.dart'
    hide User;
import 'package:lmc_app/features/logistic_features/show_tasks/data/models/all_tasks_model.dart'
    hide User;
import 'package:lmc_app/features/student_features/certificates/data/certificate_model.dart';
import 'package:lmc_app/features/student_features/lessons_management/show_lessons/data/models/lessons_model.dart';
import 'package:lmc_app/features/student_features/notes/data/models/note_model.dart';
import 'package:lmc_app/features/student_features/show_teachers/data/models/teacher_model.dart';
import 'package:lmc_app/features/student_features/student_final_test/data/models/all_final_test_questions_model.dart';
import 'package:lmc_app/features/student_features/student_final_test/data/models/stu_final_test_resault_model.dart';
import 'package:lmc_app/features/student_features/student_final_test/data/models/stu_get_final_test_model.dart' hide User;
import 'package:lmc_app/features/teacher_features/lessons_management/attendance_and_marks/data/models/course_student_model.dart';
import 'package:lmc_app/features/teacher_features/lessons_management/teacher_flashcards/teacher_flashcards_screen/data/models/teacher_lesson_flashcards_model.dart';
import 'package:lmc_app/features/teacher_features/submit_complaint/data/models/my_complaints_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/course_flashcards/data/course_flashcards_model.dart'
    hide FlashCards;
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/data/final_test_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/final_exam_management/data/teacher_final_test_questions_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_course_lessons/data/models/tacher_course_lessons_model.dart'
    hide User;
import 'package:lmc_app/features/teacher_features/teacher_courses_management/teacher_courses/data/model/my_courses_teacher_model.dart';
import 'package:lmc_app/features/teacher_features/teacher_schedule/data/models/teacher_schedule_model.dart'
    hide Lessons, User;
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
      print('Login Status Code: ${response.statusCode}');
      print('Login Body: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        await _updateFirebaseToken(context);
      }

      return response;
    } on DioException catch (e) {
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  Future<void> _updateFirebaseToken(BuildContext context) async {
    final localStorage = LocalStorage();
    final token = await localStorage.getToken();
    print("user tokkkkkkkken is: $token");
    try {
      // Get the Firebase messaging token
      String? firebaseToken = await FirebaseMessaging.instance.getToken();

      if (firebaseToken != null) {
        print('Firebase Token: $firebaseToken');

        // Send the token to your backend
        final tokenResponse = await dio.post(
          '$baseUrl/editFirebaseToken',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {'newFirebaseToken': firebaseToken},
        );

        print('Firebase Token Update Status: ${tokenResponse.statusCode}');
        print('Firebase Token Update Response: ${tokenResponse.data}');

        if (tokenResponse.statusCode == 200 ||
            tokenResponse.statusCode == 201) {
          print('Firebase token updated successfully');
        }
      } else {
        print('Failed to get Firebase token');
      }
    } on DioException catch (e) {
      print(
        'Error updating Firebase token: ${NetworkErrorHandler.handleError(e, context)}',
      );

      // Don't throw here as we don't want to fail the login process
      // if token update fails
    } catch (e) {
      print('Unexpected error updating Firebase token: $e');
      // Don't throw here as we don't want to fail the login process
    }
  }

  // Optional: Method to manually update Firebase token (useful for token refresh)
  Future<bool> updateFirebaseToken(BuildContext context) async {
    try {
      await _updateFirebaseToken(context);
      return true;
    } catch (e) {
      print('Failed to update Firebase token: $e');
      return false;
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        await _updateFirebaseToken(context);
      }
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
  //----------------------------from lolo

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

  Future<bool> addPC(Request pc) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching Info...");

      final response = await dio.post(
        '$baseUrl/guest-student/requestCourse/${pc.languageId}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: pc.toJson(),
      );

      print(",,,,,,,,,,,,,,,,,,,,,,,, ${response.data}");

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

  Future<bool> editPC(Request pc) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching Info...");

      final response = await dio.post(
        '$baseUrl/guest-student/updateIndividualRequest/${pc.id}',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: pc.toJson(),
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

  Future<bool> deletePC(int pcId) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching Info...");

      final response = await dio.delete(
        '$baseUrl/guest-student/deleteIndividualRequest/$pcId',
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

  //----------------------------------------------------------------------------------

  Future<PrivateCourseModel> getRequests() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching Info...");

      final response = await dio.get(
        '$baseUrl/guest-student/myRequestsForIndividualCourse',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print(",,,,,,,,,,,,,,,,,,,,,,, ${response.data}");

      if (response.statusCode == 200) {
        print("Response data: ${response.data}");
        return PrivateCourseModel.fromJson(response.data);
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

  Future<LanguagesHaveLibraryModel> getLanguagesHaveLibrary() async {
    try {
      final response = await dio.get('$baseUrl/getLanguagesThatHaveLibrary');

      if (response.statusCode == 200) {
        return LanguagesHaveLibraryModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load Languages');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //----------------------------------------------------------------------------------

  Future<LangFilesModel> getLangFiles(int languageId) async {
    try {
      final response = await dio.get('$baseUrl/getFilesByLanguage/$languageId');

      if (response.statusCode == 200) {
        return LangFilesModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load Languages');
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
  Future<List<FlashCards>> getLessonFlashcards(int lessonId) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching available courses...");

      final response = await dio.get(
        '$baseUrl/student/viewFlashCardsByLesson/$lessonId',
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

  Future<CourseFlashcardsModel> getCourseFlashcards(int courseId) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching available courses...");

      final response = await dio.get(
        '$baseUrl/teacher/viewCourseFlashCards/$courseId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final flashcardsModel = CourseFlashcardsModel.fromJson(response.data);
        return flashcardsModel;
      } else {
        throw Exception('Failed to load course flashcards');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }
  // ----------------------------------------------------------------------------

  Future<List<Data>> getTeacherComplaints() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching available courses...");

      final response = await dio.get(
        '$baseUrl/teacher/showTeacherOwnComplaints',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final myComplaintsModel = MyComplaintsModel.fromJson(response.data);
        return myComplaintsModel.data ?? [];
      } else {
        throw Exception('Failed to load Complaints');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  // ----------------------------------------------------------------------------

  Future<Response> SubmitComplaint({
    required String subject,

    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final formData = FormData.fromMap({'Subject': subject});

      final response = await dio.post(
        '$baseUrl/teacher/submitComplaint',
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
  Future<Response> deleteComplaint(String complaintId) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final response = await dio.get(
        '$baseUrl/teacher/deleteComplaint/$complaintId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to delete complaint');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }
  // ----------------------------------------------------------------------------

  Future<Response> EditComplaint({
    required String subject,
    required String complaintId,

    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final formData = FormData.fromMap({'Subject': subject});

      final response = await dio.post(
        '$baseUrl/teacher/editComplaint/$complaintId',
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

  Future<FinalTestModel?> getFinalTest(int courseId) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching final test...");
      print('$baseUrl/teacher/getFinalTest/$courseId');

      final response = await dio.get(
        '$baseUrl/teacher/getFinalTest/$courseId',
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
        final finalTestModel = FinalTestModel.fromJson(response.data);
        return finalTestModel;
      } else {
        throw Exception('Failed to load final test');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        print("No final test found for courseId: $courseId (404)");
        // No final test exists - return null instead of throwing
        return null;
      }
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //=======================================================================

  Future<TeacherFinalTestQuestionsModel?> getTeacherFinalTestQuestions(
    int testId,
  ) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching final test...");
      print('$baseUrl/teacher/viewFinalTestQuestions/$testId');

      final response = await dio.get(
        '$baseUrl/teacher/viewFinalTestQuestions/$testId',
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
        final finalTestQuestionsModel = TeacherFinalTestQuestionsModel.fromJson(
          response.data,
        );
        return finalTestQuestionsModel;
      } else {
        throw Exception('Failed to load final test');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        print("No final test questions found for test with id: $testId (404)");
        // No final test exists - return null instead of throwing
        return null;
      }
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //=======================================================================

  Future<Response> AddFinalTest({
    required int courseId,
    required String title,
    required double duration,
    required double mark,

    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final formData = FormData.fromMap({
        'CourseId': courseId,
        'Title': title,
        'Duration': duration,
        'Mark': mark,
      });

      final response = await dio.post(
        '$baseUrl/teacher/addFinalTest',
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

  //=======================================================================

  Future<Response> AddFinalTestQuestion({
    required int testId,
    File? media,
    required String questionText,
    required String type,
    List<String>? choices,
    required String correctAnswer,
    required double point,
    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final formData = FormData();

      formData.fields.addAll([
        MapEntry('TestId', testId.toString()),
        MapEntry('QuestionText', questionText),
        MapEntry('Type', type),
        MapEntry('CorrectAnswer', correctAnswer),
        MapEntry('Choices', jsonEncode(choices)),
        MapEntry('Point', point.toString()),
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
        '$baseUrl/teacher/addFinalTestQuestion',
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

  Future<TeacherScheduleModel> getTeacherSchedule(String date) async {
    try {
      print("inside the get schedule");

      final localStorage = LocalStorage();
      final token = await localStorage.getToken();

      final response = await dio.get(
        '$baseUrl/teacher/reviewSchedule?date=$date',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('$baseUrl/teacher/reviewSchedule?date=$date');
      print(response.data);
      if (response.statusCode == 200) {
        final data = TeacherScheduleModel.fromJson(response.data);
        return data;
      } else {
        throw Exception('Failed to load announcements');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //--------------------------------------------------------------------------

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

  Future<List<TeacherLessons>> getTeacherLessons(int courseId) async {
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
    debugPrint("Fetching my info...");

    final response = await dio.get(
      '$baseUrl/profile',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    if (response.statusCode == 200) {
      final data = response.data as Map<String, dynamic>;
      debugPrint("Response data: $data");

      // Parse user from "user"
      final userJson = (data['user'] as Map<String, dynamic>?) ?? <String, dynamic>{};
      final userModel = User.fromJson(userJson);

      // Attach "Other Info" (top-level)
      final otherInfoTop = data['Other Info'];
      if (otherInfoTop is Map<String, dynamic>) {
        userModel.otherInfo = OtherInfo.fromJson(otherInfoTop);
      }

      // Also handle "Other Info" if server sometimes nests it under user
      final otherInfoInsideUser = userJson['Other Info'];
      if (otherInfoInsideUser is Map<String, dynamic>) {
        userModel.otherInfo = OtherInfo.fromJson(otherInfoInsideUser);
      }

      // Normalize photo URL if present
      if (userModel.otherInfo?.photo != null) {
        userModel.otherInfo!.photo = _normalizePhotoUrl(userModel.otherInfo!.photo);
      }

      // If roles/permissions are top-level, map them (keep names)
      final rolesAny = data['roles'];
      if (userModel.role == null && rolesAny is List && rolesAny.isNotEmpty) {
        userModel.role = rolesAny.first.toString();
      }

      final permsAny = data['permissions'];
      if ((userModel.permissions == null || userModel.permissions!.isEmpty) && permsAny is List) {
        userModel.permissions = permsAny.map((e) => e.toString()).toList();
      }

      debugPrint("Photo after merge: ${userModel.otherInfo?.photo}");
      return userModel;
    } else {
      throw Exception('Failed to load info (status ${response.statusCode})');
    }
  } on DioException catch (e) {
    throw Exception('Dio error (${e.response?.statusCode}): ${e.response?.data ?? e.message}');
  } catch (e) {
    throw Exception('Unknown error: $e');
  }
}

/// Keep as helper; adjust only host/IP as needed. No name changes.
String? _normalizePhotoUrl(String? raw) {
  if (raw == null || raw.trim().isEmpty) return null;
  final u = raw.trim();

  // Android emulator: localhost -> 10.0.2.2
  if (u.startsWith('http://localhost')) {
    return u.replaceFirst('http://localhost', 'http://10.0.2.2');
    // On a real device, replace with your PC LAN IP instead:
    // return u.replaceFirst('http://localhost', 'http://192.168.1.10');
  }

  // If backend returns a relative path like /storage/...
  if (u.startsWith('/')) {
    return 'http://10.0.2.2:8000$u'; // change to your backend host/port if needed
  }

  return u;
}

//==========================================================================
Future<OtherInfo> editMyInfo({
  String? description,
  String? photoFilePath,
}) async {
  final localStorage = LocalStorage();
  final token = await localStorage.getToken();

  final form = <String, dynamic>{};
  if (description != null) form['Description'] = description;
  if (photoFilePath != null && photoFilePath.isNotEmpty) {
    form['Photo'] = await MultipartFile.fromFile(
      photoFilePath,
      filename: photoFilePath.split('/').last,
    );
  }

  final response = await dio.post(
    '$baseUrl/staff/editMyInfo',
    data: FormData.fromMap(form),
    options: Options(
      headers: {'Authorization': 'Bearer $token'},
      validateStatus: (code) => code != null && code >= 200 && code < 300,
    ),
  );

  final body = response.data as Map<String, dynamic>;
  final data = body['data'] as Map<String, dynamic>;
  final info = OtherInfo.fromJson(data);
  // optional: normalize photo for emulator
  info.photo = _normalizePhotoUrl(info.photo);
  return info;
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

   Future<HolidaysModel> getHolidays() async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching holidays...");

      final response = await dio.get(
        '$baseUrl/getHoliday',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        print("Response data: ${response.data}");
        return HolidaysModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load holidays');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }


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
  
  // ----------------------------------------------------------------------------
  //------------------Student Final Test-----------------------------------------
  Future<Response> submitFinalTestAnswer({
    required String testId,
    required String questionId,
    required String answer,
    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("submitting question...");
      print(testId + "          " + questionId + "          " + answer);
      final response = await dio.post(
        '$baseUrl/student/submitFinalTestAnswer',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {'TestId': testId, 'QuestionId': questionId, 'Answer': answer},
      );
      print(response);
      return response;
    } on DioException catch (e) {
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  //-----------------------------------------------------------------------------
  Future<StuFinalTestResaultModel> submitFinalTestResult({
    required String testId,
    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("getting the result...");
      final response = await dio.post(
        '$baseUrl/student/submitFinalTest',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {'TestId': testId},
      );
      print(response);
      if (response.statusCode == 200) {
        final result = StuFinalTestResaultModel.fromJson(response.data);
        return result;
      } else {
        throw Exception('Failed to submit final test');
      }
    } on DioException catch (e) {
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  //-----------------------------------------------------------------------------
  Future<Response> requestCertificate({
    required String courseId,
    required BuildContext context,
  }) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Recuesting Certificate...");
      final response = await dio.post(
        '$baseUrl/student/requestCertificate',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
        data: {'course_id': courseId},
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception('Failed to submit final test');
      }
    } on DioException catch (e) {
      throw NetworkErrorHandler.handleError(e, context);
    } catch (e) {
      throw NetworkException('An unexpected error occurred.');
    }
  }

  //-----------------------------------------------------------------------------
  Future<CertificateModel> viewCertificate(
    int courseId,
    BuildContext context,
  ) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("getting certificate details ...");
      requestCertificate(courseId: courseId.toString(), context: context);

      final response = await dio.get(
        '$baseUrl/student/viewCertificate/$courseId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final certificate = CertificateModel.fromJson(response.data);
        print("Certificate loaded successfully");
        return certificate;
      } else {
        throw Exception('Failed to load certificate');
      }
    } catch (e) {
      rethrow;
    }
  }

  //-----------------------------------------------------------------------------

  Future<AllFinalTestQuestionsModel> getAllFinalTestQuestions(
    int testId,
  ) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching question...");

      final response = await dio.get(
        '$baseUrl/student/getAllFinalTestQuestions/$testId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final allFinalTestQuestionModel = AllFinalTestQuestionsModel.fromJson(
          response.data,
        );
        print(
          "modzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz",
        );
        print(response);
        return allFinalTestQuestionModel;
      } else {
        throw Exception('Failed to load question');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

  //-----------------------------------------------------------------------------

  Future<StuGetFinalTestModel> stuGetFinalTest(int courseId) async {
    try {
      final localStorage = LocalStorage();
      final token = await localStorage.getToken();
      print("User token: $token");
      print("Fetching final test for course $courseId ...");

      final response = await dio.get(
        '$baseUrl/student/getFinalTest/$courseId',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final stuFinalTest = StuGetFinalTestModel.fromJson(response.data);
        return stuFinalTest;
      } else {
        throw Exception('Failed to load question');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      throw Exception('Unknown error: $e');
    }
  }

}

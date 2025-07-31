import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/networking/api_service.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/student_features/notes/data/models/note_model.dart';
import 'package:lmc_app/features/student_features/notes/logic/cubit/note_cubit.dart';
import 'package:lmc_app/features/student_features/notes/logic/cubit/note_state.dart';
import 'package:lmc_app/features/student_features/notes/logic/usecases/add_note_usecase.dart';
import 'package:lmc_app/features/student_features/notes/logic/usecases/delete_note_usecase.dart';
import 'package:lmc_app/features/student_features/notes/logic/usecases/edit_note_usecase.dart';
import 'package:lmc_app/features/student_features/notes/logic/usecases/get_note_usecase.dart';
import 'package:lmc_app/features/student_features/notes/ui/widgets/notes_input.dart';
import 'package:lmc_app/features/student_features/notes/ui/widgets/notes_list.dart';
import 'package:lmc_app/features/student_features/notes/ui/widgets/to_do_input.dart';
import 'package:lmc_app/features/student_features/notes/ui/widgets/to_do_list.dart';

class MyNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotesCubit(
        getNotesUsecases: GetNotesUsecase(ApiService()),
        addNoteUsecase: AddNoteUsecase(ApiService()),
        deleteNoteUsecase: DeleteNoteUsecase(ApiService()),
        updateNoteUsecase: UpdateNoteUsecase(ApiService())
      )..fetchNotes(),
      child: const MyNotesView(),
    );
  }
}

class MyNotesView extends StatefulWidget {
  const MyNotesView({super.key});

  @override
  State<MyNotesView> createState() => _MyNotesViewState();
}

class _MyNotesViewState extends State<MyNotesView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> todos = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void addNote(String content) {
    final note = Notes(content: content, studentId: 1); // Replace with real studentId
    context.read<NotesCubit>().addNote(note);
  }

  void addTodo(String task) {
    setState(() => todos.add({'task': task, 'done': false}));
  }

  void toggleTodoDone(int index) {
    setState(() => todos[index]['done'] = !todos[index]['done']);
  }

  void deleteTodo(int index) {
    setState(() => todos.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('My Notes', style: TextStyle(color: AppColors.backgroundColor)),
        backgroundColor: AppColors.lmcBlue,
        bottom: TabBar(
          controller: _tabController,
          unselectedLabelColor: AppColors.lightLmcBlue,
          labelColor: AppColors.lmcOrange,
          tabs: const [Tab(text: 'Notes'), Tab(text: 'To-Do List')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                NotesInput(onAdd: addNote),
                const SizedBox(height: 12),
                Expanded(
                  child: BlocBuilder<NotesCubit, NotesState>(
                    builder: (context, state) {
                      final cubit = context.read<NotesCubit>();

                      if (state is NotesLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is NotesSuccess) {
                        return NotesList(notes: state.notes, notesCubit: cubit,);
                      } else if (state is NotesFailure) {
                        return Center(child: Text('Error: ${state.error}'));
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TodoInput(onAdd: addTodo),
                const SizedBox(height: 12),
                Expanded(
                  child: TodoList(
                    todos: todos,
                    onToggle: toggleTodoDone,
                    onDelete: deleteTodo,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/logic/cubit/languages_have_library_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/logic/cubit/languages_have_library_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/ui/widgets/languages_have_library_outside.dart';

class LanguagesHaveLibraryList extends StatefulWidget {
  const LanguagesHaveLibraryList({super.key});

  @override
  State<LanguagesHaveLibraryList> createState() => _LanguagesHaveLibraryListState();
}

class _LanguagesHaveLibraryListState extends State<LanguagesHaveLibraryList> {
  @override
  void initState() {
    super.initState();
    // Fetch once when the widget is inserted into the tree
    context.read<LanguagesHaveLibraryCubit>().fetchLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguagesHaveLibraryCubit, LanguagesHaveLibraryState>(
      builder: (context, state) {
        if (state is LanguagesHaveLibraryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LanguagesHaveLibraryFailure) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is LanguagesHaveLibrarySuccess) {
          // SUCCESS: extract the list from the model
          // Assumes state.languagesHaveLibrary is a LanguagesHaveLibraryModel
          final languages = state.languagesHaveLibrary.data ?? [];

          if (languages.isEmpty) {
            return const Center(child: Text('No languages found.'));
          }

          final isOdd = languages.length.isOdd;
          final itemCount = languages.length ~/ 2 + (isOdd ? 1 : 0);

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final firstIndex = index * 2;
              final secondIndex = firstIndex + 1;

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LanguagesHaveLibraryOutside(
                      languagesHaveLibrary: languages[firstIndex],
                    ),
                    const SizedBox(width: 20),
                    if (secondIndex < languages.length)
                      LanguagesHaveLibraryOutside(
                        languagesHaveLibrary: languages[secondIndex],
                      )
                    else
                      const SizedBox(width: 150), // maintain alignment for odd item
                  ],
                ),
              );
            },
          );
        }

        return const Center(child: Text('No languages found.'));
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/ui/widgets/lang_files_list.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/languages_have_library/data/languages_have_library_model.dart';

class LangFilesScreen extends StatelessWidget{
  final LanguagesHaveLibrary languagesHaveLibrary;

  const LangFilesScreen({super.key, required this.languagesHaveLibrary}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      appBar: AppBar(
        backgroundColor: AppColors.background2,
        elevation: 0,
        title: Text(
          '${languagesHaveLibrary.name} Files',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LangFilesList(languageId: languagesHaveLibrary.id!),
    );
  }
}
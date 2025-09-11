import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/data/private_course_model.dart' as pc;
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/cubit/private_course_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/private_course/logic/cubit/private_course_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/languages/logic/cubit/language_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/languages/logic/cubit/language_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/languages/data/model/language_model.dart' as langs;

class PrivateCourseScreen extends StatefulWidget {
  const PrivateCourseScreen({Key? key}) : super(key: key);

  @override
  State<PrivateCourseScreen> createState() => _PrivateCourseScreenState();
}

class _PrivateCourseScreenState extends State<PrivateCourseScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PrivateCourseCubit>().fetchPC();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFAB(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Private Course Requests', style: TextStyle(fontWeight: FontWeight.w600)),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton.extended(
      onPressed: () => _showAddEditDialog(context),
      backgroundColor: Theme.of(context).primaryColor,
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text('Add Request', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<PrivateCourseCubit, PrivateCourseState>(
      builder: (context, state) => switch (state) {
        PrivateCourseLoading() => const Center(child: CircularProgressIndicator()),
        PrivateCourseSuccess() => _buildSuccessView(state.pc),
        PrivateCourseFailure() => _buildErrorView(state.error),
        _ => _buildWelcomeView(),
      },
    );
  }

  Widget _buildWelcomeView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text('Welcome to Private Courses', 
            style: TextStyle(fontSize: 18, color: Colors.grey[600], fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSuccessView(List<pc.Request> requests) {
    if (requests.isEmpty) return _buildEmptyView();
    
    return RefreshIndicator(
      onRefresh: () => context.read<PrivateCourseCubit>().fetchPC(),
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: requests.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) => _buildRequestCard(requests[index]),
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text('No requests yet', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
          const SizedBox(height: 8),
          Text('Tap the + button to create your first request', style: TextStyle(color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _buildErrorView(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text('Something went wrong', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
          const SizedBox(height: 8),
          Text(error, style: TextStyle(color: Colors.grey[500]), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildRequestCard(pc.Request request) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(20),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Icon(Icons.language, color: Theme.of(context).primaryColor),
        ),
        title: Text(request.language?.name ?? 'Unknown', 
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(request.description ?? 'No description', 
            style: TextStyle(color: Colors.grey[600], height: 1.4)),
        ),
        trailing: _buildMenuButton(request),
      ),
    );
  }

  Widget _buildMenuButton(pc.Request request) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: Colors.grey[600]),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (value) => switch (value) {
        'edit' => _showAddEditDialog(context, request: request),
        'delete' => _showDeleteDialog(context, request),
        _ => null,
      },
      itemBuilder: (_) => [
        const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit), SizedBox(width: 12), Text('Edit')])),
        const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete), SizedBox(width: 12), Text('Delete')])),
      ],
    );
  }

  void _showAddEditDialog(BuildContext context, {pc.Request? request}) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<LanguageCubit>(),
        child: AddEditDialog(request: request, onSave: (newRequest) {
          final cubit = context.read<PrivateCourseCubit>();
          request == null ? cubit.addPC(newRequest) : cubit.editPC(newRequest);
        }),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, pc.Request request) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Request'),
        content: Text('Are you sure you want to delete "${request.language?.name}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<PrivateCourseCubit>().deletePC(request.id!);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class AddEditDialog extends StatefulWidget {
  final pc.Request? request;
  final Function(pc.Request) onSave;

  const AddEditDialog({Key? key, this.request, required this.onSave}) : super(key: key);

  @override
  State<AddEditDialog> createState() => _AddEditDialogState();
}

class _AddEditDialogState extends State<AddEditDialog> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  String? _selectedLanguageId;

  @override
  void initState() {
    super.initState();
    if (widget.request != null) {
      _descriptionController.text = widget.request!.description ?? '';
      _selectedLanguageId = widget.request!.languageId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(widget.request == null ? 'Add New Request' : 'Edit Request'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageDropdown(),
            const SizedBox(height: 20),
            _buildDescriptionField(),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(onPressed: _saveRequest, child: Text(widget.request == null ? 'Add' : 'Save')),
      ],
    );
  }

  Widget _buildLanguageDropdown() {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) => switch (state) {
        LanguageLoading() => const LinearProgressIndicator(),
        LanguageFailure() => Text('Error: ${state.error}', style: const TextStyle(color: Colors.red)),
        LanguageSuccess() => DropdownButtonFormField<String>(
          value: _selectedLanguageId,
          decoration: InputDecoration(
            labelText: 'Language',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.language),
          ),
          items: (state.language.data ?? [])
              .map((l) => DropdownMenuItem(value: l.id?.toString(), child: Text(l.name ?? 'Unknown')))
              .toList(),
          onChanged: (val) => setState(() => _selectedLanguageId = val),
          validator: (val) => val == null ? 'Please select a language' : null,
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: const Icon(Icons.description),
      ),
      maxLines: 4,
      validator: (v) => v?.trim().isEmpty == true ? 'Description is required' : null,
    );
  }

  void _saveRequest() {
    if (!_formKey.currentState!.validate()) return;

    final langState = context.read<LanguageCubit>().state as LanguageSuccess;
    final selected = langState.language.data!.firstWhere((l) => l.id?.toString() == _selectedLanguageId);

    final newRequest = pc.Request(
      id: widget.request?.id,
      languageId: _selectedLanguageId,
      description: _descriptionController.text.trim(),
      language: pc.Language(
        id: selected.id,
        name: selected.name,
        description: selected.description,
        createdAt: selected.createdAt,
        updatedAt: selected.updatedAt,
      ),
      status: widget.request?.status ?? 'pending',
      createdAt: widget.request?.createdAt ?? DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    widget.onSave(newRequest);
    Navigator.pop(context);
  }
}
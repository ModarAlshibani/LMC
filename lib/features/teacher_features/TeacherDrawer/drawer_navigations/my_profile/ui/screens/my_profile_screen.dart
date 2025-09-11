import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart'; // for picking a new photo (optional)
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/cubit/my_profile_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/my_profile/logic/cubit/my_profile_state.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _descCtrl = TextEditingController();
  String? _pickedPhotoPath;

  @override
  void dispose() {
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lmcBlue,
      body: BlocBuilder<MyProfileCubit, MyProfileState>(
        builder: (context, state) {
          if (state is MyProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          }

          if (state is MyProfileFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.white, size: 64),
                    const SizedBox(height: 16),
                    const Text(
                      'Something went wrong',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.error,
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () => context.read<MyProfileCubit>().fetchMyInfo(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lmcOrange,
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is MyProfileSuccess) {
            final info = state.myInfo;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 280,
                  pinned: true,
                  backgroundColor: AppColors.lmcBlue,
                  elevation: 0,
                  actions: [
                    IconButton(
                      tooltip: 'Edit profile',
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () => _openEditSheet(context,
                          initialDescription: info.otherInfo?.description ?? ''),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.lmcBlue, AppColors.lmcBlue.withOpacity(0.85)],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40),

                          // ===== Profile Avatar (photo or fallback) =====
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 18,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: _ProfileAvatar(
                                name: info.name,
                                rawPhotoUrl: info.otherInfo?.photo, // exact path from your model
                                useEmulatorHost: true, // set false + LAN IP inside widget for real device
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Name
                          Text(
                            info.name ?? 'User Name',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Email
                          Text(
                            info.email ?? 'user@example.com',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ===== Details =====
                SliverToBoxAdapter(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Profile Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),

                          _infoCard(
                            icon: Icons.person_outline,
                            title: 'Full Name',
                            value: info.name ?? 'Not specified',
                          ),
                          _infoCard(
                            icon: Icons.email_outlined,
                            title: 'Email Address',
                            value: info.email ?? 'Not specified',
                          ),

                          if (info.otherInfo?.description != null &&
                              info.otherInfo!.description!.trim().isNotEmpty)
                            _infoCard(
                              icon: Icons.description_outlined,
                              title: 'Description',
                              value: info.otherInfo!.description!,
                            ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: Text('No profile data available', style: TextStyle(color: Colors.white, fontSize: 16)),
          );
        },
      ),
    );
  }

  // ================== Edit Bottom Sheet ==================

  Future<void> _openEditSheet(BuildContext context, {required String initialDescription}) async {
    _descCtrl.text = initialDescription;
    _pickedPhotoPath = null;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 16,
            bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (ctx, setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 36,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  TextField(
                    controller: _descCtrl,
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: "Tell us about yourself",
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Photo picker
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final picker = ImagePicker();
                          final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
                          if (picked != null) {
                            setModalState(() => _pickedPhotoPath = picked.path);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.lmcOrange,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.photo_library_outlined),
                        label: const Text('Choose Photo'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _pickedPhotoPath == null ? 'No file selected' : File(_pickedPhotoPath!).path.split('/').last,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            // Call Cubit to edit (keeps your API names: "Description" & "Photo")
                            await context.read<MyProfileCubit>().editMyInfo(
                                  description: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
                                  photoFilePath: _pickedPhotoPath, // nullable
                                );
                            if (mounted) Navigator.of(ctx).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.lmcOrange,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Save'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              );
            },
          ),
        );
      },
    );
  }

  // ================== Reused pieces ==================

  static Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lmcOrange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.lmcOrange, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    )),
                const SizedBox(height: 4),
                Text(value,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Separate widget to load/normalize the photo and fallback gracefully.
class _ProfileAvatar extends StatelessWidget {
  final String? name;
  final String? rawPhotoUrl;
  final double size;
  final bool useEmulatorHost; // true = 10.0.2.2; false = LAN IP for real device

  const _ProfileAvatar({
    required this.name,
    required this.rawPhotoUrl,
    this.size = 120,
    this.useEmulatorHost = true,
  });

  @override
  Widget build(BuildContext context) {
    final normalized = _normalizePhotoUrl(rawPhotoUrl, useEmulatorHost: useEmulatorHost);

    if (normalized == null || normalized.isEmpty) {
      return _fallbackAvatar(name);
    }

    return Image.network(
      normalized,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (ctx, err, st) {
        debugPrint('Profile photo error: $err');
        return _fallbackAvatar(name);
      },
      loadingBuilder: (ctx, child, progress) {
        if (progress == null) return child;
        return Container(
          color: Colors.white,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  static Widget _fallbackAvatar(String? name) {
    return Container(
      color: Colors.white,
      child: Center(
        child: (name != null && name.isNotEmpty)
            ? Text(
                name.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              )
            : const Icon(Icons.person, size: 60, color: Colors.orange),
      ),
    );
  }

  /// Normalizes URLs so the emulator/phone can reach your backend.
  /// - Android emulator: 'http://localhost' -> 'http://10.0.2.2'
  /// - Real device: set your PC's LAN IP (e.g., http://192.168.1.10)
  static String? _normalizePhotoUrl(String? raw, {required bool useEmulatorHost}) {
    if (raw == null) return null;
    final trimmed = raw.trim();
    if (trimmed.isEmpty) return null;

    if (trimmed.startsWith('/')) {
      return useEmulatorHost
          ? 'http://10.0.2.2:8000$trimmed'
          : 'http://192.168.1.10:8000$trimmed'; // TODO: put your LAN IP
    }

    if (trimmed.startsWith('http://localhost')) {
      return useEmulatorHost
          ? trimmed.replaceFirst('http://localhost', 'http://10.0.2.2')
          : trimmed.replaceFirst('http://localhost', 'http://192.168.1.10'); // TODO: your LAN IP
    }

    return trimmed;
  }
}

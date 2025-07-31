import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:video_player/video_player.dart';

class UploadMedia extends StatefulWidget {
  final Function(PlatformFile) onMediaSelected;

  const UploadMedia({super.key, required this.onMediaSelected});

  @override
  State<UploadMedia> createState() => _UploadMediaState();
}

class _UploadMediaState extends State<UploadMedia> {
  PlatformFile? selectedFile;
  VideoPlayerController? _videoController;

  Future<void> _pickMedia(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'mp4', 'mp3', 'wav'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      setState(() => selectedFile = file);
      widget.onMediaSelected(file);

      if (file.extension == 'mp4' && file.path != null) {
        _videoController?.dispose();
        _videoController = VideoPlayerController.file(File(file.path!))
          ..initialize().then((_) {
            setState(() {});
            _videoController?.setLooping(true);
            _videoController?.play();
          });
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("✨ Media selected: ${file.name}")));
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickMedia(context),
      child: Container(
        height: 180.h,
        width: double.infinity,
        padding: EdgeInsets.all(12.h),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColors.lmcBlue, width: 1.5),
        ),
        child:
            selectedFile == null
                ? _buildUploadPrompt()
                : _buildMediaPreview(selectedFile!),
      ),
    );
  }

  Widget _buildUploadPrompt() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Iconsax.document_upload, size: 36.sp, color: AppColors.lmcBlue),
        SizedBox(height: 8.h),
        Text(
          'Upload Media',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.lmcBlue,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Image, Video, or Audio',
          style: TextStyle(fontSize: 12.sp, color: AppColors.greyBorder),
        ),
      ],
    );
  }

  Widget _buildMediaPreview(PlatformFile file) {
    if (file.extension == 'jpg' || file.extension == 'png') { 
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.file(File(file.path!), fit: BoxFit.cover),
      );
    } else if (file.extension == 'mp4' &&
        _videoController?.value.isInitialized == true) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: VideoPlayer(_videoController!),
        ),
      );
    } else {
      return Row(
        children: [
          Icon(
            file.extension == 'mp3' || file.extension == 'wav'
                ? Iconsax.music
                : Iconsax.video_play,
            size: 30.sp,
            color: AppColors.lmcOrange,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              file.name,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.lmcBlue,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }
  }
}

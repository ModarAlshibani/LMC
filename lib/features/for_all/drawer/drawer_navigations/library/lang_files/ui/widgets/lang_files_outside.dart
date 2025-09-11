import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class LangFilesOutside extends StatelessWidget {
  const LangFilesOutside({
    super.key,
    this.name,
    this.description,
    this.url,
    this.onOpen,        
    this.onDownload,    
  });

  final String? name;
  final String? description;
  final String? url;

  final VoidCallback? onOpen;     
  final VoidCallback? onDownload; 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: GlassContainer(
          withBorder: false,
          width: double.infinity,
          height: 140.h,
          topLeft: 10,
          topRight: 10,
          bottomRight: 10,
          bottomLeft: 10,
          firstColor: AppColors.lmcBlue,
          secondColor: AppColors.lmcBlue,
          firstBlurOpacity: 0.3,
          secondBlurOpacity: 0.25,
          sigmaX: 100,
          sigmaY: 100,
          child: Row(
            children: [
              horizontalSpace(10.w),
              horizontalSpace(20.w),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      child: Text(
                        (name ?? 'Untitled'),
                        style: const TextStyle(
                          color: AppColors.lmcBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Text(
                        (description ?? ''),
                        style: const TextStyle(
                          color: AppColors.lmcBlue,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
              horizontalSpace(10.w),
              IconButton(
                onPressed: () async {
                  if (url != null && url!.isNotEmpty) {
                    final tempDir = await getTemporaryDirectory();
                    final filePath = '${tempDir.path}/${name ?? 'file'}';
                    final response = await http.get(Uri.parse(url!));
                    final file = File(filePath);
                    await file.writeAsBytes(response.bodyBytes);
                    await OpenFilex.open(file.path);
                  }
                },                
                icon: const Icon(Icons.remove_red_eye_outlined),
              ),
              IconButton(
                tooltip: 'Download',
                onPressed: onDownload,                  
                icon: const Icon(Icons.download),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

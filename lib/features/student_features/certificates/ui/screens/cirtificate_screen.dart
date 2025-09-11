import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:lmc_app/core/helpers/states_widgets.dart';
import 'package:lmc_app/features/student_features/certificates/ui/widgets/certificate_action_button.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/core/widgets/glass_card.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/features/student_features/certificates/logic/cubit/view_certificate_cubit.dart';
import 'package:lmc_app/features/student_features/certificates/logic/cubit/view_certificate_state.dart';
import 'package:lmc_app/features/student_features/certificates/data/certificate_model.dart';

class CertificateScreen extends StatefulWidget {
  final int courseId;

  const CertificateScreen({super.key, required this.courseId});

  @override
  State<CertificateScreen> createState() => _CertificateScreenState();
}

class _CertificateScreenState extends State<CertificateScreen> {
  final GlobalKey _certificateKey =
      GlobalKey(); // Key for capturing certificate

  @override
  void initState() {
    super.initState();
    context.read<ViewCertificateCubit>().fetchViewCertificate(
      widget.courseId,
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background2,
      appBar: _buildAppBar(),
      body: BlocBuilder<ViewCertificateCubit, ViewCertificateState>(
        builder: (context, state) {
          if (state is ViewCertificateLoading) {
            return StateWidgets.buildLoadingState(
              message: 'Loading Certificate...',
              primaryColor: AppColors.lmcBlue,
              accentColor: AppColors.lmcOrange,
            );
          } else if (state is ViewCertificateSuccess) {
            return _CertificateContent(
              certificateModel: state.certificateModel,
              certificateKey: _certificateKey,
            );
          } else if (state is ViewCertificateFailure) {
            return StateWidgets.buildErrorState(
              title: 'Failed to Load Certificate',
              subtitle:
                  state.message ??
                  state.error, // Show message first, fallback to error
              icon: Iconsax.warning_2_copy,
              onRetry:
                  () => context
                      .read<ViewCertificateCubit>()
                      .fetchViewCertificate(widget.courseId, context),
              retryButtonText: 'Retry',
            );
          }
          return StateWidgets.buildLoadingState(
            message: 'Initializing...',
            primaryColor: AppColors.lmcBlue,
            accentColor: AppColors.lmcOrange,
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background2,
      elevation: 0,
      title: Text(
        'Certificate',
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black87),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}

class _CertificateContent extends StatelessWidget {
  final CertificateModel certificateModel;
  final GlobalKey certificateKey;

  const _CertificateContent({
    required this.certificateModel,
    required this.certificateKey,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _CertificateCard(
            certificateModel: certificateModel,
            certificateKey: certificateKey,
          ),
          verticalSpace(24),
          _ActionButtonsSection(
            certificateModel: certificateModel,
            certificateKey: certificateKey,
          ),
          verticalSpace(40),
        ],
      ),
    );
  }
}

class _CertificateCard extends StatelessWidget {
  final CertificateModel certificateModel;
  final GlobalKey certificateKey;

  const _CertificateCard({
    required this.certificateModel,
    required this.certificateKey,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: certificateKey, // Wrap with RepaintBoundary for screenshot
      child: GlassContainer(
        withBorder: true,
        width: double.infinity,
        topLeft: 20.r,
        topRight: 20.r,
        bottomRight: 20.r,
        bottomLeft: 20.r,
        firstColor: Colors.white.withOpacity(0.9),
        secondColor: Colors.white.withOpacity(0.8),
        firstBlurOpacity: 0.8,
        secondBlurOpacity: 0.5,
        sigmaX: 80,
        sigmaY: 80,
        height: 600.h,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: AppColors.lmcBlue.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(30.w),
            child: Column(
              children: [
                _CertificateHeader(),
                verticalSpace(10),
                _StudentNameSection(name: certificateModel.name),
                verticalSpace(10),
                _CourseCompletionText(),
                verticalSpace(10),
                _CourseDetailsCard(certificateModel: certificateModel),
                verticalSpace(10),
                _SignatureSection(
                  teacherName: certificateModel.teacherName,
                  date: DateTime.now().toString().split(' ')[0],
                ),
                if (certificateModel.certificateToken != null) ...[
                  verticalSpace(20),
                  _CertificateTokenChip(
                    token: certificateModel.certificateToken!,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CertificateHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.lmcBlue.withOpacity(0.8),
                AppColors.lmcBlue.withOpacity(0.6),
              ],
            ),
            borderRadius: BorderRadius.circular(50.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.lmcBlue.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Iconsax.award_copy,
            size: 40.w,
            color: AppColors.background2,
          ),
        ),
        verticalSpace(16),
        Text(
          'CERTIFICATE OF COMPLETION',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.lmcBlue,
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _StudentNameSection extends StatelessWidget {
  final String? name;

  const _StudentNameSection({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 2.h,
          width: 80.w,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.lmcBlue.withOpacity(0.3),
                AppColors.lmcBlue,
                AppColors.lmcBlue.withOpacity(0.3),
              ],
            ),
          ),
        ),
        verticalSpace(20),
        Text(
          'This is to certify that',
          style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
        ),
        verticalSpace(8),
        Text(
          name ?? 'Student Name',
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.lmcBlue,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _CourseCompletionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'has successfully completed the course',
      style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
      textAlign: TextAlign.center,
    );
  }
}

class _CourseDetailsCard extends StatelessWidget {
  final CertificateModel certificateModel;

  const _CourseDetailsCard({required this.certificateModel});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      withBorder: true,
      width: double.infinity,
      topLeft: 12.r,
      topRight: 12.r,
      bottomRight: 12.r,
      bottomLeft: 12.r,
      firstColor: AppColors.lightLmcBlue.withOpacity(0.1),
      secondColor: AppColors.lightLmcBlue.withOpacity(0.05),
      firstBlurOpacity: 0.8,
      secondBlurOpacity: 0.5,
      sigmaX: 80,
      sigmaY: 80,
      height: 160.h,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            if (certificateModel.courseLanguage != null)
              _DetailRow(
                icon: Iconsax.language_square_copy,
                label: 'Language',
                value: certificateModel.courseLanguage!,
              ),
            if (certificateModel.courseLevel != null) ...[
              verticalSpace(12),
              _DetailRow(
                icon: Iconsax.level_copy,
                label: 'Level',
                value: certificateModel.courseLevel!,
              ),
            ],
            if (certificateModel.grade != null) ...[
              verticalSpace(12),
              _DetailRow(
                icon: Iconsax.star_1_copy,
                label: 'Grade',
                value: '${certificateModel.grade}%',
                isGrade: true,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isGrade;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isGrade = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.lmcBlue.withOpacity(0.8),
                AppColors.lmcBlue.withOpacity(0.6),
              ],
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: AppColors.background2, size: 16.w),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isGrade ? AppColors.lmcBlue : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SignatureSection extends StatelessWidget {
  final String? teacherName;
  final String date;

  const _SignatureSection({required this.teacherName, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Container(height: 1.h, color: Colors.grey[400]),
              verticalSpace(8),
              Text(
                teacherName ?? 'Instructor',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Instructor',
                style: TextStyle(fontSize: 10.sp, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
        SizedBox(width: 40.w),
        Expanded(
          child: Column(
            children: [
              Container(height: 1.h, color: Colors.grey[400]),
              verticalSpace(8),
              Text(
                date,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                'Date',
                style: TextStyle(fontSize: 10.sp, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CertificateTokenChip extends StatelessWidget {
  final String token;

  const _CertificateTokenChip({required this.token});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        'Certificate ID: $token',
        style: TextStyle(
          fontSize: 10.sp,
          color: Colors.grey[600],
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class _ActionButtonsSection extends StatelessWidget {
  final CertificateModel certificateModel;
  final GlobalKey certificateKey;

  const _ActionButtonsSection({
    required this.certificateModel,
    required this.certificateKey,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions:',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.lmcBlue,
          ),
        ),
        verticalSpace(16),
        CertificateActionButton(
          icon: Iconsax.document_download_copy,
          title: 'Download PDF',
          subtitle: 'Save certificate as PDF document',
          onTap: () => _downloadCertificatePDF(context, certificateModel),
        ),
        verticalSpace(16),
        CertificateActionButton(
          icon: Iconsax.send_2_copy,
          title: 'Share to WhatsApp',
          subtitle: 'Share certificate image via WhatsApp',
          onTap:
              () => _shareToWhatsApp(context, certificateModel, certificateKey),
        ),
      ],
    );
  }

  Future<void> _downloadCertificatePDF(
    BuildContext context,
    CertificateModel certificate,
  ) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(width: 3, color: PdfColors.blue800),
              ),
              padding: const pw.EdgeInsets.all(40),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'CERTIFICATE OF COMPLETION',
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue800,
                    ),
                  ),
                  pw.SizedBox(height: 40),
                  pw.Container(height: 2, width: 100, color: PdfColors.blue800),
                  pw.SizedBox(height: 40),
                  pw.Text(
                    'This is to certify that',
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text(
                    certificate.name ?? 'Student Name',
                    style: pw.TextStyle(
                      fontSize: 32,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.blue900,
                    ),
                  ),
                  pw.SizedBox(height: 30),
                  pw.Text(
                    'has successfully completed the course',
                    style: pw.TextStyle(fontSize: 16),
                  ),
                  pw.SizedBox(height: 40),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(20),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.blue200),
                      borderRadius: pw.BorderRadius.circular(10),
                    ),
                    child: pw.Column(
                      children: [
                        if (certificate.courseLanguage != null)
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Language:',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text(certificate.courseLanguage!),
                            ],
                          ),
                        if (certificate.courseLevel != null) ...[
                          pw.SizedBox(height: 10),
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Level:',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text(certificate.courseLevel!),
                            ],
                          ),
                        ],
                        if (certificate.grade != null) ...[
                          pw.SizedBox(height: 10),
                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Text(
                                'Grade:',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.Text('${certificate.grade}%'),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 40),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        children: [
                          pw.Container(
                            height: 1,
                            width: 150,
                            color: PdfColors.grey,
                          ),
                          pw.SizedBox(height: 8),
                          pw.Text(certificate.teacherName ?? 'Instructor'),
                          pw.Text(
                            'Instructor',
                            style: pw.TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Container(
                            height: 1,
                            width: 150,
                            color: PdfColors.grey,
                          ),
                          pw.SizedBox(height: 8),
                          pw.Text(DateTime.now().toString().split(' ')[0]),
                          pw.Text('Date', style: pw.TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  if (certificate.certificateToken != null) ...[
                    pw.SizedBox(height: 30),
                    pw.Text(
                      'Certificate ID: ${certificate.certificateToken}',
                      style: pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      );

      // Get the Downloads directory or Documents directory
      Directory? directory;
      if (Platform.isAndroid) {
        // For Android, try to get the Downloads directory
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          // Fallback to external storage directory
          directory = await getExternalStorageDirectory();
        }
      } else {
        // For iOS, use the Documents directory
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory != null) {
        final fileName =
            'certificate_${certificate.name?.replaceAll(' ', '_') ?? 'student'}_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final file = File('${directory.path}/$fileName');
        await file.writeAsBytes(await pdf.save());

        // Show simple success message without the "Open" action
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Certificate downloaded successfully!'),
            backgroundColor: AppColors.lmcBlue,
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        throw Exception('Could not access storage directory');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading certificate: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _shareToWhatsApp(
    BuildContext context,
    CertificateModel certificate,
    GlobalKey certificateKey,
  ) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => Center(
              child: Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: AppColors.lmcBlue),
                    verticalSpace(16),
                    Text(
                      'Preparing certificate image...',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      );

      // Capture the certificate as an image
      final RenderRepaintBoundary boundary =
          certificateKey.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      // Increase pixel ratio for higher quality
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      final Uint8List uint8list = byteData!.buffer.asUint8List();

      // Save image to temporary directory
      final Directory tempDir = await getTemporaryDirectory();
      final String fileName =
          'certificate_${certificate.name?.replaceAll(' ', '_') ?? 'student'}_${DateTime.now().millisecondsSinceEpoch}.png';
      final File imageFile = File('${tempDir.path}/$fileName');
      await imageFile.writeAsBytes(uint8list);

      // Close loading dialog
      Navigator.of(context).pop();

      // Create a simple message to accompany the image
      final message = '''🎓 Certificate of Completion
${certificate.name ?? 'Student'} has successfully completed the course!

${certificate.courseLanguage != null ? '🌐 ${certificate.courseLanguage}' : ''}
${certificate.courseLevel != null ? '📈 ${certificate.courseLevel}' : ''}
${certificate.grade != null ? '⭐ Grade: ${certificate.grade}%' : ''}

#Certificate #Achievement''';

      // Share the image with WhatsApp
      final List<XFile> files = [XFile(imageFile.path)];

      await Share.shareXFiles(
        files,
        text: message,
        subject: 'Certificate of Completion',
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Certificate image shared successfully!'),
          backgroundColor: AppColors.lmcBlue,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Close loading dialog if still open
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sharing certificate: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}

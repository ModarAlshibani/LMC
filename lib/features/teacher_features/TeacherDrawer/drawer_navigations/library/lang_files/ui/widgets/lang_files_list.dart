import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

import 'package:lmc_app/core/networking/api_constants.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/logic/cubit/lang_files_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/logic/cubit/lang_files_state.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/library/lang_files/ui/widgets/lang_files_outside.dart';

/* -------------------- TOP-LEVEL TYPES/HELPERS -------------------- */

enum _FileType { image, video, audio, other }

_FileType _detectType(String? nameOrUrl) {
  final s = (nameOrUrl ?? '').toLowerCase();
  if (s.endsWith('.png') || s.endsWith('.jpg') || s.endsWith('.jpeg') ||
      s.endsWith('.webp') || s.endsWith('.gif')) return _FileType.image;
  if (s.endsWith('.mp4') || s.endsWith('.m4v') || s.endsWith('.mov')) return _FileType.video;
  if (s.endsWith('.mp3') || s.endsWith('.aac') || s.endsWith('.wav') || s.endsWith('.m4a')) {
    return _FileType.audio;
  }
  return _FileType.other;
}

Uri _safeUri(String raw) => Uri.tryParse(raw) ?? Uri.parse(Uri.encodeFull(raw));

Future<void> _openExternally(BuildContext context, String url) async {
  final uri = _safeUri(url);
  if (await canLaunchUrl(uri)) {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open file')),
      );
    }
  } else {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid URL')),
    );
  }
}

Future<void> _openAnyFile(BuildContext context, String url, String fileName) async {
  final t = _detectType(fileName.isNotEmpty ? fileName : url);

  if (t == _FileType.image) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => _ImageViewer(url: url)));
    return;
  }
  if (t == _FileType.video) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => _VideoPlayerScreen(url: url)));
    return;
  }
  // audio/pdf/docx/zip/etc → external app
  await _openExternally(context, url);
}

String _fmtBytes(int bytes) {
  const kb = 1024;
  const mb = kb * 1024;
  const gb = mb * 1024;
  if (bytes >= gb) return '${(bytes / gb).toStringAsFixed(2)} GB';
  if (bytes >= mb) return '${(bytes / mb).toStringAsFixed(2)} MB';
  if (bytes >= kb) return '${(bytes / kb).toStringAsFixed(0)} KB';
  return '$bytes B';
}

// Public Downloads on Android if available; else app dir.
Future<Directory> _resolveDownloadDir() async {
  if (Platform.isAndroid) {
    final downloads = Directory('/storage/emulated/0/Download');
    if (await downloads.exists()) return downloads;

    final ext = await getExternalStorageDirectory();
    if (ext != null) return ext;
  }
  return await getApplicationDocumentsDirectory();
}

Future<bool> _ensureStoragePermission() async {
  if (!Platform.isAndroid) return true;
  final status = await Permission.storage.request();
  return status.isGranted || status.isLimited;
}

class _DownloadController {
  final CancelToken cancelToken = CancelToken();
  final ValueNotifier<double> progress = ValueNotifier<double>(0); // 0..1
  final ValueNotifier<String> label = ValueNotifier<String>('Starting...');
  void dispose() {
    progress.dispose();
    label.dispose();
  }
}

/* -------------------- IMAGE / VIDEO VIEWERS -------------------- */

class _ImageViewer extends StatelessWidget {
  final String url;
  const _ImageViewer({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: Center(
        child: InteractiveViewer(
          child: Image.network(
            url,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Text(
              'Failed to load image',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoPlayerScreen extends StatefulWidget {
  final String url;
  const _VideoPlayerScreen({required this.url});

  @override
  State<_VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<_VideoPlayerScreen> {
  late final VideoPlayerController _controller;
  bool _ready = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      _controller = VideoPlayerController.networkUrl(
        Uri.tryParse(widget.url) ?? Uri.parse(Uri.encodeFull(widget.url)),
      );
      await _controller.initialize();
      _controller.setLooping(false);
      setState(() => _ready = true);
      _controller.play();
    } catch (e) {
      setState(() => _error = e.toString());
    }
  }

  @override
  void dispose() {
    if (_ready) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('Video')),
      body: Center(
        child: _error != null
            ? Text('Failed to play video\n$_error',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center)
            : !_ready
                ? const CircularProgressIndicator()
                : AspectRatio(
                    aspectRatio: _controller.value.aspectRatio == 0
                        ? 16 / 9
                        : _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        VideoPlayer(_controller),
                        VideoProgressIndicator(_controller, allowScrubbing: true),
                        Positioned(
                          bottom: 24,
                          child: IconButton(
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 36,
                            ),
                            onPressed: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

/* -------------------- WIDGET -------------------- */

class LangFilesList extends StatefulWidget {
  final int languageId;
  const LangFilesList({super.key, required this.languageId});

  @override
  State<LangFilesList> createState() => _LangFilesListState();
}

class _LangFilesListState extends State<LangFilesList> {
  @override
  void initState() {
    super.initState();
    context.read<LangFilesCubit>().fetchFiles(widget.languageId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LangFilesCubit, LangFilesState>(
      builder: (context, state) {
        if (state is LangFilesLoading || state is LangFilesInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is LangFilesFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }

        if (state is LangFilesSuccess) {
          final model = state.langFiles;                 // LangFilesModel
          final files = model.data ?? <dynamic>[];       // List<LangFiles>

          if (files.isEmpty) {
            return const Center(child: Text('No files found.'));
          }

          return ListView.builder(
            itemCount: files.length,
            itemBuilder: (context, index) {
              final item = files[index];
              final name = item.fileName ?? 'Untitled';
              final desc = item.description ?? '';
              final rawUrl = (item.url ?? '');
              final url = rawUrl.replaceAll('localhost', ApiConstants.ip);

              return LangFilesOutside(
                name: name,
                description: desc,
                url: url,
                onOpen: url.isEmpty ? null : () => _openAnyFile(context, url, name),
                onDownload: url.isEmpty ? null : () => _downloadWithProgress(
                  context,
                  url: url,
                  suggestedName: name,
                ),
              );
            },
          );
        }

        return const Center(child: Text('No files found.'));
      },
    );
  }

  /* -------------------- DOWNLOAD WITH PROGRESS -------------------- */

  Future<void> _downloadWithProgress(
    BuildContext context, {
    required String url,
    String? suggestedName,
  }) async {
    final allowed = await _ensureStoragePermission();
    if (!allowed) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Storage permission denied')),
        );
      }
      return;
    }

    final dir = await _resolveDownloadDir();
    final parsed = _safeUri(url);
    final fileName = (suggestedName?.trim().isNotEmpty ?? false)
        ? suggestedName!.trim()
        : (parsed.pathSegments.isNotEmpty
            ? parsed.pathSegments.last
            : 'file_${DateTime.now().millisecondsSinceEpoch}');
    final savePath = '${dir.path}/$fileName';

    final ctrl = _DownloadController();

    if (!mounted) return;

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Downloading...', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 12),
                ValueListenableBuilder<double>(
                  valueListenable: ctrl.progress,
                  builder: (_, p, __) => LinearProgressIndicator(value: p == 0 ? null : p),
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<String>(
                  valueListenable: ctrl.label,
                  builder: (_, text, __) => Text(text, style: const TextStyle(fontSize: 12)),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        if (!ctrl.cancelToken.isCancelled) {
                          ctrl.cancelToken.cancel('Cancelled by user');
                        }
                        Navigator.of(context).maybePop();
                      },
                      icon: const Icon(Icons.close),
                      label: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    try {
      final dio = Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(minutes: 5),
        sendTimeout: const Duration(seconds: 30),
        followRedirects: true,
        validateStatus: (code) => code != null && code >= 200 && code < 400,
        headers: {'Accept': '*/*'},
        responseType: ResponseType.bytes,
      ));

      int lastEmitMs = 0;
      await dio.download(
        url,
        savePath,
        cancelToken: ctrl.cancelToken,
        onReceiveProgress: (received, total) {
          final now = DateTime.now().millisecondsSinceEpoch;
          if (now - lastEmitMs < 66) return; // ~15fps
          lastEmitMs = now;

          if (total > 0) {
            final pct = received / total;
            ctrl.progress.value = pct;
            ctrl.label.value =
                '${_fmtBytes(received)} / ${_fmtBytes(total)}  (${(pct * 100).toStringAsFixed(0)}%)';
          } else {
            ctrl.progress.value = 0; // indeterminate
            ctrl.label.value = '${_fmtBytes(received)} downloaded';
          }
        },
      );

      if (!mounted) return;
      Navigator.of(context).maybePop();
      ctrl.dispose();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved to $savePath')),
      );

      final result = await OpenFilex.open(savePath);
      if (result.type != ResultType.done && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Saved, but cannot open: ${result.message}')),
        );
      }
    } on DioException catch (e) {
      if (mounted) {
        Navigator.of(context).maybePop();
        ctrl.dispose();
        final cancelled = CancelToken.isCancel(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(cancelled
                ? 'Download cancelled'
                : 'Download failed: ${e.message ?? e.toString()}'),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).maybePop();
        ctrl.dispose();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Download failed: $e')),
        );
      }
    }
  }
}

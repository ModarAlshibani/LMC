import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lmc_app/core/helpers/spacing.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'dart:async';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerWidget({
    Key? key,
    required this.audioUrl,
  }) : super(key: key);

  @override
  _AudioPlayerWidgetState createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  late AudioPlayer _player;
  
  // Player state
  bool _isPlaying = false;
  bool _isLoading = false;
  bool _isPrepared = false;
  bool _hasError = false;
  String? _errorMessage;
  
  // Audio progress
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  
  // Stream subscriptions
  StreamSubscription? _playerStateSubscription;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void dispose() {
    _cleanupPlayer();
    super.dispose();
  }

  void _initializePlayer() {
    _player = AudioPlayer();
    _setupListeners();
  }

  void _setupListeners() {
    _playerStateSubscription = _player.playerStateStream.listen(
      (state) {
        if (mounted) {
          setState(() {
            _isPlaying = state.playing;
            
            switch (state.processingState) {
              case ProcessingState.loading:
              case ProcessingState.buffering:
                _isLoading = true;
                break;
              case ProcessingState.ready:
                _isLoading = false;
                _isPrepared = true;
                _hasError = false;
                break;
              case ProcessingState.completed:
                _isPlaying = false;
                _position = Duration.zero;
                _player.seek(Duration.zero);
                break;
              case ProcessingState.idle:
                _isLoading = false;
                break;
            }
          });
        }
      },
      onError: (error) {
        if (mounted) {
          _handleError('Playback error: $error');
        }
      },
    );

    _durationSubscription = _player.durationStream.listen(
      (duration) {
        if (mounted && duration != null) {
          setState(() {
            _duration = duration;
          });
        }
      },
    );

    _positionSubscription = _player.positionStream.listen(
      (position) {
        if (mounted) {
          setState(() {
            _position = position;
          });
        }
      },
    );
  }

  void _cleanupPlayer() {
    _playerStateSubscription?.cancel();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _player.dispose();
  }

  void _handleError(String error) {
    setState(() {
      _hasError = true;
      _errorMessage = error;
      _isLoading = false;
      _isPlaying = false;
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_getErrorMessage(error)),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          action: SnackBarAction(
            label: 'Retry',
            textColor: Colors.white,
            onPressed: _retryLoad,
          ),
        ),
      );
    }
  }

  String _getErrorMessage(String error) {
    if (error.contains('404') || error.contains('Not Found')) {
      return 'Audio file not found';
    } else if (error.contains('network') || error.contains('connection')) {
      return 'Network connection error';
    } else if (error.contains('format') || error.contains('codec')) {
      return 'Unsupported audio format';
    } else if (error.contains('permission') || error.contains('cleartext')) {
      return 'Permission or security error';
    } else {
      return 'Unable to play audio';
    }
  }

  Future<void> _prepareAudio() async {
    if (_isPrepared || _isLoading) return;

    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
        _errorMessage = null;
      });

      await _player.setUrl(widget.audioUrl);
      
      if (mounted) {
        setState(() {
          _isPrepared = true;
          _isLoading = false;
        });
      }
    } catch (error) {
      _handleError('Failed to load audio: $error');
    }
  }

  Future<void> _togglePlayPause() async {
    try {
      if (!_isPrepared) {
        await _prepareAudio();
        if (_hasError) return;
      }

      if (_isPlaying) {
        await _player.pause();
      } else {
        await _player.play();
      }
    } catch (error) {
      _handleError('Playback control error: $error');
    }
  }

  Future<void> _stop() async {
    try {
      await _player.stop();
      if (mounted) {
        setState(() {
          _position = Duration.zero;
          _isPlaying = false;
        });
      }
    } catch (error) {
      print('Error stopping audio: $error');
    }
  }

  Future<void> _seek(double value) async {
    if (!_isPrepared || _duration.inMilliseconds == 0) return;
    
    try {
      final newPosition = Duration(
        milliseconds: (_duration.inMilliseconds * value).round(),
      );
      await _player.seek(newPosition);
    } catch (error) {
      print('Error seeking: $error');
    }
  }

  void _retryLoad() {
    setState(() {
      _hasError = false;
      _errorMessage = null;
      _isPrepared = false;
    });
    _prepareAudio();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.purple.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Iconsax.headphone,
                  color: Colors.purple,
                  size: 16.sp,
                ),
              ),
              horizontalSpace(8.w),
              Text(
                'Listening Exercise',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lmcBlue,
                ),
              ),
              Spacer(),
              if (_isPrepared && !_hasError)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'Ready',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),

          verticalSpace(16.h),

          // Error Display
          if (_hasError) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: Colors.red.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(Iconsax.warning_2, color: Colors.red, size: 16.sp),
                  horizontalSpace(8.w),
                  Expanded(
                    child: Text(
                      _getErrorMessage(_errorMessage!),
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _retryLoad,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'Retry',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(12.h),
          ],

          // Controls
          Row(
            children: [
              // Play/Pause Button
              GestureDetector(
                onTap: _isLoading ? null : _togglePlayPause,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: _isLoading
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.5,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Icon(
                            _isPlaying ? Iconsax.pause : Iconsax.play,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                  ),
                ),
              ),
              
              horizontalSpace(12.w),

              // Stop Button
              GestureDetector(
                onTap: _isPrepared ? _stop : null,
                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    color: _isPrepared 
                        ? AppColors.lmcBlue.withOpacity(0.1) 
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Iconsax.stop,
                    color: _isPrepared ? AppColors.lmcBlue : Colors.grey,
                    size: 14.sp,
                  ),
                ),
              ),

              horizontalSpace(16.w),

              // Progress Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Time Display
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(_position),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple,
                          ),
                        ),
                        Text(
                          _formatDuration(_duration),
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                    
                    verticalSpace(6.h),

                    // Progress Slider
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.purple,
                        inactiveTrackColor: Colors.purple.withOpacity(0.2),
                        thumbColor: Colors.purple,
                        overlayColor: Colors.purple.withOpacity(0.1),
                        trackHeight: 3.h,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.w),
                      ),
                      child: Slider(
                        value: _duration.inMilliseconds > 0
                            ? (_position.inMilliseconds / _duration.inMilliseconds).clamp(0.0, 1.0)
                            : 0.0,
                        onChanged: _isPrepared && _duration.inMilliseconds > 0 ? _seek : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Loading Indicator
          if (_isLoading && !_hasError) ...[
            verticalSpace(8.h),
            LinearProgressIndicator(
              backgroundColor: Colors.purple.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
          ],
        ],
      ),
    );
  }
}
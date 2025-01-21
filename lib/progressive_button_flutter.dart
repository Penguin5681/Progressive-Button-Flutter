/// A Flutter package that provides a progressive button widget with loading animations
/// and progress indicators.
library progressive_button_flutter;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

/// A stateful widget that displays a button with loading progress animation.
///
/// This button shows loading progress with an optional circular indicator and
/// a progress bar that fills based on an estimated time duration. The button
/// can be customized with different colors, sizes, and behaviors.
class ProgressiveButtonFlutter extends StatefulWidget {
  /// The text to display on the button when not in loading state.
  final String text;

  /// Callback function to be executed when the button is pressed.
  final Future<void> Function() onPressed;

  /// Callback function to be executed when the button action is successful.
  final Future<void> Function()? onSuccess;

  /// Callback function to be executed when the button action fails.
  final Future<void> Function()? onFailure;

  /// Callback function to be executed when the button action is complete.
  final Future<void> Function()? onComplete;

  /// The width of the button.
  final double width;

  /// The height of the button.
  final double height;

  /// The background color of the button.
  final Color backgroundColor;

  /// The color of the progress indicator.
  final Color progressColor;

  /// The estimated time duration for the progress indicator.
  final Duration estimatedTime;

  /// Whether to show a circular progress indicator.
  final bool showCircularIndicator;

  /// The maximum progress value for the progress indicator.
  final double progressCap;

  /// Whether the button should stretch to fill its container.
  final bool stretched;

  /// The text style for the button text.
  final TextStyle textStyle;

  /// The border radius of the button.
  final BorderRadius borderRadius;

  /// The elevation of the button.
  final double elevation;

  /// The shadow color of the button.
  final Color shadowColor;

  /// Whether to enable haptic feedback on button press.
  final bool enableHapticFeedback;

  /// The gradient background of the button
  final Gradient? gradient;

  /// The gradient for the progress indicator
  final Gradient? progressGradient;

  /// Path for custom audio effect
  final String? audioAssetPath;

  /// Volume for the audio effect
  final double volume;

  const ProgressiveButtonFlutter({
    super.key,
    required this.text,
    required this.onPressed,
    this.onFailure,
    this.onSuccess,
    this.onComplete,
    required this.estimatedTime,
    this.width = 200,
    this.height = 40,
    this.backgroundColor = const Color(0xFFADD8E6),
    this.progressColor = const Color(0xFF87CEEB),
    this.showCircularIndicator = true,
    this.progressCap = 0.9,
    this.stretched = false,
    this.textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    ),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    required this.elevation,
    this.shadowColor = Colors.transparent,
    this.enableHapticFeedback = true,
    this.gradient,
    this.progressGradient,
    this.audioAssetPath,
    this.volume = 1.0,
  });

  @override
  State<ProgressiveButtonFlutter> createState() => _ProgressiveButtonFlutterState();
}

class _ProgressiveButtonFlutterState extends State<ProgressiveButtonFlutter> {
  bool _isLoading = false;
  double _progress = 0.0;
  Timer? _progressTimer;
  AudioPlayer? _audioPlayer;

  @override
  void initState() {
    super.initState();
    if (widget.audioAssetPath != null) {
      _audioPlayer = AudioPlayer();
      _initAudio();
    }
  }

  Future<void> _initAudio() async {
    debugPrint('Initializing audio with path: ${widget.audioAssetPath}');
    if (widget.audioAssetPath != null && _audioPlayer != null) {
      try {
        await _audioPlayer!.setVolume(widget.volume);
      } catch (e, stackTrace) {
        debugPrint('Error loading audio: $e');
        debugPrint('Stack trace: $stackTrace');
      }
    }
  }

  Future<void> _playAudio() async {
    debugPrint('Attempting to play audio');
    if (_audioPlayer != null) {
      try {
        await _audioPlayer!.seek(Duration.zero);
        final duration = _audioPlayer!.duration;
        if (duration == null) {
          await _initAudio();
        }
        await _audioPlayer!.play();
        await Future.delayed(const Duration(milliseconds: 100));
      } catch (e, stackTrace) {
        debugPrint('Error playing audio: $e');
        debugPrint('Stack trace: $stackTrace');
      }
    } else {
      debugPrint('AudioPlayer is null');
    }
  }

  void startProgressSimulation() {
    const updateInterval = Duration(milliseconds: 100);
    final totalInterval = widget.estimatedTime.inMilliseconds / updateInterval.inMilliseconds;
    double progressPerInterval = 1 / totalInterval;

    _progressTimer = Timer.periodic(updateInterval, (timer) {
      if (!mounted || !_isLoading) {
        timer.cancel();
        return;
      }

      setState(() {
        if (_progress < widget.progressCap) {
          _progress += progressPerInterval;
        }
      });
    });
  }

  Future<void> handlePress() async {
    if (widget.audioAssetPath != null) {
      await _playAudio();
    }

    if (widget.enableHapticFeedback) {
      HapticFeedback.vibrate();
    }

    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
      _progress = 0.0;
    });

    startProgressSimulation();

    try {
      await widget.onPressed();
      setState(() {
        _progress = 1.0;
      });
      await Future.delayed(const Duration(milliseconds: 200));
      if (widget.onSuccess != null) {
        await widget.onSuccess!();
      }
    } catch (e) {
      if (widget.onFailure != null) {
        await widget.onFailure!();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _progress = 0.0;
        });
      }
      if (widget.onComplete != null) {
        await widget.onComplete!();
      }
    }
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handlePress,
      child: Material(
        elevation: widget.elevation,
        borderRadius: widget.borderRadius,
        shadowColor: Colors.blue,
        child: Container(
          width: widget.stretched ? double.infinity : widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: widget.gradient ?? LinearGradient(colors: [widget.backgroundColor, widget.backgroundColor]),
            borderRadius: widget.borderRadius,
            color: widget.backgroundColor,
          ),
          clipBehavior: Clip.hardEdge,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: constraints.maxWidth * _progress,
                    height: widget.height,
                    decoration: BoxDecoration(
                      gradient: widget.progressGradient,
                      color: widget.progressGradient == null ? widget.progressColor : null,
                    ),
                  ),
                  Center(
                    child: _isLoading
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (widget.showCircularIndicator)
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                              const SizedBox(width: 8),
                              Text(
                                '${(_progress * 100).toInt()}%',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            widget.text,
                            style: widget.textStyle,
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

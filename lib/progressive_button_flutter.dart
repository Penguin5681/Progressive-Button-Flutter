library progressive_button_flutter;

import 'dart:async';

import 'package:flutter/material.dart';

class ProgressiveButtonFlutter extends StatefulWidget {
  final String text;
  final Future<void> Function() onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color progressColor;
  final Duration estimatedTime;
  final bool showCircularIndicator;
  final double progressCap;
  final bool stretched;

  const ProgressiveButtonFlutter({
    super.key,
    required this.text,
    required this.onPressed,
    required this.estimatedTime,
    this.width = 200,
    this.height = 40,
    this.backgroundColor = const Color(0xFFADD8E6),
    this.progressColor = const Color(0xFF87CEEB),
    this.showCircularIndicator = true,
    this.progressCap = 0.9,
    this.stretched = false,
  });

  @override
  State<ProgressiveButtonFlutter> createState() => _ProgressiveButtonFlutterState();
}

class _ProgressiveButtonFlutterState extends State<ProgressiveButtonFlutter> {
  bool _isLoading = false;
  double _progress = 0.0;
  Timer? _progressTimer;

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
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _progress = 0.0;
        });
      }
    }
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handlePress,
      child: Container(
        width: widget.stretched ? double.infinity : widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.height / 2),
          color: widget.backgroundColor,
        ),
        clipBehavior: Clip.hardEdge,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // Progress indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  width: constraints.maxWidth * _progress,
                  height: widget.height,
                  color: widget.progressColor,
                ),

                // Content
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

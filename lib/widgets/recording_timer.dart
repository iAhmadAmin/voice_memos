import 'package:flutter/material.dart';

class RecordingTimer extends StatelessWidget {
  final Duration duration;

  const RecordingTimer({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Text(_formatDuration(duration));
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final milliseconds = duration.inMilliseconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    final formattedDuration = '$minutes:$seconds:$milliseconds';

    return formattedDuration;
  }
}

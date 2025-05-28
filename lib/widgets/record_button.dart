import 'package:flutter/material.dart';
import '../cubits/audio_cubit.dart';

class RecordButton extends StatelessWidget {
  final AudioState state;
  final VoidCallback onTap;

  const RecordButton({super.key, required this.state, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: state.recordingState.maybeWhen(
            recording: () => Colors.red,
            paused: () => Colors.red,
            orElse: () => Colors.red,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Icon(
          state.recordingState.maybeWhen(
            recording: () => Icons.pause,
            paused: () => Icons.play_arrow,
            orElse: () => Icons.mic,
          ),
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }
}

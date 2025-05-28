import 'package:flutter/material.dart';
import 'package:voice_memos/widgets/recorder_view.dart';
import 'package:voice_memos/widgets/recordings_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Voice Memos',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Recordings View
          Expanded(child: RecordingsView()),
          // Recorder View
          RecorderView(),
        ],
      ),
    );
  }
}

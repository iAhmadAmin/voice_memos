import 'dart:developer';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_memos/cubits/audio_cubit.dart';
import 'package:voice_memos/cubits/recordings_cubit.dart';
import 'package:voice_memos/models/recording.dart';
import 'package:voice_memos/widgets/recording_timer.dart';
import 'package:voice_memos/widgets/recording_tile.dart';

class RecorderView extends StatefulWidget {
  const RecorderView({super.key});

  @override
  State<RecorderView> createState() => _RecorderViewState();
}

class _RecorderViewState extends State<RecorderView> {
  late RecorderController _recorderController;
  bool _showWidgets = false;

  @override
  void initState() {
    super.initState();
    _recorderController = RecorderController();
  }

  @override
  void dispose() {
    _recorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<AudioCubit, AudioState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final isRecording =
            state.recordingState == AudioRecordingState.recording();

        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.only(bottom: 10),
          height: isRecording ? 240 : 130,
          width: size.width,
          color: Colors.black.withOpacity(0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Title
              if (isRecording && _showWidgets)
                AnimatedOpacity(
                  opacity: isRecording ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 12000),
                  child: Column(
                    children: [
                      Container(
                        width: 48,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Timer
                      RecordingTimer(duration: state.recordingDuration),

                      const SizedBox(height: 12),

                      // Waveform
                      AudioWaveforms(
                        enableGesture: false,
                        size: Size(MediaQuery.of(context).size.width, 60),
                        recorderController: _recorderController,
                        waveStyle: const WaveStyle(
                          waveColor: Colors.red,

                          scaleFactor: 100.0,
                          extendWaveform: true,
                          showMiddleLine: false,
                        ),
                      ),
                    ],
                  ),
                ),
              // Button
              SizedBox(
                width: size.width,
                height: 110,
                child: Center(
                  child: GestureDetector(
                    onTap: () => _handleRecordButtonTap(context, state),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.grey[700],
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white,
                        child: AnimatedContainer(
                          margin: EdgeInsets.all(isRecording ? 14 : 2),
                          duration: const Duration(milliseconds: 400),

                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(
                              isRecording ? 4 : 32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleRecordButtonTap(BuildContext context, AudioState state) {
    log('handleRecordButtonTap');
    final audioCubit = context.read<AudioCubit>();
    final recordingsCubit = context.read<RecordingsCubit>();
    state.recordingState.when(
      idle: () async {
        log('handleRecordButtonTap: recordingState: idle');
        await _startNewRecording(audioCubit);
      },
      recording: () async {
        log('handleRecordButtonTap: recordingState: recording');
        await _recorderController.stop();
        final recording = await audioCubit.stopRecording();

        if (recording != null && mounted) {
          await recordingsCubit.addRecording(recording);
        }
        setState(() {
          _showWidgets = false;
        });
      },
      paused: () async {
        log('handleRecordButtonTap: recordingState: paused');
        await _startNewRecording(audioCubit);
      },
      playing: () async {
        log(
          'handleRecordButtonTap: recordingState: playing - stopping playback to start recording',
        );
        await _startNewRecording(audioCubit);
      },
    );
  }

  Future<void> _startNewRecording(AudioCubit audioCubit) async {
    // Stop any playing audio and collapse expanded tiles before recording
    await _stopPlaybackAndCollapseExpandedTiles(audioCubit);

    final hasPermission = await audioCubit.checkPermissions();
    if (hasPermission) {
      await _recorderController.record();
      await audioCubit.startRecording();
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _showWidgets = true;
        });
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Microphone permission is required'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _stopPlaybackAndCollapseExpandedTiles(
    AudioCubit audioCubit,
  ) async {
    try {
      // Stop any playing audio in the audio cubit
      await audioCubit.stopPlayback();

      // Collapse any expanded recording tiles
      RecordingTile.collapseCurrentlyExpandedTile();

      log('Stopped playback and collapsed expanded tiles before recording');
    } catch (e) {
      log('Error stopping playback before recording: $e');
    }
  }
}

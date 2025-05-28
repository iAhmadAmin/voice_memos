import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'dart:io';
import '../cubits/audio_cubit.dart';
import '../models/recording.dart';

class PlaybackScreen extends StatefulWidget {
  final Recording recording;

  const PlaybackScreen({super.key, required this.recording});

  @override
  State<PlaybackScreen> createState() => _PlaybackScreenState();
}

class _PlaybackScreenState extends State<PlaybackScreen> {
  late PlayerController _playerController;
  bool _isPlayerReady = false;
  String? _initError;

  @override
  void initState() {
    super.initState();
    _playerController = PlayerController();
    _initializePlayer();
  }

  void _initializePlayer() async {
    try {
      log(
        'Attempting to initialize player with path: ${widget.recording.filePath}',
      );

      // Check if file exists first
      final file = File(widget.recording.filePath);
      final exists = await file.exists();
      log('File exists: $exists');

      if (!exists) {
        setState(() {
          _initError = 'Audio file not found: ${widget.recording.filePath}';
        });
        return;
      }

      // Check file size
      final fileSize = await file.length();
      log('File size: $fileSize bytes');

      await _playerController.preparePlayer(
        path: widget.recording.filePath,
        shouldExtractWaveform: true,
      );

      log('Player prepared successfully');
      setState(() {
        _isPlayerReady = true;
      });
    } catch (e) {
      log('Error initializing player: $e');
      setState(() {
        _initError = 'Failed to prepare audio player: $e';
      });
    }
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recording.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  _navigateToEditScreen();
                  break;
                case 'share':
                  _shareRecording();
                  break;
              }
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 20),
                        SizedBox(width: 12),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'share',
                    child: Row(
                      children: [
                        Icon(Icons.share, size: 20),
                        SizedBox(width: 12),
                        Text('Share'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: BlocConsumer<AudioCubit, AudioState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
            context.read<AudioCubit>().clearError();
          }

          // Show init error if present
          if (_initError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_initError!),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 5),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Spacer(),

                  // Recording info
                  Text(
                    widget.recording.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    _formatDate(widget.recording.dateCreated),
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),

                  const SizedBox(height: 40),

                  // Waveform with seek functionality
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:
                        _initError != null
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.error_outline,
                                    color: Colors.red,
                                    size: 32,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Audio file error',
                                    style: TextStyle(
                                      color: Colors.red[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : !_isPlayerReady
                            ? const Center(child: CircularProgressIndicator())
                            : AudioFileWaveforms(
                              size: Size(
                                MediaQuery.of(context).size.width - 48,
                                100,
                              ),
                              playerController: _playerController,
                              enableSeekGesture: true,
                              waveformType: WaveformType.long,
                              playerWaveStyle: const PlayerWaveStyle(
                                fixedWaveColor: Colors.grey,
                                liveWaveColor: Colors.red,
                                spacing: 6,
                              ),
                            ),
                  ),

                  const SizedBox(height: 20),

                  // Time indicators
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatDuration(state.playbackPosition),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          _formatDuration(
                            Duration(seconds: widget.recording.duration),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Playback controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Rewind button
                      _buildControlButton(
                        icon: Icons.replay_10,
                        onPressed: () => _seekBackward(context),
                        backgroundColor: Colors.grey[200]!,
                        iconColor: Colors.black87,
                      ),

                      // Play/Pause button
                      _buildMainPlayButton(state),

                      // Forward button
                      _buildControlButton(
                        icon: Icons.forward_10,
                        onPressed: () => _seekForward(context),
                        backgroundColor: Colors.grey[200]!,
                        iconColor: Colors.black87,
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMainPlayButton(AudioState state) {
    return GestureDetector(
      onTap: () => _handlePlayButtonTap(context, state),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.red,
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
            playing: () => Icons.pause,
            orElse: () => Icons.play_arrow,
          ),
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 28),
      ),
    );
  }

  void _handlePlayButtonTap(BuildContext context, AudioState state) {
    if (!_isPlayerReady || _initError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_initError ?? 'Audio player not ready'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final audioCubit = context.read<AudioCubit>();

    state.recordingState.when(
      idle: () async {
        try {
          await _playerController.startPlayer();
          await audioCubit.playRecording(
            widget.recording.filePath,
            totalDuration: Duration(seconds: widget.recording.duration),
          );
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to play audio: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      playing: () async {
        try {
          await _playerController.pausePlayer();
          await audioCubit.pausePlayback();
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to pause audio: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      paused: () async {
        try {
          await _playerController.startPlayer();
          await audioCubit.resumePlayback();
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to resume audio: $e'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },

      recording: () {}, // Not applicable in playback screen
    );
  }

  void _seekBackward(BuildContext context) async {
    // Simplified seek - will be enhanced later
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Seek backward functionality coming soon')),
    );
  }

  void _seekForward(BuildContext context) async {
    // Simplified seek - will be enhanced later
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Seek forward functionality coming soon')),
    );
  }

  void _navigateToEditScreen() {
    // TODO: Implement edit screen navigation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Edit functionality coming soon')),
    );
  }

  void _shareRecording() {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Share functionality coming soon')),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today at ${_formatTime(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${_formatTime(date)}';
    } else if (difference.inDays < 7) {
      return '${_getDayName(date.weekday)} at ${_formatTime(date)}';
    } else {
      return '${date.day}/${date.month}/${date.year} at ${_formatTime(date)}';
    }
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _getDayName(int weekday) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[weekday - 1];
  }
}

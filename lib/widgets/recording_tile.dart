import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:developer';
import '../models/recording.dart';
import '../cubits/audio_cubit.dart';

class RecordingTile extends StatefulWidget {
  final Recording recording;
  final VoidCallback onDelete;
  final VoidCallback onRename;

  const RecordingTile({
    super.key,
    required this.recording,
    required this.onDelete,
    required this.onRename,
  });

  @override
  State<RecordingTile> createState() => _RecordingTileState();

  // Static method to collapse any currently expanded tile
  static void collapseCurrentlyExpandedTile() {
    if (_RecordingTileState._currentlyExpandedTile != null) {
      _RecordingTileState._currentlyExpandedTile!._collapseThis();
    }
  }

  // Static method to expand a specific recording tile by ID
  static void expandRecordingById(String recordingId) {
    // First collapse any currently expanded tile
    collapseCurrentlyExpandedTile();

    // Set the target recording ID to be expanded
    _RecordingTileState._targetRecordingIdToExpand = recordingId;
  }
}

class _RecordingTileState extends State<RecordingTile> {
  // Static variables to track currently expanded tile
  static _RecordingTileState? _currentlyExpandedTile;
  static String? _currentlyExpandedRecordingId;
  static String? _targetRecordingIdToExpand;

  bool _isExpanded = false;

  PlayerController? _playerController;
  bool _isPlayerReady = false;
  String? _initError;

  @override
  void initState() {
    super.initState();

    // Check if this tile should be auto-expanded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForAutoExpansion();
    });
  }

  void _checkForAutoExpansion() {
    if (_targetRecordingIdToExpand == widget.recording.id && !_isExpanded) {
      // Clear the target ID and expand this tile
      _targetRecordingIdToExpand = null;
      _expandThis();
    }
  }

  @override
  void dispose() {
    // If this tile is currently expanded, clear the static reference
    if (_currentlyExpandedTile == this) {
      _currentlyExpandedTile = null;
      _currentlyExpandedRecordingId = null;
    }
    _playerController?.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    if (_isExpanded) {
      // If this tile is expanded, collapse it
      _collapseThis();
    } else {
      // If another tile is expanded, collapse it first
      if (_currentlyExpandedTile != null && _currentlyExpandedTile != this) {
        _currentlyExpandedTile!._collapseThis();
      }

      // Expand this tile
      _expandThis();
    }
  }

  void _expandThis() {
    setState(() {
      _isExpanded = true;
    });

    // Set this tile as the currently expanded one
    _currentlyExpandedTile = this;
    _currentlyExpandedRecordingId = widget.recording.id;

    _initializePlayer();
  }

  void _collapseThis() {
    setState(() {
      _isExpanded = false;
    });

    // Clear static references if this was the expanded tile
    if (_currentlyExpandedTile == this) {
      _currentlyExpandedTile = null;
      _currentlyExpandedRecordingId = null;
    }

    _stopPlayer();
  }

  void _initializePlayer() async {
    if (_playerController != null) return;

    try {
      log('Initializing player for: ${widget.recording.filePath}');

      final file = File(widget.recording.filePath);
      final exists = await file.exists();

      if (!exists) {
        setState(() {
          _initError = 'Audio file not found';
        });
        return;
      }

      _playerController = PlayerController();
      await _playerController!.preparePlayer(
        path: widget.recording.filePath,
        shouldExtractWaveform: true,
      );

      // Listen for player completion
      _playerController!.onCompletion.listen((_) {
        if (mounted) {
          // Audio finished playing, update the audio cubit state
          context.read<AudioCubit>().stopPlayback();
        }
      });

      setState(() {
        _isPlayerReady = true;
      });
    } catch (e) {
      log('Error initializing player: $e');
      setState(() {
        _initError = 'Failed to load audio';
      });
    }
  }

  void _stopPlayer() async {
    if (_playerController != null) {
      try {
        await _playerController!.stopPlayer();
        // Also stop playback in the audio cubit
        context.read<AudioCubit>().stopPlayback();
      } catch (e) {
        log('Error stopping player: $e');
      }

      // Dispose and reset the player controller
      _playerController?.dispose();
      _playerController = null;
      _isPlayerReady = false;
      _initError = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check for auto-expansion on each build (in case widget was rebuilt)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForAutoExpansion();
    });

    return GestureDetector(
      onTap: _toggleExpanded,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isExpanded ? 200 : 45,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Always visible header
              Text(
                widget.recording.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              Row(
                children: [
                  Text(
                    _formatDate(widget.recording.dateCreated),
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const Spacer(),

                  Text(
                    _formatDuration(widget.recording.duration),
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),

              // Expandable player section
              if (_isExpanded) ...[
                const SizedBox(height: 16),
                AnimatedOpacity(
                  opacity: _isExpanded ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: _buildPlayerSection(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerSection() {
    return BlocConsumer<AudioCubit, AudioState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
          );
          context.read<AudioCubit>().clearError();
        }

        // If audio stops playing and this was the playing tile, ensure player is stopped
        if (state.recordingState == const AudioRecordingState.idle() &&
            _currentlyExpandedRecordingId == widget.recording.id &&
            _playerController != null) {
          _playerController!.stopPlayer().catchError((e) {
            log('Error stopping player on state change: $e');
          });
        }
      },
      builder: (context, state) {
        final totalDuration = Duration(seconds: widget.recording.duration);
        final currentPosition = state.playbackPosition;
        final isThisTilePlaying = _shouldBePlaying(state);

        return Column(
          children: [
            // Progress slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.red,
                      inactiveTrackColor: Colors.grey[300],
                      thumbColor: Colors.red,
                      overlayColor: Colors.red.withOpacity(0.2),
                      trackHeight: 3,
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6,
                      ),
                    ),
                    child: Slider(
                      value:
                          totalDuration.inMilliseconds > 0
                              ? (currentPosition.inMilliseconds /
                                      totalDuration.inMilliseconds)
                                  .clamp(0.0, 1.0)
                              : 0.0,
                      onChanged:
                          _isPlayerReady && _playerController != null
                              ? (value) {
                                final newPosition = Duration(
                                  milliseconds:
                                      (value * totalDuration.inMilliseconds)
                                          .round(),
                                );
                                _seekToPosition(newPosition);
                              }
                              : null,
                    ),
                  ),

                  // Time indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDurationFromDuration(
                          isThisTilePlaying ? currentPosition : Duration.zero,
                        ),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      Text(
                        _formatDurationFromDuration(totalDuration),
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Backward 5 seconds button
                _buildControlButton(
                  icon: Icons.replay_5,
                  onPressed: () => _seekBackward5Seconds(context, state),
                  backgroundColor: Colors.grey[200]!,
                  iconColor: Colors.black87,
                ),

                // Play/Pause button
                GestureDetector(
                  onTap: () => _handlePlayButtonTap(context, state),
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      isThisTilePlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),

                // Forward 5 seconds button
                _buildControlButton(
                  icon: Icons.forward_5,
                  onPressed: () => _seekForward5Seconds(context, state),
                  backgroundColor: Colors.grey[200]!,
                  iconColor: Colors.black87,
                ),
              ],
            ),
          ],
        );
      },
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
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
    );
  }

  void _seekToPosition(Duration position) async {
    if (_playerController != null && _isPlayerReady) {
      try {
        await _playerController!.seekTo(position.inMilliseconds);
        context.read<AudioCubit>().seekTo(position);
      } catch (e) {
        log('Error seeking to position: $e');
      }
    }
  }

  void _seekBackward5Seconds(BuildContext context, AudioState state) async {
    final currentPosition = state.playbackPosition;
    final newPosition = Duration(
      milliseconds: (currentPosition.inMilliseconds - 5000).clamp(
        0,
        currentPosition.inMilliseconds,
      ),
    );
    _seekToPosition(newPosition);
  }

  void _seekForward5Seconds(BuildContext context, AudioState state) async {
    final currentPosition = state.playbackPosition;
    final totalDuration = Duration(seconds: widget.recording.duration);
    final newPosition = Duration(
      milliseconds: (currentPosition.inMilliseconds + 5000).clamp(
        0,
        totalDuration.inMilliseconds,
      ),
    );
    _seekToPosition(newPosition);
  }

  String _formatDurationFromDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _handlePlayButtonTap(BuildContext context, AudioState state) {
    if (!_isPlayerReady || _initError != null || _playerController == null) {
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
          // Stop any other playing audio first
          await audioCubit.stopPlayback();

          // Start this player
          await _playerController!.startPlayer();
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
          await _playerController!.pausePlayer();
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
          await _playerController!.startPlayer();
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
      recording: () {}, // Not applicable
    );
  }

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final recordingDate = DateTime(date.year, date.month, date.day);

    if (recordingDate == today) {
      return DateFormat('HH:mm').format(date);
    } else if (recordingDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else if (now.difference(date).inDays < 7) {
      return DateFormat('EEEE').format(date);
    } else {
      return DateFormat('MMM d').format(date);
    }
  }

  // Helper method to check if this tile should be playing
  bool _shouldBePlaying(AudioState state) {
    return _currentlyExpandedRecordingId == widget.recording.id &&
        state.recordingState == const AudioRecordingState.playing();
  }
}

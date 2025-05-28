import 'dart:async';
import 'dart:io';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../models/recording.dart';

class AudioService {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  final Uuid _uuid = const Uuid();

  String? _currentRecordingPath;
  Timer? _recordingTimer;
  Duration _recordingDuration = Duration.zero;

  // Stream controllers for real-time updates
  final StreamController<Duration> _recordingDurationController =
      StreamController<Duration>.broadcast();
  final StreamController<Duration> _playbackPositionController =
      StreamController<Duration>.broadcast();
  final StreamController<AudioRecordingState> _recordingStateController =
      StreamController<AudioRecordingState>.broadcast();

  // Getters for streams
  Stream<Duration> get recordingDurationStream =>
      _recordingDurationController.stream;
  Stream<Duration> get playbackPositionStream =>
      _playbackPositionController.stream;
  Stream<AudioRecordingState> get recordingStateStream =>
      _recordingStateController.stream;

  Future<bool> hasPermission() async {
    return await _recorder.hasPermission();
  }

  Future<String> _generateRecordingPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
    final fileName = 'Recording_$timestamp.m4a';
    return '${directory.path}/$fileName';
  }

  String _generateRecordingName() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd HH:mm');
    return 'Recording ${formatter.format(now)}';
  }

  Future<void> startRecording() async {
    if (!await hasPermission()) {
      throw Exception('Microphone permission not granted');
    }

    _currentRecordingPath = await _generateRecordingPath();
    _recordingDuration = Duration.zero;

    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
        numChannels: 1,
      ),
      path: _currentRecordingPath!,
    );

    _recordingStateController.add(const AudioRecordingState.recording());
    _startRecordingTimer();
  }

  Future<Recording?> stopRecording() async {
    final path = await _recorder.stop();
    _stopRecordingTimer();
    _recordingStateController.add(const AudioRecordingState.idle());

    if (path != null && _recordingDuration.inSeconds > 0) {
      final recording = Recording(
        id: _uuid.v4(),
        name: _generateRecordingName(),
        filePath: path,
        duration: _recordingDuration.inSeconds,
        dateCreated: DateTime.now(),
      );

      _currentRecordingPath = null;
      _recordingDuration = Duration.zero;

      return recording;
    }

    return null;
  }

  void _startRecordingTimer() {
    _recordingTimer = Timer.periodic(const Duration(milliseconds: 100), (
      timer,
    ) {
      _recordingDuration = Duration(
        milliseconds: _recordingDuration.inMilliseconds + 100,
      );
      _recordingDurationController.add(_recordingDuration);
    });
  }

  void _stopRecordingTimer() {
    _recordingTimer?.cancel();
    _recordingTimer = null;
  }

  Future<void> playRecording(String filePath) async {
    await _player.play(DeviceFileSource(filePath));
    _recordingStateController.add(const AudioRecordingState.playing());

    // Listen to position changes
    _player.onPositionChanged.listen((position) {
      _playbackPositionController.add(position);
    });

    // Listen to completion
    _player.onPlayerComplete.listen((_) {
      _recordingStateController.add(const AudioRecordingState.idle());
    });
  }

  Future<void> pausePlayback() async {
    await _player.pause();
    _recordingStateController.add(const AudioRecordingState.paused());
  }

  Future<void> resumePlayback() async {
    await _player.resume();
    _recordingStateController.add(const AudioRecordingState.playing());
  }

  Future<void> stopPlayback() async {
    await _player.stop();
    _recordingStateController.add(const AudioRecordingState.idle());
  }

  Future<void> seekTo(Duration position) async {
    await _player.seek(position);
  }

  Future<Duration?> getRecordingDuration(String filePath) async {
    final file = File(filePath);
    if (!await file.exists()) return null;

    // For simplicity, we'll use the stored duration from database
    // In a more complex implementation, you could use audio metadata packages
    return null;
  }

  Future<void> deleteRecordingFile(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> trimRecording(
    String inputPath,
    String outputPath,
    Duration startTime,
    Duration endTime,
  ) async {
    // For simplicity, this is a placeholder
    // In a real implementation, you would use FFmpeg or similar
    // to trim the audio file
    final inputFile = File(inputPath);
    final outputFile = File(outputPath);

    if (await inputFile.exists()) {
      await inputFile.copy(outputPath);
    }
  }

  void dispose() {
    _recordingTimer?.cancel();
    _recorder.dispose();
    _player.dispose();
    _recordingDurationController.close();
    _playbackPositionController.close();
    _recordingStateController.close();
  }
}

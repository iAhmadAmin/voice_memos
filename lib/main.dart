import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'core/service_locator.dart';
import 'cubits/recordings_cubit.dart';
import 'cubits/audio_cubit.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup dependency injection
  await setupServiceLocator();

  // Request permissions
  await _requestPermissions();

  runApp(const VoiceMemosApp());
}

Future<void> _requestPermissions() async {
  await [Permission.microphone, Permission.storage].request();
}

class VoiceMemosApp extends StatelessWidget {
  const VoiceMemosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RecordingsCubit()),
        BlocProvider(create: (context) => AudioCubit()),
      ],
      child: MaterialApp(
        title: 'Voice Memos',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.red,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

// This is a basic Flutter widget test for the Voice Memos app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:voice_memos/main.dart';
import 'package:voice_memos/core/service_locator.dart';

void main() {
  testWidgets('Voice Memos app smoke test', (WidgetTester tester) async {
    // Setup service locator for testing
    await setupServiceLocator();

    // Build our app and trigger a frame.
    await tester.pumpWidget(const VoiceMemosApp());

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Verify that the app shows the Voice Memos title
    expect(find.text('Voice Memos'), findsOneWidget);

    // Verify that the floating action button (record button) is present
    expect(find.byIcon(Icons.mic), findsOneWidget);

    // Verify that the empty state message is shown
    expect(find.text('No recordings yet'), findsOneWidget);
  });
}

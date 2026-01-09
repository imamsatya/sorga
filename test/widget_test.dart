// Basic smoke test for Sorga app

import 'package:flutter_test/flutter_test.dart';

import 'package:sorga/main.dart';

void main() {
  testWidgets('App starts successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SorgaApp());
    await tester.pumpAndSettle();

    // Verify that home screen elements are present
    expect(find.text('SORGA'), findsOneWidget);
    expect(find.text('PLAY'), findsOneWidget);
  });
}

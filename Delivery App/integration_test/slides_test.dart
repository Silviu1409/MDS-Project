import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:delivery_app/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  WidgetsFlutterBinding.ensureInitialized();

  Future initialization(BuildContext? context) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  FlutterNativeSplash.removeAfter(initialization);

  group('Intro slides test', () {
    testWidgets('tap on next slide until login page comes up',
        (WidgetTester tester) async {
      await app.main();

      await tester.pumpAndSettle();

      Finder finder = find.byIcon(Icons.navigate_next);

      await tester.tap(finder);

      await tester.pumpAndSettle();

      await tester.tap(finder);

      await tester.pumpAndSettle();

      finder = find.byIcon(Icons.done);

      await tester.tap(finder);

      await tester.pumpAndSettle();

      expect(find.text("Welcome back!"), findsOneWidget);
    });
  });
}

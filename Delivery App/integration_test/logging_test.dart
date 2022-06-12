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

  group('User logging test', () {
    testWidgets('checks if an user can log in', (WidgetTester tester) async {
      await app.main();

      await tester.pumpAndSettle();

      Finder finder = find.byIcon(Icons.skip_next);

      await tester.tap(finder);

      await tester.pumpAndSettle();

      finder = find.byIcon(Icons.done);

      await tester.tap(finder);

      await tester.pumpAndSettle();

      finder = find.byKey(const Key('email'));

      await tester.enterText(finder, 'a@a');

      await tester.pumpAndSettle();

      finder = find.byKey(const Key('passwd'));

      await tester.enterText(finder, '123');

      await tester.pumpAndSettle();

      finder = find.byKey(const Key('login'));

      await tester.tap(finder);

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text("Restaurante"), findsOneWidget);
    });
  });
}

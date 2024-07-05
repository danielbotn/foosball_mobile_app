import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foosball_mobile_app/widgets/dashboard/New_Dashboard.dart';
import 'package:integration_test/integration_test.dart';
import 'package:foosball_mobile_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end to end', () {
    testWidgets('verify login', (tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Find the email and password fields
      final emailField = find.byType(TextFormField).at(0);
      final passwordField = find.byType(TextFormField).at(1);

      // Enter invalid test credentials
      await tester.enterText(emailField, dotenv.env['USERNAME_TEST'] ?? '');
      await tester.enterText(passwordField, dotenv.env['PASSWOR_TEST'] ?? '');
      await tester.pumpAndSettle();

      // Find and tap the login button
      final loginButton = find.text('LOGIN');
      await tester.tap(loginButton);

      // Wait for the error message to appear
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify that we've navigated to the Dashboard
      expect(find.byType(NewDashboard), findsOneWidget);

      // Optional: Verify some elements on the Dashboard
      expect(find.text('Mark Andersen'), findsOneWidget);
      expect(find.text('Matches'), findsOneWidget);
      expect(find.text('Goals'), findsOneWidget);
      expect(find.text('Quick Actions'), findsOneWidget);
      expect(find.text('Last Ten Matches'), findsOneWidget);
    });
  });
}

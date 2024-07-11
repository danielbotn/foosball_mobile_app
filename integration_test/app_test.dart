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

  testWidgets('verify new game function', (tester) async {
    // Start the app and log in (assuming this is necessary)
    app.main();
    await tester.pumpAndSettle();
    // Perform login steps if needed
    // ...

    // Find and tap the new game icon/button
    // Find and tap the new game button using the key
    final newGameButton = find.byKey(const Key('newGameButton'));
    await tester.tap(newGameButton);
    await tester.pumpAndSettle();

    // Verify that "Choose opponent" is visible
    expect(find.text('Choose Opponent'), findsOneWidget);

    // Find the ListTile for Allen Turner
    final allenTurnerTile = find.ancestor(
      of: find.text('Allen Turner'),
      matching: find.byType(ListTile),
    );

    // Find the Checkbox within Allen Turner's ListTile
    final allenTurnerCheckbox = find.descendant(
      of: allenTurnerTile,
      matching: find.byType(Checkbox),
    );

    // Tap the checkbox
    await tester.tap(allenTurnerCheckbox);
    await tester.pumpAndSettle();

    // Verify that Allen Turner is added to a team
    // This might be Team One or Team Two depending on the state
    expect(find.text('Allen Turner'), findsOneWidget);

    // Verify that "Match" text is visible (if applicable)
    // Note: Your code doesn't show where "Match" text appears, so this might need adjustment
    expect(find.text('Match'), findsOneWidget);

    // Verify that the current user (e.g., "Mark Andersen") is also visible
    // Note: Replace "Mark Andersen" with the actual name of the logged-in user
    expect(find.text('Mark'), findsOneWidget);
    expect(find.text('Andersen'), findsOneWidget);

    // Verify the "vs" text if it's shown somewhere
    expect(find.text('VS'), findsOneWidget);

    // Verify that the current user (e.g., "Mark Andersen") is also visible
    // Note: Replace "Mark Andersen" with the actual name of the logged-in user
    expect(find.text('Allen'), findsOneWidget);
    expect(find.text('Turner'), findsOneWidget);
  });
}

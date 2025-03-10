import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dano_foosball/widgets/dashboard/New_Dashboard.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dano_foosball/main.dart' as app;

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

  testWidgets('verify freehand game', (tester) async {
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

    // Tap the "Start Game" button
    final startGameButton = find.text('Start Game');
    await tester.tap(startGameButton);
    await tester.pumpAndSettle();

    // Verify the new game screen elements
    expect(find.text('New Game'), findsOneWidget);
    expect(find.text('Mark'), findsOneWidget);
    expect(find.text('Andersen'), findsOneWidget);
    expect(find.text('Allen'), findsOneWidget);
    expect(find.text('Turner'), findsOneWidget);
    expect(
        find.text('0'), findsNWidgets(2)); // Expecting two '0's for the score
    expect(find.text('Pause'), findsOneWidget);

    // Start scoring goals
    int markScore = 0;
    int allenScore = 0;

    while (markScore < 10 && allenScore < 10) {
      String playerName = (markScore <= allenScore) ? "Mark" : "Allen";

      final playerIcon = find.byKey(Key("freehandGame$playerName"));
      await tester.tap(playerIcon);

      await tester.pump(const Duration(milliseconds: 500));

      if (playerName == "Mark") {
        markScore++;
      } else {
        allenScore++;
      }
    }

    // Wait for the MatchDetails screen to appear
    await tester.pumpAndSettle();

    // Final score verification
    expect(find.text('10'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);

    // Verify player names are still visible
    expect(find.text('Mark'), findsOneWidget);
    expect(find.text('Andersen'), findsOneWidget);
    expect(find.text('Allen'), findsOneWidget);
    expect(find.text('Turner'), findsOneWidget);

    expect(find.text('Match Report'), findsOneWidget);
    expect(find.text('Rematch'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);
  }, skip: true);

  testWidgets('verify freehand double game', (tester) async {
    // Start the app and log in (assuming this is necessary)
    app.main();
    await tester.pumpAndSettle();

    // Find and tap the new game button using the key
    final newGameButton = find.byKey(const Key('newGameButton'));
    await tester.tap(newGameButton);
    await tester.pumpAndSettle();

    // Click on button with text: 4 Players
    final fourPlayersButton = find.text('Four Players');
    await tester.tap(fourPlayersButton);
    await tester.pumpAndSettle();

    // Check if text "Choose Teammate" appears
    expect(find.text('Choose Teammate'), findsOneWidget);

    // Scroll to make 'Harry Christensen' visible, then find and tap the checkbox within the ListTile
    final harryChristensenTile = find.ancestor(
      of: find.text('Harry Christensen'),
      matching: find.byType(ListTile),
    );
    await tester.scrollUntilVisible(
      harryChristensenTile,
      100.0,
      scrollable: find.byType(Scrollable),
    );
    final harryChristensenCheckbox = find.descendant(
      of: harryChristensenTile,
      matching: find.byType(Checkbox),
    );
    await tester.tap(harryChristensenCheckbox);
    await tester.pumpAndSettle();

    // Check if Text "Choose Opponents" appears
    expect(find.text('Choose Opponents'), findsOneWidget);

    // Function to scroll until the desired ListTile is found
    Future<void> scrollToPlayer(String playerName) async {
      bool playerVisible = false;
      int scrollAttempts = 0; // Counter to limit scroll attempts

      // Start by scrolling to the top of the list to reset the scroll position
      await tester.drag(find.byType(Scrollable), const Offset(0, 1000));
      await tester.pumpAndSettle();

      while (!playerVisible && scrollAttempts < 20) {
        // Limit attempts to prevent infinite scroll
        final playerTile = find.ancestor(
          of: find.text(playerName),
          matching: find.byType(ListTile),
        );

        if (playerTile.evaluate().isNotEmpty) {
          // If the player tile is found, locate and tap the checkbox
          final playerCheckbox = find.descendant(
            of: playerTile,
            matching: find.byType(Checkbox),
          );
          await tester.tap(playerCheckbox);
          await tester.pumpAndSettle();
          playerVisible = true;
        } else {
          // Adjust scroll direction based on attempts for smooth scrolling
          await tester.drag(
            find.byType(Scrollable),
            scrollAttempts < 10 ? const Offset(0, -100) : const Offset(0, 50),
          );
          await tester.pumpAndSettle();
          scrollAttempts++;
        }
      }

      if (!playerVisible) {
        throw Exception('Could not locate player: $playerName');
      }
    }

    // Scroll to make 'Allen Turner' visible and tap the checkbox
    await scrollToPlayer('Allen Turner');

    // Scroll to make 'Luke Johnson' visible and tap the checkbox
    await scrollToPlayer('Luke Johnsen');

    // Click Start Game button
    final startGameButton = find.text('Start Game');
    await tester.tap(startGameButton);
    await tester.pumpAndSettle();

    // Verify the new game screen elements
    expect(find.text('New Game'), findsOneWidget);
    expect(find.text('Mark'), findsOneWidget);
    expect(find.text('Andersen'), findsOneWidget);
    expect(find.text('Harry'), findsOneWidget);
    expect(find.text('Christensen'), findsOneWidget);
    expect(find.text('Allen'), findsOneWidget);
    expect(find.text('Turner'), findsOneWidget);
    expect(find.text('Luke'), findsOneWidget);
    expect(find.text('Johnsen'), findsOneWidget);
    expect(
        find.text('0'), findsNWidgets(2)); // Expecting two '0's for the score
    expect(find.text('Pause'), findsOneWidget);

    // Start scoring goals
    int teamOneScore = 0;
    int teamTwoScore = 0;

    while (teamOneScore < 10 && teamTwoScore < 10) {
      String playerName = (teamOneScore <= teamTwoScore) ? "Mark" : "Allen";

      final playerIcon = find.byKey(Key("freehandGame$playerName"));
      await tester.tap(playerIcon);

      await tester.pump(const Duration(milliseconds: 500));

      if (playerName == "Mark") {
        teamOneScore++;
      } else {
        teamTwoScore++;
      }
    }

    // Wait for the MatchDetails screen to appear
    await tester.pumpAndSettle();

    // Final score verification
    expect(find.text('10'), findsOneWidget);
    expect(find.text('9'), findsOneWidget);

    // Verify player names are still visible
    expect(find.text('Mark'), findsOneWidget);
    expect(find.text('Andersen'), findsOneWidget);
    expect(find.text('Harry'), findsOneWidget);
    expect(find.text('Christensen'), findsOneWidget);
    expect(find.text('Allen'), findsOneWidget);
    expect(find.text('Turner'), findsOneWidget);
    expect(find.text('Luke'), findsOneWidget);
    expect(find.text('Johnsen'), findsOneWidget);

    expect(find.text('Match Report'), findsOneWidget);
    expect(find.text('Rematch'), findsOneWidget);
    expect(find.text('Close'), findsOneWidget);
  }, skip: true);

  testWidgets('verify create new league', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Open the sidebar by finding and tapping the hamburger menu button (or equivalent icon)
    final sidebarButton = find.byIcon(Icons.menu);
    await tester.tap(sidebarButton);
    await tester.pumpAndSettle();

    // Find and tap on the 'Leagues' option in the sidebar
    final leaguesOption = find.text('Leagues');
    await tester.tap(leaguesOption);
    await tester.pumpAndSettle();

    // Find and tap the 'Create new league' button
    final createNewLeagueButton = find.text('Create new league');
    await tester.tap(createNewLeagueButton);
    await tester.pumpAndSettle();

    // Find the `InputWidget` by its key, then locate the internal `TextField`
    final leagueNameWidget = find.byKey(const Key('leagueNameInput'));
    final leagueNameField = find.descendant(
      of: leagueNameWidget,
      matching: find.byType(TextField),
    );
    expect(leagueNameField, findsOneWidget);

    // Enter a name for the league
    await tester.enterText(leagueNameField, 'Test League');
    await tester.pumpAndSettle();

    // Find and tap the 'Create' button
    final createButton = find.text('Create');
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    // Verify that the league was created
    expect(find.text('Add Players'), findsOneWidget);

    Future<void> selectPlayerByKeyFirstPlayer(String userId) async {
      final playerKey =
          Key('player_$userId'); // Generate the key for the player
      final playerTile = find.byKey(playerKey);

      bool playerVisible = false;
      int scrollAttempts = 0;

      // Scrollable widget finder (target the specific scrollable list)
      final scrollableFinder = find.byKey(const Key('playerListScroll'));

      // Scroll to the top before attempting to find the player
      if (scrollAttempts == 0) {
        await tester.drag(
            scrollableFinder, const Offset(0, 1000)); // Reset to top
        await tester.pumpAndSettle();
      }

      while (!playerVisible && scrollAttempts < 20) {
        if (playerTile.evaluate().isNotEmpty) {
          // If the player is visible, locate and tap their checkbox
          final playerCheckbox = find.descendant(
            of: playerTile,
            matching: find.byType(Checkbox),
          );
          await tester.tap(playerCheckbox);
          await tester.pumpAndSettle();
          playerVisible = true;
        } else {
          // Scroll down to find the player
          await tester.drag(
            scrollableFinder,
            const Offset(0, 100), // Scroll downward by 100 pixels each time
          );
          await tester.pumpAndSettle();
          scrollAttempts++;
        }
      }

      if (!playerVisible) {
        throw Exception('Could not locate player with userId: $userId');
      }
    }

    Future<void> selectPlayerByKey(String userId) async {
      final playerKey =
          Key('player_$userId'); // Generate the key for the player
      final playerTile = find.byKey(playerKey);

      bool playerVisible = false;
      int scrollAttempts = 0;

      // Scrollable widget finder (target the specific scrollable list)
      final scrollableFinder = find.byKey(const Key('playerListScroll'));

      // Start by scrolling to the top of the list (optional, depends on your test setup)
      await tester.drag(scrollableFinder,
          const Offset(0, -1000)); // Scroll downwards to start
      await tester.pumpAndSettle();

      // Keep scrolling down until the player is found or max attempts reached
      while (!playerVisible && scrollAttempts < 20) {
        if (playerTile.evaluate().isNotEmpty) {
          // If the player is visible, locate and tap their checkbox
          final playerCheckbox = find.descendant(
            of: playerTile,
            matching: find.byType(Checkbox),
          );
          await tester.tap(playerCheckbox);
          await tester.pumpAndSettle();
          playerVisible = true;
        } else {
          // Scroll down to find the player (use positive Y offset to scroll down)
          await tester.drag(
            scrollableFinder,
            const Offset(0, 100), // Scroll downward by 100 pixels each time
          );
          await tester.pumpAndSettle();
          scrollAttempts++;
        }
      }

      if (!playerVisible) {
        throw Exception('Could not locate player with userId: $userId');
      }
    }

    // Select specific players by their user IDs
    await selectPlayerByKeyFirstPlayer('107'); // Luke Johnsen
    await selectPlayerByKey('108'); // John Roysen
    await selectPlayerByKey('111'); // Paul Petersen

    // Verify that the selected players are visible
    expect(find.byKey(const Key('selectedPlayer_107')), findsOneWidget);
    expect(find.byKey(const Key('selectedPlayer_108')), findsOneWidget);
    expect(find.byKey(const Key('selectedPlayer_111')), findsOneWidget);

    // Tap the 'Start League' button at the bottom of the screen
    final startLeagueButton = find.text('Start League');
    await tester.tap(startLeagueButton);
    await tester.pumpAndSettle();

    // add waiting here
    // **Add waiting here**
    await tester.pumpAndSettle(const Duration(seconds: 15));

    // Verify that the 3 tabs are visible after starting the league
    expect(find.byKey(const Key('tab_standings')), findsOneWidget);
    expect(find.byKey(const Key('tab_my_fixtures')), findsOneWidget);
    expect(find.byKey(const Key('tab_all_fixtures')), findsOneWidget);

    // Verify the league standings table is visible
    expect(find.byKey(const Key('leagueStandingsTable')), findsOneWidget);

    // Optionally, verify the headers or specific rows
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Pts'), findsOneWidget);
  }, skip: false);

  testWidgets('verify play first game of Test League', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Open the sidebar by finding and tapping the hamburger menu button
    final sidebarButton = find.byIcon(Icons.menu);
    await tester.tap(sidebarButton);
    await tester.pumpAndSettle();

    // Find and tap on the 'Leagues' option in the sidebar
    final leaguesOption = find.text('Leagues');
    await tester.tap(leaguesOption);
    await tester.pumpAndSettle();

    // Find and tap on the league named 'Test League'
    final testLeague = find.text('Test League');
    await tester.tap(testLeague);
    await tester.pumpAndSettle();

    // Find and tap on the 'My Fixtures' tab
    final myFixturesTab = find.byKey(const Key('tab_my_fixtures'));
    await tester.tap(myFixturesTab);
    await tester.pumpAndSettle();

    // Find and tap on the first match in the My Fixtures list
    final firstMatch = find.byKey(const Key('match_5'));
    expect(firstMatch, findsOneWidget,
        reason: "First match not found in My Fixtures.");
    await tester.tap(firstMatch);
    await tester.pumpAndSettle();

    // Verify that two 0's are visible on the screen
    final zeroCount = find.text('0');
    expect(zeroCount, findsNWidgets(2),
        reason: "Two '0' values should be visible.");

    // Find and tap the 'Start Game' button
    final startSingleLeagueGameButton =
        find.byKey(const Key('single_league_button_start_game'));
    expect(startSingleLeagueGameButton, findsOneWidget,
        reason: "'Start Game' button not found.");
    await tester.tap(startSingleLeagueGameButton);
    await tester.pumpAndSettle();

    // Simulate the match score: 10 - 5 for player one
    int playerOneScore = 0;
    int playerTwoScore = 0;

    final playerOneKey = find.byKey(const Key('sl_match_player_one'));
    final playerTwoKey = find.byKey(const Key('sl_match_player_two'));

    while (playerOneScore < 10 || playerTwoScore < 5) {
      if (playerOneScore < 10) {
        await tester.tap(playerOneKey);
        playerOneScore++;
      }

      if (playerTwoScore < 5) {
        await tester.tap(playerTwoKey);
        playerTwoScore++;
      }

      await tester.pump(const Duration(milliseconds: 500));
    }

    // Wait for the screen to update after player one's score reaches 10
    await tester.pumpAndSettle();

    // Verify the final score is 10 - 5
    expect(find.text('10'), findsOneWidget,
        reason: "Player one score should be 10.");
    expect(find.text('5'), findsOneWidget,
        reason: "Player two score should be 5.");
  }, skip: false);

  testWidgets('verify if first game is correct', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Open the sidebar by finding and tapping the hamburger menu button
    final sidebarButton = find.byIcon(Icons.menu);
    await tester.tap(sidebarButton);
    await tester.pumpAndSettle();

    // Find and tap on the 'Leagues' option in the sidebar
    final leaguesOption = find.text('Leagues');
    await tester.tap(leaguesOption);
    await tester.pumpAndSettle();

    // Find and tap on the league named 'Test League'
    final testLeague = find.text('Test League');
    await tester.tap(testLeague);
    await tester.pumpAndSettle();

    // Find and tap on the 'My Fixtures' tab
    final myFixturesTab = find.byKey(const Key('tab_my_fixtures'));
    await tester.tap(myFixturesTab);
    await tester.pumpAndSettle();

    final tenFive = find.textContaining('10-5');

    // Check if the title is visible
    expect(tenFive, findsOneWidget, reason: "10-5 text not found.");
  }, skip: false);

  testWidgets('verify play second game of Test League', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Open the sidebar by finding and tapping the hamburger menu button
    final sidebarButton = find.byIcon(Icons.menu);
    await tester.tap(sidebarButton);
    await tester.pumpAndSettle();

    // Find and tap on the 'Leagues' option in the sidebar
    final leaguesOption = find.text('Leagues');
    await tester.tap(leaguesOption);
    await tester.pumpAndSettle();

    // Find and tap on the league named 'Test League'
    final testLeague = find.text('Test League');
    await tester.tap(testLeague);
    await tester.pumpAndSettle();

    // Find and tap on the 'My Fixtures' tab
    final myFixturesTab = find.byKey(const Key('tab_my_fixtures'));
    await tester.tap(myFixturesTab);
    await tester.pumpAndSettle();

    // Find and tap on the first match in the My Fixtures list
    final firstMatch = find.byKey(const Key('match_5'));
    expect(firstMatch, findsOneWidget,
        reason: "First match not found in My Fixtures.");
    await tester.tap(firstMatch);
    await tester.pumpAndSettle();

    // Verify that two 0's are visible on the screen
    final zeroCount = find.text('0');
    expect(zeroCount, findsNWidgets(2),
        reason: "Two '0' values should be visible.");

    // Find and tap the 'Start Game' button
    final startSingleLeagueGameButton =
        find.byKey(const Key('single_league_button_start_game'));
    expect(startSingleLeagueGameButton, findsOneWidget,
        reason: "'Start Game' button not found.");
    await tester.tap(startSingleLeagueGameButton);
    await tester.pumpAndSettle();

    // Simulate the match score: 10 - 3 for player one
    int playerOneScore = 0;
    int playerTwoScore = 0;

    final playerOneKey = find.byKey(const Key('sl_match_player_one'));
    final playerTwoKey = find.byKey(const Key('sl_match_player_two'));

    while (playerOneScore < 10 || playerTwoScore < 3) {
      if (playerOneScore < 10) {
        await tester.tap(playerOneKey);
        playerOneScore++;
      }

      if (playerTwoScore < 3) {
        await tester.tap(playerTwoKey);
        playerTwoScore++;
      }

      await tester.pump(const Duration(milliseconds: 500));
    }

    // Wait for the screen to update after player one's score reaches 10
    await tester.pumpAndSettle();

    // Verify the final score is 10 - 3
    expect(find.text('10'), findsOneWidget,
        reason: "Player one score should be 10.");
    expect(find.text('3'), findsOneWidget,
        reason: "Player two score should be 3.");
  }, skip: false);

  testWidgets('verify if second game is correct', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Open the sidebar by finding and tapping the hamburger menu button
    final sidebarButton = find.byIcon(Icons.menu);
    await tester.tap(sidebarButton);
    await tester.pumpAndSettle();

    // Find and tap on the 'Leagues' option in the sidebar
    final leaguesOption = find.text('Leagues');
    await tester.tap(leaguesOption);
    await tester.pumpAndSettle();

    // Find and tap on the league named 'Test League'
    final testLeague = find.text('Test League');
    await tester.tap(testLeague);
    await tester.pumpAndSettle();

    // Find and tap on the 'My Fixtures' tab
    final myFixturesTab = find.byKey(const Key('tab_my_fixtures'));
    await tester.tap(myFixturesTab);
    await tester.pumpAndSettle();

    final tenFive = find.textContaining('10-3');

    // Check if the title is visible
    expect(tenFive, findsOneWidget, reason: "10-3 text not found.");
  }, skip: false);

  testWidgets('verify play third game of Test League', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Open the sidebar by finding and tapping the hamburger menu button
    final sidebarButton = find.byIcon(Icons.menu);
    await tester.tap(sidebarButton);
    await tester.pumpAndSettle();

    // Find and tap on the 'Leagues' option in the sidebar
    final leaguesOption = find.text('Leagues');
    await tester.tap(leaguesOption);
    await tester.pumpAndSettle();

    // Find and tap on the league named 'Test League'
    final testLeague = find.text('Test League');
    await tester.tap(testLeague);
    await tester.pumpAndSettle();

    // Find and tap on the 'My Fixtures' tab
    final myFixturesTab = find.byKey(const Key('tab_my_fixtures'));
    await tester.tap(myFixturesTab);
    await tester.pumpAndSettle();

    // Find and tap on the first match in the My Fixtures list
    final firstMatch = find.byKey(const Key('match_5'));
    expect(firstMatch, findsOneWidget,
        reason: "First match not found in My Fixtures.");
    await tester.tap(firstMatch);
    await tester.pumpAndSettle();

    // Verify that two 0's are visible on the screen
    final zeroCount = find.text('0');
    expect(zeroCount, findsNWidgets(2),
        reason: "Two '0' values should be visible.");

    // Find and tap the 'Start Game' button
    final startSingleLeagueGameButton =
        find.byKey(const Key('single_league_button_start_game'));
    expect(startSingleLeagueGameButton, findsOneWidget,
        reason: "'Start Game' button not found.");
    await tester.tap(startSingleLeagueGameButton);
    await tester.pumpAndSettle();

    // Simulate the match score: 10 - 3 for player one
    int playerOneScore = 0;
    int playerTwoScore = 0;

    final playerOneKey = find.byKey(const Key('sl_match_player_one'));
    final playerTwoKey = find.byKey(const Key('sl_match_player_two'));

    while (playerOneScore < 10 || playerTwoScore < 2) {
      if (playerOneScore < 10) {
        await tester.tap(playerOneKey);
        playerOneScore++;
      }

      if (playerTwoScore < 2) {
        await tester.tap(playerTwoKey);
        playerTwoScore++;
      }

      await tester.pump(const Duration(milliseconds: 500));
    }

    // Wait for the screen to update after player one's score reaches 10
    await tester.pumpAndSettle();

    // Verify the final score is 10 - 3
    expect(find.text('10'), findsOneWidget,
        reason: "Player one score should be 10.");
    expect(find.text('2'), findsOneWidget,
        reason: "Player two score should be 2.");
  }, skip: false);

  testWidgets('verify if third game is correct', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Open the sidebar by finding and tapping the hamburger menu button
    final sidebarButton = find.byIcon(Icons.menu);
    await tester.tap(sidebarButton);
    await tester.pumpAndSettle();

    // Find and tap on the 'Leagues' option in the sidebar
    final leaguesOption = find.text('Leagues');
    await tester.tap(leaguesOption);
    await tester.pumpAndSettle();

    // Find and tap on the league named 'Test League'
    final testLeague = find.text('Test League');
    await tester.tap(testLeague);
    await tester.pumpAndSettle();

    // Find and tap on the 'My Fixtures' tab
    final myFixturesTab = find.byKey(const Key('tab_my_fixtures'));
    await tester.tap(myFixturesTab);
    await tester.pumpAndSettle();

    final tenFive = find.textContaining('10-2');

    // Check if the title is visible
    expect(tenFive, findsOneWidget, reason: "10-2 text not found.");
  }, skip: false);

  testWidgets('verify play fourth game of Test League', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Open the sidebar by finding and tapping the hamburger menu button
    final sidebarButton = find.byIcon(Icons.menu);
    await tester.tap(sidebarButton);
    await tester.pumpAndSettle();

    // Find and tap on the 'Leagues' option in the sidebar
    final leaguesOption = find.text('Leagues');
    await tester.tap(leaguesOption);
    await tester.pumpAndSettle();

    // Find and tap on the league named 'Test League'
    final testLeague = find.text('Test League');
    await tester.tap(testLeague);
    await tester.pumpAndSettle();

    // Find and tap on the 'My Fixtures' tab
    final myFixturesTab = find.byKey(const Key('tab_my_fixtures'));
    await tester.tap(myFixturesTab);
    await tester.pumpAndSettle();

    // Find and tap on the first match in the My Fixtures list
    final firstMatch = find.byKey(const Key('match_5'));
    expect(firstMatch, findsOneWidget,
        reason: "First match not found in My Fixtures.");
    await tester.tap(firstMatch);
    await tester.pumpAndSettle();

    // Verify that two 0's are visible on the screen
    final zeroCount = find.text('0');
    expect(zeroCount, findsNWidgets(2),
        reason: "Two '0' values should be visible.");

    // Find and tap the 'Start Game' button
    final startSingleLeagueGameButton =
        find.byKey(const Key('single_league_button_start_game'));
    expect(startSingleLeagueGameButton, findsOneWidget,
        reason: "'Start Game' button not found.");
    await tester.tap(startSingleLeagueGameButton);
    await tester.pumpAndSettle();

    // Simulate the match score: 10 - 3 for player one
    int playerOneScore = 0;
    int playerTwoScore = 0;

    final playerOneKey = find.byKey(const Key('sl_match_player_one'));
    final playerTwoKey = find.byKey(const Key('sl_match_player_two'));

    while (playerOneScore < 10 || playerTwoScore < 1) {
      if (playerOneScore < 10) {
        await tester.tap(playerOneKey);
        playerOneScore++;
      }

      if (playerTwoScore < 1) {
        await tester.tap(playerTwoKey);
        playerTwoScore++;
      }

      await tester.pump(const Duration(milliseconds: 500));
    }

    // Wait for the screen to update after player one's score reaches 10
    await tester.pumpAndSettle();

    // Verify the final score is 10 - 3
    expect(find.text('10'), findsOneWidget,
        reason: "Player one score should be 10.");
    expect(find.text('1'), findsOneWidget,
        reason: "Player two score should be 1.");
  }, skip: false);

  testWidgets('verify if fourth game is correct', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Open the sidebar by finding and tapping the hamburger menu button
    final sidebarButton = find.byIcon(Icons.menu);
    await tester.tap(sidebarButton);
    await tester.pumpAndSettle();

    // Find and tap on the 'Leagues' option in the sidebar
    final leaguesOption = find.text('Leagues');
    await tester.tap(leaguesOption);
    await tester.pumpAndSettle();

    // Find and tap on the league named 'Test League'
    final testLeague = find.text('Test League');
    await tester.tap(testLeague);
    await tester.pumpAndSettle();

    // Find and tap on the 'My Fixtures' tab
    final myFixturesTab = find.byKey(const Key('tab_my_fixtures'));
    await tester.tap(myFixturesTab);
    await tester.pumpAndSettle();

    final tenFive = find.textContaining('10-1');

    // Check if the title is visible
    expect(tenFive, findsOneWidget, reason: "10-1 text not found.");
  }, skip: false);

  testWidgets('verify play fifth game of Test League', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Open the sidebar by finding and tapping the hamburger menu button
    final sidebarButton = find.byIcon(Icons.menu);
    await tester.tap(sidebarButton);
    await tester.pumpAndSettle();

    // Find and tap on the 'Leagues' option in the sidebar
    final leaguesOption = find.text('Leagues');
    await tester.tap(leaguesOption);
    await tester.pumpAndSettle();

    // Find and tap on the league named 'Test League'
    final testLeague = find.text('Test League');
    await tester.tap(testLeague);
    await tester.pumpAndSettle();

    // Find and tap on the 'My Fixtures' tab
    final myFixturesTab = find.byKey(const Key('tab_my_fixtures'));
    await tester.tap(myFixturesTab);
    await tester.pumpAndSettle();

    // Find and tap on the first match in the My Fixtures list
    final firstMatch = find.byKey(const Key('match_5'));
    expect(firstMatch, findsOneWidget,
        reason: "First match not found in My Fixtures.");
    await tester.tap(firstMatch);
    await tester.pumpAndSettle();

    // Verify that two 0's are visible on the screen
    final zeroCount = find.text('0');
    expect(zeroCount, findsNWidgets(2),
        reason: "Two '0' values should be visible.");

    // Find and tap the 'Start Game' button
    final startSingleLeagueGameButton =
        find.byKey(const Key('single_league_button_start_game'));
    expect(startSingleLeagueGameButton, findsOneWidget,
        reason: "'Start Game' button not found.");
    await tester.tap(startSingleLeagueGameButton);
    await tester.pumpAndSettle();

    // Simulate the match score: 10 - 3 for player one
    int playerOneScore = 0;
    int playerTwoScore = 0;

    final playerOneKey = find.byKey(const Key('sl_match_player_one'));
    final playerTwoKey = find.byKey(const Key('sl_match_player_two'));

    while (playerOneScore < 10 || playerTwoScore < 4) {
      if (playerOneScore < 10) {
        await tester.tap(playerOneKey);
        playerOneScore++;
      }

      if (playerTwoScore < 4) {
        await tester.tap(playerTwoKey);
        playerTwoScore++;
      }

      await tester.pump(const Duration(milliseconds: 500));
    }

    // Wait for the screen to update after player one's score reaches 10
    await tester.pumpAndSettle();

    // Verify the final score is 10 - 3
    expect(find.text('10'), findsOneWidget,
        reason: "Player one score should be 10.");
    expect(find.text('4'), findsOneWidget,
        reason: "Player two score should be 4.");
  }, skip: false);

  testWidgets('verify if fifth game is correct', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Open the sidebar by finding and tapping the hamburger menu button
    final sidebarButton = find.byIcon(Icons.menu);
    await tester.tap(sidebarButton);
    await tester.pumpAndSettle();

    // Find and tap on the 'Leagues' option in the sidebar
    final leaguesOption = find.text('Leagues');
    await tester.tap(leaguesOption);
    await tester.pumpAndSettle();

    // Find and tap on the league named 'Test League'
    final testLeague = find.text('Test League');
    await tester.tap(testLeague);
    await tester.pumpAndSettle();

    // Find and tap on the 'My Fixtures' tab
    final myFixturesTab = find.byKey(const Key('tab_my_fixtures'));
    await tester.tap(myFixturesTab);
    await tester.pumpAndSettle();

    final tenFive = find.textContaining('10-4');

    // Check if the title is visible
    expect(tenFive, findsOneWidget, reason: "10-4 text not found.");
  }, skip: false);

  testWidgets('verify play sixth game of Test League', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Open the sidebar by finding and tapping the hamburger menu button
    final sidebarButton = find.byIcon(Icons.menu);
    await tester.tap(sidebarButton);
    await tester.pumpAndSettle();

    // Find and tap on the 'Leagues' option in the sidebar
    final leaguesOption = find.text('Leagues');
    await tester.tap(leaguesOption);
    await tester.pumpAndSettle();

    // Find and tap on the league named 'Test League'
    final testLeague = find.text('Test League');
    await tester.tap(testLeague);
    await tester.pumpAndSettle();

    // Find and tap on the 'My Fixtures' tab
    final myFixturesTab = find.byKey(const Key('tab_my_fixtures'));
    await tester.tap(myFixturesTab);
    await tester.pumpAndSettle();

    // Find and tap on the first match in the My Fixtures list
    final firstMatch = find.byKey(const Key('match_5'));
    expect(firstMatch, findsOneWidget,
        reason: "First match not found in My Fixtures.");
    await tester.tap(firstMatch);
    await tester.pumpAndSettle();

    // Verify that two 0's are visible on the screen
    final zeroCount = find.text('0');
    expect(zeroCount, findsNWidgets(2),
        reason: "Two '0' values should be visible.");

    // Find and tap the 'Start Game' button
    final startSingleLeagueGameButton =
        find.byKey(const Key('single_league_button_start_game'));
    expect(startSingleLeagueGameButton, findsOneWidget,
        reason: "'Start Game' button not found.");
    await tester.tap(startSingleLeagueGameButton);
    await tester.pumpAndSettle();

    // Simulate the match score: 10 - 3 for player one
    int playerOneScore = 0;
    int playerTwoScore = 0;

    final playerOneKey = find.byKey(const Key('sl_match_player_one'));
    final playerTwoKey = find.byKey(const Key('sl_match_player_two'));

    while (playerOneScore < 10 || playerTwoScore < 6) {
      if (playerOneScore < 10) {
        await tester.tap(playerOneKey);
        playerOneScore++;
      }

      if (playerTwoScore < 6) {
        await tester.tap(playerTwoKey);
        playerTwoScore++;
      }

      await tester.pump(const Duration(milliseconds: 500));
    }

    // Wait for the screen to update after player one's score reaches 10
    await tester.pumpAndSettle();

    // Verify the final score is 10 - 3
    expect(find.text('10'), findsOneWidget,
        reason: "Player one score should be 10.");
    expect(find.text('6'), findsOneWidget,
        reason: "Player two score should be 6.");
  }, skip: false);

  testWidgets('verify if sixth game is correct', (tester) async {
    // Start the app
    app.main();
    await tester.pumpAndSettle();

    // Open the sidebar by finding and tapping the hamburger menu button
    final sidebarButton = find.byIcon(Icons.menu);
    await tester.tap(sidebarButton);
    await tester.pumpAndSettle();

    // Find and tap on the 'Leagues' option in the sidebar
    final leaguesOption = find.text('Leagues');
    await tester.tap(leaguesOption);
    await tester.pumpAndSettle();

    // Find and tap on the league named 'Test League'
    final testLeague = find.text('Test League');
    await tester.tap(testLeague);
    await tester.pumpAndSettle();

    // Find and tap on the 'My Fixtures' tab
    final myFixturesTab = find.byKey(const Key('tab_my_fixtures'));
    await tester.tap(myFixturesTab);
    await tester.pumpAndSettle();

    final tenFive = find.textContaining('10-6');

    // Check if the title is visible
    expect(tenFive, findsOneWidget, reason: "10-6 text not found.");
  }, skip: false);
}

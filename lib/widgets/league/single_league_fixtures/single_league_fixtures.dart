import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/SingleLeagueMatchApi.dart';
import 'package:foosball_mobile_app/models/single-league-matches/single_league_match_model.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';

class SingleLeagueFixtures extends StatefulWidget {
  final UserState userState;
  final int leagueId;
  const SingleLeagueFixtures(
      {super.key, required this.userState, required this.leagueId});

  @override
  State<SingleLeagueFixtures> createState() => _SingleLeagueFixturesState();
}

class _SingleLeagueFixturesState extends State<SingleLeagueFixtures> {
  late Future<List<SingleLeagueMatchModel>?> _future;

  @override
  void initState() {
    super.initState();
    _future = SingleLeagueMatchApi()
        .getAllSingleLeagueMatchesByLeagueId(widget.leagueId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SingleLeagueMatchModel>?>(
      future: _future,
      builder: (BuildContext context,
          AsyncSnapshot<List<SingleLeagueMatchModel>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }
        if (snapshot.hasData) {
          List<SingleLeagueMatchModel>? data = snapshot.data;
          return ListView.builder(
            itemCount: data?.length,
            itemBuilder: (BuildContext context, int index) {
              SingleLeagueMatchModel? match = data?[index];
              return ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(match?.playerOnePhotoUrl ?? ''),
                    ),
                    SizedBox(width: 16),
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(match?.playerTwoPhotoUrl ?? ''),
                    ),
                  ],
                ),
                title: Text(
                  '${match?.playerOneFirstName ?? 'No first name'} ${match?.playerOneLastName ?? 'No last name'} vs ${match?.playerTwoFirstName ?? 'No first name'} ${match?.playerTwoLastName ?? 'No last name'}',
                ),
                subtitle: Text('A strong animal'),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Text('No data found');
        }
      },
    );
  }
}


// ListTile(
//                 contentPadding: const EdgeInsets.symmetric(vertical: 8),
//                 title: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Image.network(
//                             match?.playerOnePhotoUrl ?? '',
//                             width: 40,
//                             height: 40,
//                           ),
//                           Text(
//                             '${match?.playerOneFirstName ?? 'No first name'} ${match?.playerOneLastName ?? 'No last name'}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(
//                             '${match?.playerTwoFirstName ?? 'No first name'} ${match?.playerTwoLastName ?? 'No last name'}',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           Image.network(
//                             match?.playerTwoPhotoUrl ?? '',
//                             width: 40,
//                             height: 40,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
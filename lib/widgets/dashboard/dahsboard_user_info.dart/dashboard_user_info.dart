import 'package:flutter/material.dart';
import 'package:foosball_mobile_app/api/Organisation.dart';
import 'package:foosball_mobile_app/api/UserApi.dart';
import 'package:foosball_mobile_app/models/organisation/organisation_response.dart';
import 'package:foosball_mobile_app/models/user/user_response.dart';
import 'package:foosball_mobile_app/state/user_state.dart';
import 'package:foosball_mobile_app/widgets/loading.dart';

class DashBoardUserInfo extends StatefulWidget {
  final UserState userState;
  const DashBoardUserInfo({Key? key, required this.userState})
      : super(key: key);

  @override
  State<DashBoardUserInfo> createState() => _DashBoardUserInfoState();
}

class _DashBoardUserInfoState extends State<DashBoardUserInfo> {
  late Future<Map<String, dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = loadData();
  }

  Future<Map<String, dynamic>> loadData() async {
    final userId = widget.userState.userId.toString();
    final orgId = widget.userState.currentOrganisationId!;
    try {
      final userData = await UserApi().getUser(userId);
      final orgData = await Organisation().getOrganisationById(orgId);
      widget.userState.setUserInfoGlobalObject(userData.id, userData.firstName,
          userData.lastName, userData.email, orgData!.id, orgData.name);
      return {'user': userData, 'org': orgData};
    } catch (error) {
      throw Exception('Failed to load user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: Loading(
            userState: widget.userState,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final userData = snapshot.data!['user'] as UserResponse;
          final orgData = snapshot.data!['org'] as OrganisationResponse;
          return Card(
            // elevation: 5,
            child: ListTile(
              leading: const Icon(Icons.email, color: Colors.grey),
              title: Text('${userData.firstName} ${userData.lastName}'),
              subtitle: Text(userData.email),
              trailing: Text(orgData.name),
            ),
          );
        }
      },
    );
  }
}

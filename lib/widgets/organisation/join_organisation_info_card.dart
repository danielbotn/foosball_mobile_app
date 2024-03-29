import 'package:flutter/material.dart';

import '../../state/user_state.dart';

class JoinOrganisationInfoCard extends StatelessWidget {
  final UserState userState;
  const JoinOrganisationInfoCard({Key? key, required this.userState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Ink.image(
                image: const NetworkImage(
                  'https://images.unsplash.com/photo-1629128625414-374a9e16d56a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                ),
                height: 240,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: Text(
                  userState.hardcodedStrings.joinExistingOrganisationWithQrCode,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            child: Text(
              userState.hardcodedStrings.organisationCardInfo,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              OutlinedButton(
                child: Text(userState.hardcodedStrings.scanQrCode),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}

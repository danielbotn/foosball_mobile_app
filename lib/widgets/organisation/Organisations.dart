import 'package:flutter/material.dart';

import '../../state/user_state.dart';

class Organisations extends StatefulWidget {
  final UserState userState;
  const Organisations({Key? key, required this.userState}) : super(key: key);

  @override
  State<Organisations> createState() => _OrganisationsState();
}

class _OrganisationsState extends State<Organisations> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

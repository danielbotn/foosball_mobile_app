class UserInfoGlobal {
  final int userId;
  final String firstName;
  final String lastName;
  final String email;
  final int currentOrganisationId;
  final String currentOrganisationName;

  UserInfoGlobal(
      {required this.userId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.currentOrganisationId,
      required this.currentOrganisationName});
}

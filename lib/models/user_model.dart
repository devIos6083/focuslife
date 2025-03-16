class UserModel {
  final String name;
  final List<int?> answers;

  const UserModel({
    required this.name,
    required this.answers,
  });

  // Helper getters for common user data
  int? get jobTypeIndex => answers.isNotEmpty ? answers[0] : null;
  int? get employmentTypeIndex => answers.length > 1 ? answers[1] : null;
  int? get issueTypeIndex => answers.length > 2 ? answers[2] : null;
  int? get attendanceFrequencyIndex => answers.length > 3 ? answers[3] : null;
}

class Kid {
  final DateTime? birthDay;
  final String? gender;
  final String? name;
  final String? urlAvatar;
  final String? userId;

  Kid({this.birthDay, this.gender, this.name, this.urlAvatar, this.userId});

  String? getName() => name;
  String? getUrlAvatar() => urlAvatar;
  DateTime? getBirthDay() => birthDay;
  String? getGender() => gender;
  String? getUserId() => userId;
}

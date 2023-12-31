class Active {
  final String? name;
  final String? urlImg;
  final String? date;
  final int? startHour;
  final int? startMinute;
  final int? endHour;
  final int? endMinute;
  final String? activeId;
  final Function onDelete;
  final int? seconds;

  Active(this.name, this.urlImg, this.date, this.startHour, this.startMinute, this.activeId,
      this.onDelete, this.endHour, this.endMinute, this.seconds);

  String? getActiveId() => activeId;
  String? getName() => name;
  String? getUrlImg() => urlImg;
  String? getDate() => date;
  int? getStartHour() => startHour;
  int? getStartMinute() => startMinute;
  int? getEndHour() => endHour;
  int? getEndMinute() => endMinute;
  int? getSeconds() => seconds;
  Function getDelete() => onDelete;
}

class Active{
  final String? name;
  final String? urlImg;
  final String? date;
  final int? startHour;
  final int? startMinute;
  final String? activeId;
  final Function onDelete;

  Active(this.name, this.urlImg, this.date, this.startHour, this.startMinute, this.activeId, this.onDelete);

  String? getActiveId() => activeId;
  String? getName() => name;
  String? getUrlImg() => urlImg;
  String? getDate() => date;
  int? getStartHour()=> startHour;
  int? getStartMinute() => startMinute;
  Function getDelete()=> onDelete;
}
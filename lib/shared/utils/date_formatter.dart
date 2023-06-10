class DateFormatter{
  bool isToday(DateTime dateTime) {
    DateTime currentDate = DateTime.now();
    return dateTime.year == currentDate.year &&
        dateTime.month == currentDate.month &&
        dateTime.day == currentDate.day;
  }

  bool isYesterday(DateTime dateTime) {
    DateTime currentDate = DateTime.now();
    return dateTime.year == currentDate.year &&
        dateTime.month == currentDate.month &&
        dateTime.day == currentDate.day - 1;
  }

  String formatHour(DateTime dateTime) {
    String formattedHour = dateTime.hour.toString().padLeft(2, '0');
    String formattedMinute = dateTime.minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute';
  }

  String formatDate(DateTime dateTime) {
    DateTime currentDate = DateTime.now();
    int currentYear = currentDate.year;
    String formattedDay = dateTime.day.toString().padLeft(2, '0');
    String formattedMonth = dateTime.month.toString().padLeft(2, '0');
    String formattedYear = (dateTime.year % 100).toString().padLeft(2, '0');
    return '$formattedDay/$formattedMonth/$formattedYear';
  }

  String currTime(){
    return DateTime.now().toString();
  }

}
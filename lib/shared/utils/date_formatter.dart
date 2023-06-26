/// The [DateFormatter] class that provides utility methods for formatting and checking dates.
class DateFormatter {
  /// Returns `true` if the given [dateTime] is today's date.
  ///
  /// The [dateTime] parameter is compared with the current date and time using `DateTime.now()`.
  /// If they match, the method returns `true`, indicating that the given date is today's date.
  /// Otherwise, it returns `false`.
  bool isToday(DateTime dateTime) {
    DateTime currentDate = DateTime.now();
    return dateTime.year == currentDate.year &&
        dateTime.month == currentDate.month &&
        dateTime.day == currentDate.day;
  }

  /// Returns `true` if the given [dateTime] is yesterday's date.
  ///
  /// The [dateTime] parameter is compared with the current date and time using `DateTime.now()`.
  /// If the year, month, and day of the given [dateTime] object match the year, month, and day of the current date minus one day,
  /// the method returns `true`, indicating that the given date is yesterday's date.
  /// Otherwise, it returns `false`.
  bool isYesterday(DateTime dateTime) {
    DateTime currentDate = DateTime.now();
    return dateTime.year == currentDate.year &&
        dateTime.month == currentDate.month &&
        dateTime.day == currentDate.day - 1;
  }

  /// Returns a formatted string of the hour and minute of the given [dateTime].
  ///
  /// The [dateTime] parameter is formatted as a string in the format `hh:mm`.
  /// The hour and minute are padded with a leading zero if necessary using `padLeft(2, '0')`.
  String formatHour(DateTime dateTime) {
    String formattedHour = dateTime.hour.toString().padLeft(2, '0');
    String formattedMinute = dateTime.minute.toString().padLeft(2, '0');
    return '$formattedHour:$formattedMinute';
  }

  /// Returns a formatted string of the date of the given [dateTime].
  ///
  /// The [dateTime] parameter is formatted as a string in the format `dd/mm/yy`.
  /// The day and month are padded with a leading zero if necessary using `padLeft(2, '0')`.
  /// The year is formatted as a string and takes the last two digits using `% 100`.
  /// The formatted string is returned.
  String formatDate(DateTime dateTime) {
    String formattedDay = dateTime.day.toString().padLeft(2, '0');
    String formattedMonth = dateTime.month.toString().padLeft(2, '0');
    String formattedYear = (dateTime.year % 100).toString().padLeft(2, '0');
    return '$formattedDay/$formattedMonth/$formattedYear';
  }

  /// Returns the current time as a string.
  ///
  /// The current date and time is obtained using `DateTime.now()`.
  /// The result is converted to a string using `toString()` and returned.
  String currTime() {
    return DateTime.now().toString();
  }
}

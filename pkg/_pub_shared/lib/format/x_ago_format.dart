/// Formats an [age] duration with `<amount> <unit> ago` or `in the last hour`.
String formatXAgo(Duration age) {
  if (age.inDays > 365 * 2) {
    final years = age.inDays ~/ 365;
    return '$years years ago';
  }
  if (age.inDays > 30 * 2) {
    final months = age.inDays ~/ 30;
    return '$months months ago';
  }
  if (age.inDays > 1) {
    return '${age.inDays} days ago';
  }
  if (age.inHours > 1) {
    return '${age.inHours} hours ago';
  }
  if (age.inHours == 1) {
    return '${age.inHours} hour ago';
  }
  return 'in the last hour';
}

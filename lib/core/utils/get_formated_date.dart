String getFormattedDateTime({required DateTime createdAt}) {
  // Extract hour and minute from the provided DateTime
  int hour = createdAt.hour;
  int minute = createdAt.minute;
  
  // Determine if the time is PM and adjust hour for 12-hour format
  String period = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12;
  hour = hour == 0 ? 12 : hour; // Convert hour '0' to '12'

  // Format minute to ensure two digits
  String formattedMinute = minute.toString().padLeft(2, '0');

  // Return the formatted string
  return '$hour:$formattedMinute $period';
}


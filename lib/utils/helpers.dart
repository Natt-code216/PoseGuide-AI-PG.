class Helpers {
  // Format a date to a readable string
  static String formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} "
        "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
  }

  // Calculate age from birth date
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // Truncate text to specified length
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  // Format double to one decimal place
  static String formatDouble(double value) {
    return value.toStringAsFixed(1);
  }

  // Generate placeholder image URL
  static String getPlaceholderImage(int width, int height, String text) {
    return 'assets/images/h.jpg';
  }
}

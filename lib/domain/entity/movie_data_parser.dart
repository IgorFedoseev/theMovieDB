DateTime? parseDateFromString(String? rawDate) {
  if (rawDate == null || rawDate.trim().isEmpty) return null;
  return DateTime.tryParse(rawDate);
}

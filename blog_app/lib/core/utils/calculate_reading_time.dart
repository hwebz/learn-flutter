int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;
  // Average reading time we supposed is 225 words per minute
  final readingTime = wordCount / 225;

  return readingTime.ceil();
}

int calculateReadTime(String content) {
  final wordCount = content.split(RegExp(' ')).length;
  final readingTime = wordCount / 225;
  return readingTime.ceil();
}

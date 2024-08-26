String formatDuration(dynamic duration) {
  int minutes = 0;
  int seconds = 0;

  if (duration is String) {
    List<String> parts = duration.split(':');
    if (parts.length == 2) {
      minutes = int.parse(parts[0]);
      seconds = int.parse(parts[1]);
    } else if (duration is Duration) {
      minutes = (duration as Duration).inMinutes.remainder(60);
      seconds = (duration as Duration).inSeconds.remainder(60);
    }
  }

  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

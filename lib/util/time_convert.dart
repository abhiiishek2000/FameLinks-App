String convertToAgo(DateTime input) {
  Duration diff = DateTime.now().difference(input);

  if (diff.inDays >= 1) {
    return '${diff.inDays} d ago';
  } else if (diff.inHours >= 1) {
    return '${diff.inHours} hr ago';
  } else if (diff.inMinutes >= 1) {
    return '${diff.inMinutes} mins ago';
  } else if (diff.inSeconds >= 1) {
    return '${diff.inSeconds} sec ago';
  } else {
    return 'just now';
  }
}
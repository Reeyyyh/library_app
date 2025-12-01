List<String> generateSearchKeywords(String judul) {
  List<String> keywords = [];
  List<String> words = judul.split(' ');

  for (String word in words) {
    for (int i = 0; i < word.length; i++) {
      for (int j = i + 1; j <= word.length; j++) {
        keywords.add(word.substring(i, j).toLowerCase());
      }
    }
  }

  for (int i = 0; i < judul.length; i++) {
    for (int j = i + 1; j <= judul.length; j++) {
      keywords.add(judul.substring(i, j).toLowerCase());
    }
  }

  return keywords.toSet().toList();
}
// merge
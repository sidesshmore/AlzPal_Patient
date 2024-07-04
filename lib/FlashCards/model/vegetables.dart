class Vegetables{
  final int qid;
  final String url;
  final String answer;
  final List<String> options;

  const Vegetables({required this.qid, required this.url, required this.answer, required this.options});

    List<String> get shuffledAnswers {
    final shuffledList = List.of(options);
    shuffledList.shuffle();
    return shuffledList;
  }
}
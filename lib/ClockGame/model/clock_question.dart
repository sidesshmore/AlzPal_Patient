class ClockQuestion{

  const ClockQuestion({required this.qid,required this.imageurl, required this.answer, required this.options});

  final int qid;
  final String imageurl;
  final String answer;
  final List<String>options;

  
    List<String> get shuffledAnswers {
    final shuffledList = List.of(options);
    shuffledList.shuffle();
    return shuffledList;
  }
}
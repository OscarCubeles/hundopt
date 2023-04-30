class PersonalityFormQuestion {
  final List<String> options;
  final String text;
  final String title;
  final int index;

  const PersonalityFormQuestion(this.index, {required this.title, required this.text, required this.options});
}
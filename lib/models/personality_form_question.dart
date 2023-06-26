/// A class representing a personality form question.
class PersonalityFormQuestion {
  /// The index of the question.
  final int index;

  /// The title of the question.
  final String title;

  /// The text of the question.
  final String text;

  /// The list of options for the question.
  final List<String> options;

  /// Creates a new instance of [PersonalityFormQuestion].
  ///
  /// The [index], [title], [text], and [options] parameters must not be null.
  const PersonalityFormQuestion(
    this.index, {
    required this.title,
    required this.text,
    required this.options,
  });
}

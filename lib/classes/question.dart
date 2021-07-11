class Question{
  int id;
  String text;
  int state;

  Question(this.id, this.text, this.state);

  @override
  String toString() {
    return 'Question{id: $id, text: $text, state: $state}';
  }
}
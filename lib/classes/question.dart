class Question{
  int id;
  String text;
  int state;
  String note;

  Question(this.id, this.text, this.state, this.note);

  @override
  String toString() {
    return 'Question{id: $id, text: $text, state: $state, note: $note}';
  }
}
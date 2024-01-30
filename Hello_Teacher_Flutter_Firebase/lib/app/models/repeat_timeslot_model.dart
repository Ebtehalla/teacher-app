// ignore: constant_identifier_names
enum Repeat { NOT_REPEAT, EVERY_DAY, SAME_DAY_EVERY_WEEK, SAME_DAY_EVERY_MONTH }

class RepeatTimeslot {
  String repeatText;
  Repeat repeat;
  RepeatTimeslot({
    required this.repeatText,
    required this.repeat,
  });
}

class RepeatDuration {
  int month;
  String monthText;
  RepeatDuration({
    required this.month,
    required this.monthText,
  });
}

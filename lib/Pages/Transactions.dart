import 'dart:async';

class Transactions {
  DateTime time_stamp;
  int num_correct;
  int num_incorrect;
  double percent;
  String grade;
  Duration exam_duration;

  Transactions(
      {required this.time_stamp,
      required this.num_correct,
      required this.num_incorrect,
      required this.percent,
      required this.grade,
      required this.exam_duration});

  Map<String, dynamic> toMap() {
    return {
      'time_stamp': time_stamp,
      'num_correct': num_correct,
      'num_incorrect': num_incorrect,
      'percent': percent,
      'grade': grade,
      'exam_duration': exam_duration,
    };
  }

  @override
  String toString() {
    return 'Transactions{time_stamp: $time_stamp, num_correct: $num_correct, num_incorrect: $num_incorrect, percent: $percent, grade: $grade, exam_duration: $exam_duration}';
  }
}

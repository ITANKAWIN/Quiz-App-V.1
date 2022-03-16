import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/Models/QuizModel.dart';
import 'package:quiz/Pages/Summary.dart';
import 'package:quiz/Pages/Transactions.dart';

class Quiz extends StatefulWidget {
  final String type;

  const Quiz({Key? key, required this.type}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  static const countdownDuration = Duration(minutes: 1);
  Duration duration = const Duration();
  Timer? timer;
  String asset_data = '';

  int no = 0;
  final int num_quiz = 5;
  List<int> sel_Choice = []; //คำตอบที่เลือก
  List<QuizModel> Quiz_List = []; //คำถาม
  List<String> Choice_List = []; //ตัวเลือกของคำถาม

  int num_correct = 0; // จำนวนที่ตอบถูก
  int num_incorrect = 0; // จำนวนที่ตอบผิด
  double percent = 0;
  String grade = 'F';
  Duration exam_duration = const Duration();

  void next_question() {
    no++;
  }

  void starttimer() {
    duration = countdownDuration;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (this.mounted) {
        setState(() {
          final seconds = duration.inSeconds - 1;

          if (seconds < 0) {
            timer?.cancel();
            check_Answer();
          } else {
            duration = Duration(seconds: seconds);
          }
        });
      }
    });
  }

  Widget buildTime() {
    String twodigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twodigits(duration.inMinutes.remainder(60));
    final seconds = twodigits(duration.inSeconds.remainder(60));

    return Text('$minutes:$seconds');
  }

  void check_Answer() {
    for (int i = 0; i < Quiz_List.length; i++) {
      if (Quiz_List[i].answerId == sel_Choice[i]) {
        num_correct++;
      } else {
        num_incorrect++;
      }
    }

    percent = num_correct * 100 / Quiz_List.length; //คำนวณเปอร์เซ็น

    // คำนวณเกรด
    if (percent >= 80) {
      grade = "A";
    } else if (percent >= 75) {
      grade = "B+";
    } else if (percent >= 70) {
      grade = "B";
    } else if (percent >= 65) {
      grade = "C+";
    } else if (percent >= 60) {
      grade = "C";
    } else if (percent >= 55) {
      grade = "D+";
    } else if (percent >= 50) {
      grade = "D";
    }

    exam_duration = countdownDuration - duration; //คำนวณเวลาที่ใช้

    print("ถูก $num_correct");
    print("ผิด $num_incorrect");
    print("เปอร์เซ็น $percent%");
    print("เวลาทั้งหมด $countdownDuration");
    print("เวลาที่เหลือ $duration");
    print("เกรด $grade");
    print("เวลาที่ทำ $exam_duration");

    Transactions data = Transactions(
        time_stamp: DateTime.now(),
        num_correct: num_correct,
        num_incorrect: num_incorrect,
        percent: percent,
        grade: grade,
        exam_duration: exam_duration);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Summary(type: widget.type, data: data),
      ),
    );
  }

  readJson() async {
    if (widget.type == 'Movie') {
      asset_data = 'assets/quiz/Movie.json';
    } else if (widget.type == 'Series') {
      asset_data = 'assets/quiz/Series.json';
    } else if (widget.type == 'Music') {
      asset_data = 'assets/quiz/Music.json';
    } else {
      asset_data = 'assets/quiz/Movie.json';
    }

    final String response = await DefaultAssetBundle.of(context)
        .loadString(asset_data, cache: false);
    setState(() {
      Quiz_List = quizModelFromJson(response);
    });

    random_choice();
  }

  random_choice() {
    // สุ่มข้อ
    Quiz_List.shuffle();

    for (int i = 0; i < Quiz_List.length; i++) {
      // สุ่มตัวเลือก
      Quiz_List[i].choice.shuffle();

      // สร้างคำตอบตามตัวเลือก
      sel_Choice.add(0);
    }
  }

  @override
  void initState() {
    super.initState();
    readJson();
    starttimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type),
        actions: <Widget>[
          ElevatedButton.icon(
            icon: const Icon(Icons.alarm),
            onPressed: () {},
            label: buildTime(),
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              shadowColor: Colors.transparent,
            ),
          ),
        ],
      ),
      body: sel_Choice.isEmpty || Quiz_List.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: num_quiz,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int no_quiz) {
                      return Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              '${no_quiz + 1}.โจทย์ ${Quiz_List[no_quiz].title}',
                              style: const TextStyle(
                                fontSize: 30,
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: Quiz_List[no_quiz].choice.length,
                            itemBuilder: (context, no_choice) {
                              return Column(
                                children: [
                                  ListTile(
                                    leading: Radio(
                                      value: int.parse(Quiz_List[no_quiz]
                                          .choice[no_choice]
                                          .id
                                          .toString()),
                                      groupValue: sel_Choice[no_quiz],
                                      onChanged: (int? value) {
                                        setState(() {
                                          sel_Choice[no_quiz] = value!;
                                        });
                                      },
                                    ),
                                    title: Text(
                                        '${Quiz_List[no_quiz].choice[no_choice].title}'),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          check_Answer();
        },
        tooltip: "ส่ง",
        child: const Icon(Icons.send),
      ),
    );
  }
}

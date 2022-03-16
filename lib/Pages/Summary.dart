import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quiz/Pages/Transactions.dart';
import 'package:quiz/Provider/db_provider.dart';

class Summary extends StatefulWidget {
  final String type;
  final Transactions data;
  const Summary(
      {Key? key, required String this.type, required Transactions this.data})
      : super(key: key);

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            SizedBox(
              height: 50,
              child: Table(
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  TableRow(
                    children: [
                      Column(
                        children: const [
                          Text(
                            'วันที่',
                            style: TextStyle(fontSize: 20.0),
                          )
                        ],
                      ),
                      Column(
                        children: const [
                          Text(
                            'จำนวนข้อที่ถูก',
                            style: TextStyle(fontSize: 20.0),
                          )
                        ],
                      ),
                      Column(
                        children: const [
                          Text(
                            'จำนวนข้อที่ผิด',
                            style: TextStyle(fontSize: 20.0),
                          )
                        ],
                      ),
                      Column(
                        children: const [
                          Text(
                            'เปอร์เซ็น',
                            style: TextStyle(fontSize: 20.0),
                          )
                        ],
                      ),
                      Column(
                        children: const [
                          Text(
                            'เวลาในการทำ',
                            style: TextStyle(fontSize: 20.0),
                          )
                        ],
                      ),
                    ],
                  ),
                  TableRow(
                    children: <Widget>[
                      Column(
                        children: [
                          Text(
                              widget.data.time_stamp
                                  .toString()
                                  .substring(0, 19),
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${widget.data.num_correct}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${widget.data.num_incorrect}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${widget.data.percent}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                              widget.data.exam_duration
                                  .toString()
                                  .substring(0, 7),
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(50),
            ),
            Center(
              child: CircularPercentIndicator(
                radius: 100.0,
                lineWidth: 20.0,
                animation: true,
                percent: widget.data.percent / 100,
                center: Text(
                  widget.data.grade,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 50.0),
                ),
                footer: const Text(
                  "คะแนนที่ทำได้",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: const Color.fromARGB(255, 10, 8, 160),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/summary_all');
                },
                child: const Text("ดูสรุปผลรวม"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

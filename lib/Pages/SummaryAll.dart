import 'package:flutter/material.dart';
import 'package:quiz/Pages/Transactions.dart';
import 'package:quiz/Provider/db_provider.dart';

class SummaryAll extends StatefulWidget {
  const SummaryAll(
      {Key? key})
      : super(key: key);

  @override
  State<SummaryAll> createState() => _SummaryAllState();
}

class _SummaryAllState extends State<SummaryAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("สรุปผลภาพรวมทั้งหมด"),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

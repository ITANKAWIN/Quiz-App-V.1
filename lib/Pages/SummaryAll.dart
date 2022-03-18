import 'package:flutter/material.dart';
import 'package:quiz/Models/AnsModel.dart';
import 'package:quiz/Provider/db_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SummaryAll extends StatefulWidget {
  const SummaryAll({Key? key}) : super(key: key);

  @override
  State<SummaryAll> createState() => _SummaryAllState();
}

class _SummaryAllState extends State<SummaryAll>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List data = [];
  int _select = 0;

  List<DataColumn> _createColumns() {
    return [
      const DataColumn(label: Text('วันที่')),
      const DataColumn(label: Text('ชุดที่')),
      const DataColumn(label: Text('เกรด')),
      const DataColumn(label: Text('เวลาที่ทำ')),
    ];
  }

  List<DataRow> _createRows() {
    return data
        .asMap()
        .map((i, ans) => MapEntry(
              i,
              DataRow(
                onLongPress: () {
                  _tabController.index = 1;
                  setState(() {
                    _select = i;
                    print(_select);
                  });
                },
                cells: [
                  DataCell(Text(ans['time_stamp'].toString().substring(0, 19))),
                  DataCell(Text(ans['num_quiz'].toString())),
                  DataCell(Text(ans['grade'].toString())),
                  DataCell(Text(ans['exam_duration'].toString())),
                ],
              ),
            ))
        .values
        .toList();
  }

  _loadData() async {
    List ans = await DBProvider.instance.getAns();
    setState(() {
      data = ans;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          title: const Text("สรุปผลภาพรวมทั้งหมด"),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: "สถิติ",
              ),
              Tab(
                text: "ประวัติ",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Expanded(
              child: data.isNotEmpty
                  ? Column(
                      children: [],
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            Expanded(
              child: data.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: DataTable(
                              columns: _createColumns(),
                              rows: _createRows(),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              DBProvider.instance.removeAll();
                              _loadData();
                            });
                          },
                          child: const Text("Reset"),
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

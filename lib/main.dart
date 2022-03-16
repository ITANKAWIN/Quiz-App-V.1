import 'package:flutter/material.dart';
import 'package:quiz/Pages/Quiz.dart';
import 'package:quiz/Pages/Summary.dart';
import 'package:quiz/Pages/SummaryAll.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   primaryColor: MyStyle.secondColor,
      //   fontFamily: 'Roboto',
      // ),
      // theme: darkThemeData(context),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/summary_all': (context) => const SummaryAll(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("คำถาม"),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                // color: MyStyle.primaryColor,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Main',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: Stack(
                children: const <Widget>[
                  Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Text(
                      "Menu",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: const <Widget>[
                  Icon(Icons.pages),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Exam Movie'),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Quiz(type: 'Movie'),
                  ),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const <Widget>[
                  Icon(Icons.pages),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Exam Series'),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Quiz(type: 'Series'),
                  ),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const <Widget>[
                  Icon(Icons.pages),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Exam Music'),
                  )
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Quiz(type: 'Music'),
                  ),
                );
              },
            ),
            ListTile(
              title: Row(
                children: const <Widget>[
                  Icon(Icons.wysiwyg),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('ผลสรุป'),
                  )
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, '/summary_all');
              },
            ),
          ],
        ),
      ),
    );
  }
}

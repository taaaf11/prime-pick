import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/codicon.dart';
import 'package:url_launcher/url_launcher.dart';

import 'utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prime Pick',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepOrange,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          fontFamily: 'Comfortaa'),
      home: const MyHomePage(title: 'Prime Pick'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _rangeStartTextController;
  late TextEditingController _rangeEndTextController;
  String result = '';

  void _getPrimes() {
    setState(
      () {
        // get range from the user input
        int rangeStart = int.parse(_rangeStartTextController.text);
        int rangeEnd = int.parse(_rangeEndTextController.text);

        // generate numbers using the given range
        List<int> numbers = List<int>.generate(
          rangeEnd - rangeStart + 1,
          (index) => index + rangeStart,
        );

        // filter out primes into a list
        List<int> primes = numbers.where((number) => isPrime(number)).toList();

        // finally, store the result in the string to be shown
        result = primes.join(', ');
      },
    );
  }

  @override
  void initState() {
    _rangeStartTextController = TextEditingController();
    _rangeEndTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _rangeStartTextController.dispose();
    _rangeEndTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
            onPressed: () async {
              await launchUrl(
                Uri.parse('https://github.com/taaaf11/prime-pick'),
              );
            },
            child: Iconify(Codicon.github,
                color: Theme.of(context).iconTheme.color),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width / 4,
                  child: TextField(
                    controller: _rangeStartTextController,
                    decoration: const InputDecoration(hintText: 'Start'),
                    style: const TextStyle(fontSize: 21),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: width / 4,
                  child: TextField(
                    controller: _rangeEndTextController,
                    decoration: const InputDecoration(hintText: 'End'),
                    style: const TextStyle(fontSize: 21),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: width / 2,
                child: SelectionArea(
                  child: Text(
                    result,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getPrimes,
        tooltip: 'Get!',
        child: const Icon(Icons.filter_alt_sharp),
      ),
    );
  }
}

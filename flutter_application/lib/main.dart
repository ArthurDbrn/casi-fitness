import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Fitness Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _addActivity() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController nameController = TextEditingController();
        final TextEditingController distanceKmController = TextEditingController();
        final TextEditingController distanceMController = TextEditingController();
        final TextEditingController timeHoursController = TextEditingController();
        final TextEditingController timeMinutesController = TextEditingController();
        final TextEditingController timeSecondsController = TextEditingController();
        final TextEditingController dateController = TextEditingController();
        String selectedType = 'Running';

        return AlertDialog(
          title: const Text('Add Activity'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                DropdownButton<String>(
                  value: selectedType,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedType = newValue!;
                    });
                  },
                  items: <String>['Running', 'Swimming', 'Cycling']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: distanceKmController,
                        decoration: const InputDecoration(labelText: 'Distance (km)'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: distanceMController,
                        decoration: const InputDecoration(labelText: 'Distance (m)'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: timeHoursController,
                        decoration: const InputDecoration(labelText: 'Time (hours)'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*'))],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: timeMinutesController,
                        decoration: const InputDecoration(labelText: 'Time (minutes)'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-5]?\d$'))],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: timeSecondsController,
                        decoration: const InputDecoration(labelText: 'Time (seconds)'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^[0-5]?\d$'))],
                      ),
                    ),
                  ],
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      dateController.text = pickedDate.toString().split(' ')[0];
                    }
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    distanceKmController.text.isEmpty ||
                    distanceMController.text.isEmpty ||
                    timeHoursController.text.isEmpty ||
                    timeMinutesController.text.isEmpty ||
                    timeSecondsController.text.isEmpty ||
                    dateController.text.isEmpty ||
                    double.tryParse(distanceKmController.text) == null || double.tryParse(distanceKmController.text)! <= 0 ||
                    double.tryParse(distanceMController.text) == null || double.tryParse(distanceMController.text)! < 0 || double.tryParse(distanceMController.text)! >= 1000 ||
                    int.tryParse(timeHoursController.text) == null || int.tryParse(timeHoursController.text)! < 0 ||
                    int.tryParse(timeMinutesController.text) == null || int.tryParse(timeMinutesController.text)! < 0 || int.tryParse(timeMinutesController.text)! >= 60 ||
                    int.tryParse(timeSecondsController.text) == null || int.tryParse(timeSecondsController.text)! < 0 || int.tryParse(timeSecondsController.text)! >= 60) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields with valid positive numbers for distance and time.')),
                  );
                  return;
                }

                final response = await http.post(
                  Uri.parse('http://10.0.2.2:8080/app/activity'),
                  body: {
                    'operation': 'add',
                    'name': nameController.text,
                    'type': selectedType,
                    'distance_km': distanceKmController.text,
                    'distance_m': distanceMController.text,
                    'time_hours': timeHoursController.text,
                    'time_minutes': timeMinutesController.text,
                    'time_seconds': timeSecondsController.text,
                    'date': dateController.text,
                  },
                );

                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<List> _getActivities() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/app/activity'),
      body: {
        'operation': 'get',
      },
    );

    if (response.statusCode == 200) {
      return List.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load activities');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "You don't have any activities yet.",
            ),
            const Text(
              "Tap the '+' button to add one!",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addActivity,
        tooltip: 'Add a new activity',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

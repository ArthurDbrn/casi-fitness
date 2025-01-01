import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:fitness_tracker/models/activity.dart';
import 'package:fitness_tracker/activity_list.dart';

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

                var response = await http.post(
                  Uri.parse('http://10.0.2.2:8080/server/api/activity/add'),
                  body: {
                    'name': nameController.text,
                    'type': selectedType,
                    'distance': (int.parse(distanceKmController.text)*1000 + int.parse(distanceMController.text)).toString(),
                    'time': (int.parse(timeHoursController.text)*3600 + int.parse(timeMinutesController.text)*60 + int.parse(timeSecondsController.text)).toString(),
                    'date': dateController.text,
                  },
                );
                if (response.statusCode == 307) {
                  Navigator.of(context).pop();
                  setState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Activity added successfully.')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to add activity.')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<List<Activity>> _getActivities() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/server/api/activity'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((data) => Activity.fromJson(data)).whereType<Activity>().toList();
    } else {
      throw Exception('Failed to load activities');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: FutureBuilder<List<Activity>>(
          future: _getActivities(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('You don\'t have any activities yet. Click the + button to add one.'));
            } else {
              return ActivityList(activities: snapshot.data!);
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _addActivity,
        tooltip: 'Add a new activity',
        child: const Icon(Icons.add),
      ),
    );
  }
}

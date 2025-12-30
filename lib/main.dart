import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("Notes");

  runApp(const Notes());
}

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

final tittleController = TextEditingController();
final descripationController = TextEditingController();
final notes = Hive.box("Notes");

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("My Notes"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Text("My Notes", style: TextStyle(color: Colors.blue)),
            SizedBox(height: 30),
            TextField(
              controller: tittleController,
              decoration: InputDecoration(
                label: Text("Tittle"),
                hintText: "Enter Your Tittle",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: descripationController,
              decoration: InputDecoration(
                label: Text("Descrpation"),
                hintText: "Enter Your Descripation",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final key = tittleController.text.trim();
                final value = descripationController.text.trim();
                notes.put(key, value);
                notes.add({
                  "title": tittleController.text.trim(),
                  "description": descripationController.text.trim(),
                });
              },
              child: Text("Save"),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes.getAt(index);
                  return ListTile(
                    title: Text(note["title"]),
                    subtitle: Text(note["description"]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

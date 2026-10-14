
import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  int interested = 0;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COMP 205'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // PART 1: HEADER
            Row(
              children: [
                const CircleAvatar(
                  child: Icon(Icons.school),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile Programming',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Text('Fall 2026 · B238'),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // PART 2: SCHEDULE
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          const Icon(Icons.schedule),
                          const SizedBox(height: 8),
                          const Text('Mon 10:00'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          const Icon(Icons.computer),
                          const SizedBox(height: 8),
                          const Text('Wed 10:00'),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          const Icon(Icons.groups),
                          const SizedBox(height: 8),
                          const Text('Fri 15:00'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // PART 3: DESCRIPTION
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Build AI-powered mobile apps with Flutter: '
                  'from widgets to machine learning and LLMs.',
                ),
              ),
            ),

            const SizedBox(height: 24),

            // PART 4: INTEREST COUNTER
            Center(
              child: Text(
                'Interested: $interested',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  interested++;
                });
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              child: const Text("I'm interested"),
            ),
          ],
        ),
      ),
    );
  }
}

// Lab 2 - provided tests. Do NOT change this file; the TAs grade with the original.
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab02_course_card/course_screen.dart';

// Parts 1-4 use a wide test screen (the test font is wider than the phone font);
// Part 5 checks a small phone.
Future<void> pumpScreen(WidgetTester tester, {Size size = const Size(800, 1200)}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const MaterialApp(home: CourseScreen()));
}

void main() {
  group('Part 1 - header', () {
    testWidgets('app bar shows COMP 205', (tester) async {
      await pumpScreen(tester);
      expect(find.descendant(of: find.byType(AppBar), matching: find.text('COMP 205')), findsOneWidget);
    });

    testWidgets('shows course name and term', (tester) async {
      await pumpScreen(tester);
      expect(find.text('Mobile Programming'), findsOneWidget);
      expect(find.text('Fall 2026 · B238'), findsOneWidget);
    });

    testWidgets('a CircleAvatar with the school icon', (tester) async {
      await pumpScreen(tester);
      expect(find.descendant(of: find.byType(CircleAvatar), matching: find.byIcon(Icons.school)), findsOneWidget);
    });

    testWidgets('avatar and course name are side by side in a Row', (tester) async {
      await pumpScreen(tester);
      final row = find.ancestor(of: find.byType(CircleAvatar), matching: find.byType(Row));
      expect(find.descendant(of: row.first, matching: find.text('Mobile Programming')), findsOneWidget);
    });
  });

  group('Part 2 - schedule row', () {
    testWidgets('three schedule items with icons and times', (tester) async {
      await pumpScreen(tester);
      for (final (icon, label) in [
        (Icons.schedule, 'Mon 10:00'),
        (Icons.computer, 'Wed 10:00'),
        (Icons.groups, 'Fri 15:00'),
      ]) {
        expect(find.byIcon(icon), findsOneWidget, reason: 'missing icon for $label');
        expect(find.text(label), findsOneWidget);
      }
    });

    testWidgets('schedule items share the width equally (Expanded in one Row)', (tester) async {
      await pumpScreen(tester);
      for (final label in ['Mon 10:00', 'Wed 10:00', 'Fri 15:00']) {
        expect(find.ancestor(of: find.text(label), matching: find.byType(Expanded)), findsWidgets,
            reason: '$label should be inside an Expanded');
      }
      final monRow = find.ancestor(of: find.text('Mon 10:00'), matching: find.byType(Row));
      expect(find.descendant(of: monRow.first, matching: find.text('Fri 15:00')), findsOneWidget);
      final mon = tester.getSize(find.ancestor(of: find.text('Mon 10:00'), matching: find.byType(Expanded)).first);
      final fri = tester.getSize(find.ancestor(of: find.text('Fri 15:00'), matching: find.byType(Expanded)).first);
      expect(mon.width, moreOrLessEquals(fri.width, epsilon: 1));
    });
  });

  group('Part 3 - description card', () {
    testWidgets('description text is inside a Card', (tester) async {
      await pumpScreen(tester);
      expect(
        find.descendant(of: find.byType(Card), matching: find.textContaining('AI-powered mobile apps')),
        findsOneWidget,
      );
    });
  });

  group('Part 4 - state', () {
    testWidgets('CourseScreen is a StatefulWidget', (tester) async {
      await pumpScreen(tester);
      expect(tester.widget(find.byType(CourseScreen)), isA<StatefulWidget>());
    });

    testWidgets('counter starts at 0 and counts taps', (tester) async {
      await pumpScreen(tester);
      expect(find.text('Interested: 0'), findsOneWidget);
      await tester.tap(find.text("I'm interested"));
      await tester.pump();
      expect(find.text('Interested: 1'), findsOneWidget);
      await tester.tap(find.text("I'm interested"));
      await tester.pump();
      expect(find.text('Interested: 2'), findsOneWidget);
    });

    testWidgets('favorite button toggles the heart icon', (tester) async {
      await pumpScreen(tester);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pump();
      expect(find.byIcon(Icons.favorite), findsOneWidget);
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pump();
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });
  });

  group('Part 5 - layout quality', () {
    testWidgets('no overflow on a small phone (320 x 568)', (tester) async {
      await pumpScreen(tester, size: const Size(320, 568));
      expect(tester.takeException(), isNull);
    });
  });
}

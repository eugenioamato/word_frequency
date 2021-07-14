import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:word_frequency/app.dart';
import 'package:word_frequency/model/word_freq_analyzer.dart';
import 'package:word_frequency/model/word_freq_analyzer_interface.dart';

//command for test is:
//flutter test integration_test/app_test.dart

//for web, ensure chromedriver is running:
//chromedriver --port=4444
//then run:
//flutter drive --driver=test_driver/integration_driver.dart --target=integration_test/app_test.dart -d web-server

Future<void> main() async {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WordFrequencyAnalyzerInterface wfa=WordFrequencyAnalyzer();

  testWidgets(
      'when inserting "the sun shines over the lake" '
          'when tapping the highest freq button '
          'show 2 in the result '
          'THEN '
          'when tapping the word search '
          'inserting the word "over" '
          'show 1 in the result '
          'THEN '
          'when tapping the most freq search '
          'show "the:2","lake:1","over:1" in the results '
      , (WidgetTester tester) async {


    await tester.pumpWidget(WordFrequencyApp(wfa));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Write your text here'),
      findsOneWidget,
    );


    Finder textfield=find.byType(TextField);

    await tester.tap(textfield);
    await tester.enterText(textfield, 'The sun shines over the lake');
    await tester.tap(find.bySemanticsLabel('highest button'));
    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(
      find.textContaining('2'),
      findsOneWidget,
    );

    await tester.tap(find.bySemanticsLabel('word search button'));
    await tester.pumpAndSettle(Duration(seconds: 1));
    Finder wordField=find.byKey(Key('word field'));
    await tester.enterText(wordField, 'over');
    await tester.tap(find.bySemanticsLabel('search'));
    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(
      find.textContaining('1',skipOffstage: false),
      findsOneWidget,
    );

    await tester.tap(find.bySemanticsLabel('most frequent words button',skipOffstage: false));
    await tester.pumpAndSettle(Duration(seconds: 1));

    await tester.tap(find.bySemanticsLabel('scan',skipOffstage: false),);
    await tester.pumpAndSettle(Duration(seconds: 1));

    expect(
        find.textContaining('the:2',skipOffstage: false),
      findsOneWidget
    );

    expect(
        find.textContaining('lake:1',skipOffstage: false),
        findsOneWidget
    );


    expect(
        find.textContaining('over:1',skipOffstage: false),
        findsOneWidget
    );

  });
}
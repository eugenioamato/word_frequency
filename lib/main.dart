import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';

import 'package:word_frequency/model/word_freq_analyzer.dart';
import 'package:word_frequency/model/word_freq_analyzer_interface.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  WordFrequencyAnalyzerInterface wfa = WordFrequencyAnalyzer(
    fakeWaitDurationInMilliseconds: 20,
  );
  runApp(WordFrequencyApp(wfa));
}

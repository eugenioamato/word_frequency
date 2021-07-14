import 'package:flutter_test/flutter_test.dart';
import 'package:word_frequency/model/word_freq.dart';
import 'package:word_frequency/model/word_freq_analyzer.dart';

void main() {
  test(
      'when text is empty '
      'calculateHighestFrequency will return 0', () async {
    final result = await WordFrequencyAnalyzer().calculateHighestFrequency('');
    expect(result, 0);
  });

  test(
      'when text is empty '
      'calculateFrequencyForWord will always return 0', () async {
    final result = await WordFrequencyAnalyzer().calculateFrequencyForWord('', 'hello');
    expect(result, 0);
  });

  test(
      'when text is "The sun shines over the lake" '
      'calculateFrequencyForWord(,the) will return 2', () async {
    final result = await WordFrequencyAnalyzer().calculateFrequencyForWord('The sun shines over the lake', 'the');
    expect(result, 2);
  });

  test(
      'when text is "The sun shines over the lake" '
      'highest frequent word will return 2', () async {
    final result = await WordFrequencyAnalyzer().calculateHighestFrequency('The sun shines over the lake');
    expect(result, 2);
  });

  test(
      'when text is "The sun shines over the lake lake" '
      'highest frequent word will return 2', () async {
    final result = await WordFrequencyAnalyzer().calculateHighestFrequency('The sun shines over the lake lake');
    expect(result, 2);
  });

  test(
      'when text is "The sun shines over the lake" '
      'calculateMostFrequentNWords(,3)  word will return '
      'the (2), lake (1), over (1)', () async {
    final result = await WordFrequencyAnalyzer().calculateMostFrequentNWords('The sun shines over the lake', 3);
    expect(result[0], WordFrequency('the', 2));
    expect(result[1], WordFrequency('lake', 1));
    expect(result[2], WordFrequency('over', 1));
  });

  test(
      'when text is "The sun shines over the lake OVER" '
      'calculateMostFrequentNWords(,3)  word will return '
      'over (2), the (2), lake (1)', () async {
    final result = await WordFrequencyAnalyzer().calculateMostFrequentNWords('The sun shines over the lake OVER', 3);
    expect(result[0], WordFrequency('over', 2));
    expect(result[1], WordFrequency('the', 2));
    expect(result[2], WordFrequency('lake', 1));
  });

  test(
      'when text is "The" '
      'calculateMostFrequentNWords(,3)  word will return '
      'the (1),', () async {
    final result = await WordFrequencyAnalyzer().calculateMostFrequentNWords('The', 3);
    expect(result[0], WordFrequency('the', 1));
  });
}

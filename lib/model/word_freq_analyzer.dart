import 'package:word_frequency/model/word_freq.dart';
import 'package:word_frequency/model/word_freq_analyzer_interface.dart';
import 'package:word_frequency/model/word_freq_interface.dart';

class WordFrequencyAnalyzer implements WordFrequencyAnalyzerInterface {
  final int? fakeWaitDurationInMilliseconds;
  const WordFrequencyAnalyzer({this.fakeWaitDurationInMilliseconds});

  static Map<String, List<WordFrequencyInterface>> cachedResults = {};

  @override
  Future<int> calculateHighestFrequency(text) async {
    final analysis = await analyze(text);
    if (analysis.isEmpty) return 0;
    return analysis.first.getFrequency();
  }

  @override
  Future<int> calculateFrequencyForWord(text, word) async {
    final analysis = await analyze(text);

    final wordToFind = word.toLowerCase();
    final item = analysis.firstWhere((element) => element.getWord() == wordToFind, orElse: () => WordFrequency('?', 0));

    return item.getFrequency();
  }

  @override
  Future<List<WordFrequencyInterface>> calculateMostFrequentNWords(text, n) async {
    final analysis = await analyze(text);

    return analysis.take(n).toList();
  }

  Future<List<WordFrequencyInterface>> analyze(String text) async {
    if (text.isEmpty) return [];
    if (fakeWaitDurationInMilliseconds != null)
      await Future.delayed(Duration(milliseconds: fakeWaitDurationInMilliseconds!));

    final lText = text.toLowerCase();

    if (cachedResults.containsKey(lText)) return cachedResults[lText]!;

    final alphabetic = RegExp(r'[a-z]+');
    Iterable allMatches = alphabetic.allMatches(lText);
    Map<String, int> frequenciesMap = {};

    allMatches.forEach((match) {
      final word = lText.substring(match.start, match.end);
      frequenciesMap[word] = (frequenciesMap[word] ?? 0) + 1;
    });

    List<WordFrequency> frequenciesList =
        List.from(frequenciesMap.entries.map((MapEntry e) => WordFrequency(e.key, e.value)).toList());

    frequenciesList.sort((a, b) {
      int diff = b.getFrequency() - a.getFrequency();
      if (diff == 0) {
        return a.getWord().compareTo(b.getWord());
      }
      return diff;
    });

    cachedResults[lText] = frequenciesList;
    return frequenciesList;
  }
}

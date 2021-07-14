import 'package:equatable/equatable.dart';
import 'package:word_frequency/model/word_freq_interface.dart';

class WordFrequency extends Equatable implements WordFrequencyInterface {
  final String _word;
  final int _freq;

  const WordFrequency(this._word, this._freq);

  String getWord() => _word;
  int getFrequency() => _freq;

  @override
  String toString() => '${getWord()}:${getFrequency()}';

  @override
  List<Object?> get props => [_word, _freq];
}

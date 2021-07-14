import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_frequency/model/word_freq_analyzer_interface.dart';

class WordFrequencyBloc extends Bloc<WordFrequencyEvent, WordFrequencyState> {
  WordFrequencyBloc(this._wordFrequencyAnalyzer) : super(WordFrequencyInitial());
  final WordFrequencyAnalyzerInterface _wordFrequencyAnalyzer;

  @override
  Stream<WordFrequencyState> mapEventToState(event) async* {
    if (event is WFQueryEvent) {
      if (state is WordFrequencyLoading) return;
      yield WordFrequencyLoading(event.word);
      final result = await _wordFrequencyAnalyzer.calculateFrequencyForWord(event.text, event.word);
      yield WordFrequencyFinished(event.word, result);
    } else if (event is WFResetEvent) {
      yield WordFrequencyInitial();
    }
  }
}

//EVENTS

abstract class WordFrequencyEvent {
  WordFrequencyEvent();
}

class WFQueryEvent extends WordFrequencyEvent {
  final String text;
  final String word;
  WFQueryEvent(this.text, this.word);
}

class WFResetEvent extends WordFrequencyEvent {
  WFResetEvent();
}

//STATES

abstract class WordFrequencyState {
  const WordFrequencyState();
}

class WordFrequencyInitial extends WordFrequencyState {
  const WordFrequencyInitial();
}

class WordFrequencyLoading extends WordFrequencyState {
  final String word;
  const WordFrequencyLoading(this.word);
}

class WordFrequencyFinished extends WordFrequencyState {
  final String word;
  final int result;
  const WordFrequencyFinished(this.word, this.result);
}

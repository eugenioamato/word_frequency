import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_frequency/model/word_freq_analyzer_interface.dart';

class HighestFrequencyBloc extends Bloc<HighestFrequencyEvent, HighestFrequencyState> {
  HighestFrequencyBloc(this._wordFrequencyAnalyzer) : super(HighestFrequencyInitial());
  final WordFrequencyAnalyzerInterface _wordFrequencyAnalyzer;

  @override
  Stream<HighestFrequencyState> mapEventToState(event) async* {
    if (event is HFQueryEvent) {
      if (state is HighestFrequencyLoading) return;

      yield HighestFrequencyLoading();
      final result = await _wordFrequencyAnalyzer.calculateHighestFrequency(event.text);
      yield HighestFrequencyFinished(result);
    } else if (event is HFResetEvent) {
      yield HighestFrequencyInitial();
    }
  }
}

//EVENTS

abstract class HighestFrequencyEvent {
  HighestFrequencyEvent();
}

class HFQueryEvent extends HighestFrequencyEvent {
  final String text;
  HFQueryEvent(this.text);
}

class HFResetEvent extends HighestFrequencyEvent {
  HFResetEvent();
}

//STATES

abstract class HighestFrequencyState {
  const HighestFrequencyState();
}

class HighestFrequencyInitial extends HighestFrequencyState {
  const HighestFrequencyInitial();
}

class HighestFrequencyLoading extends HighestFrequencyState {
  const HighestFrequencyLoading();
}

class HighestFrequencyFinished extends HighestFrequencyState {
  final int result;
  const HighestFrequencyFinished(this.result);
}

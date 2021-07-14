import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_frequency/model/word_freq_analyzer_interface.dart';
import 'package:word_frequency/model/word_freq_interface.dart';

class MostFrequentReportBloc extends Bloc<MostFrequentReportEvent, MostFrequentReportState> {
  MostFrequentReportBloc(this._wordFrequencyAnalyzer) : super(MostFrequentReportInitial());
  final WordFrequencyAnalyzerInterface _wordFrequencyAnalyzer;

  @override
  Stream<MostFrequentReportState> mapEventToState(event) async* {
    if (event is MFWQueryEvent) {
      if (state is MostFrequentReportLoading) return;

      yield MostFrequentReportLoading(event.quantity);
      final result = await _wordFrequencyAnalyzer.calculateMostFrequentNWords(event.text, event.quantity);
      yield MostFrequentReportFinished(event.quantity, result);
    } else if (event is MFWResetEvent) {
      yield MostFrequentReportInitial();
    }
  }
}

//EVENTS

abstract class MostFrequentReportEvent {
  MostFrequentReportEvent();
}

class MFWQueryEvent extends MostFrequentReportEvent {
  final String text;
  final int quantity;
  MFWQueryEvent(this.text, this.quantity);
}

class MFWResetEvent extends MostFrequentReportEvent {
  MFWResetEvent();
}

//STATES

abstract class MostFrequentReportState {
  const MostFrequentReportState();
}

class MostFrequentReportInitial extends MostFrequentReportState {
  const MostFrequentReportInitial();
}

class MostFrequentReportLoading extends MostFrequentReportState {
  final int quantity;
  const MostFrequentReportLoading(this.quantity);
}

class MostFrequentReportFinished extends MostFrequentReportState {
  final int quantity;
  final List<WordFrequencyInterface> items;
  const MostFrequentReportFinished(this.quantity, this.items);
}

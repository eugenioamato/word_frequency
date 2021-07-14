import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:word_frequency/bloc/highest_frequency_bloc.dart';
import 'package:word_frequency/bloc/most_frequent_n_words_bloc.dart';
import 'package:word_frequency/ui/screens/home_page.dart';

import 'package:word_frequency/bloc/word_frequency_bloc.dart';
import 'package:word_frequency/model/word_freq_analyzer_interface.dart';
import 'package:word_frequency/wf_theme.dart';

class WordFrequencyApp extends StatelessWidget {
  WordFrequencyApp(this.wordFrequencyAnalyzer);
  final WordFrequencyAnalyzerInterface wordFrequencyAnalyzer;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HighestFrequencyBloc>(
          create: (context) => HighestFrequencyBloc(wordFrequencyAnalyzer),
        ),
        BlocProvider<WordFrequencyBloc>(
          create: (context) => WordFrequencyBloc(wordFrequencyAnalyzer),
        ),
        BlocProvider<MostFrequentReportBloc>(
          create: (context) => MostFrequentReportBloc(wordFrequencyAnalyzer),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Word Frequency',
        theme: WFTheme.getTheme(),
        home: HomePage(title: 'Flutter Word Frequency'),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

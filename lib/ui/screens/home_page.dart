import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_frequency/bloc/highest_frequency_bloc.dart';
import 'package:word_frequency/bloc/most_frequent_n_words_bloc.dart';
import 'package:word_frequency/bloc/word_frequency_bloc.dart';
import 'package:word_frequency/model/word_freq_interface.dart';
import 'package:word_frequency/ui/widgets/most_frequent_words_dialog.dart';
import 'package:word_frequency/ui/widgets/word_search_dialog.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Write your text here 🖍️️',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 600),
                padding: EdgeInsets.only(
                  top: 20,
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Colors.black,
                        ),
                    controller: controller,
                    minLines: 1,
                    maxLines: 1,
                    onChanged: resetResults,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => getHighestFrequency(context.read<HighestFrequencyBloc>()),
              child: Text(
                'Get Highest Frequency',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
                semanticsLabel: 'highest button',
              ),
            ),
            BlocBuilder<HighestFrequencyBloc, HighestFrequencyState>(builder: (context, state) {
              if (state is HighestFrequencyLoading) {
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
              if (state is HighestFrequencyFinished) {
                return Center(
                  child: Text.rich(
                    TextSpan(text: 'Highest Frequency is: ', children: [
                      TextSpan(
                        text: '${state.result}',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: state.result > 0 ? Colors.greenAccent : Colors.red,
                            ),
                      ),
                    ]),
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return Container();
            }),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => getWordFrequency(context.read<WordFrequencyBloc>()),
              child: Text(
                'Get Frequency for a word',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
                semanticsLabel: 'word search button',
              ),
            ),
            BlocBuilder<WordFrequencyBloc, WordFrequencyState>(builder: (context, state) {
              if (state is WordFrequencyLoading) {
                return Center(
                  child: Column(
                    children: [
                      Text.rich(
                        TextSpan(text: 'Looking for word: ', children: [
                          TextSpan(
                              text: '${state.word}',
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.greenAccent,
                                  ))
                        ]),
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                );
              }
              if (state is WordFrequencyFinished) {
                return Center(
                  child: Column(
                    children: [
                      Text.rich(
                        TextSpan(text: 'Frequency for word: ', children: [
                          TextSpan(
                              text: '${state.word}',
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.greenAccent,
                                  ))
                        ]),
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                      state.result > 0
                          ? Text.rich(
                              TextSpan(text: 'Found ', children: [
                                TextSpan(
                                    text: '${state.result}',
                                    style: Theme.of(context).textTheme.headline4!.copyWith(
                                          color: Colors.red,
                                        )),
                                TextSpan(text: ' times!')
                              ]),
                              style: Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.center,
                            )
                          : Text(
                              'Word not found!',
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                    ],
                  ),
                );
              }
              return Container();
            }),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => getMostFrequentWords(context.read<MostFrequentReportBloc>()),
              child: Text(
                'Get N most frequent words',
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
                semanticsLabel: 'most frequent words button',
              ),
            ),
            BlocBuilder<MostFrequentReportBloc, MostFrequentReportState>(builder: (context, state) {
              if (state is MostFrequentReportLoading) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        'Looking for ${state.quantity} most frequent words',
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                );
              }
              if (state is MostFrequentReportFinished) {
                final elements = state.items
                    .map((WordFrequencyInterface w) => Text.rich(
                          TextSpan(text: '', children: [
                            TextSpan(
                                text: '${w.getWord()}',
                                style: Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Colors.greenAccent,
                                    )),
                            TextSpan(text: ' : '),
                            TextSpan(
                              text: '${w.getFrequency()}',
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.greenAccent,
                                  ),
                            ),
                            TextSpan(
                              text: ' times',
                            ),
                          ]),
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        ))
                    .toList();
                String s = '';
                for (var v in state.items) s += v.toString() + ' ';

                return Center(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Frequency for ${state.quantity} most frequent words:',
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ...elements,
                      elements.length < state.quantity
                          ? Text(
                              'Not enough words in text! Showing only ${elements.length} words.',
                              style: Theme.of(context).textTheme.subtitle1,
                            )
                          : Container(),
                      Text(
                        s,
                        style: TextStyle(fontSize: 1, color: Colors.transparent),
                      )
                    ],
                  ),
                );
              }
              return Container();
            }),
          ],
        ),
      ),
    );
  }

  void getHighestFrequency(HighestFrequencyBloc bloc) {
    FocusScope.of(context).unfocus();
    final text = controller.text;
    bloc.add(HFQueryEvent(text));
  }

  void getWordFrequency(WordFrequencyBloc bloc) async {
    FocusScope.of(context).unfocus();
    final text = controller.text;

    String? word = await showDialog<String>(
      context: context,
      builder: (context) => WordSearchDialog(),
    );

    if (word == null) {
      //the user canceled the query
    } else {
      bloc.add(WFQueryEvent(text, word));
    }
  }

  void getMostFrequentWords(MostFrequentReportBloc bloc) async {
    FocusScope.of(context).unfocus();
    final text = controller.text;
    final quantity = await showDialog<int>(
      context: context,
      builder: (context) => MostFrequentWordsDialog(),
    );
    if (quantity == null) {
      //the user canceled the query
    } else {
      bloc.add(MFWQueryEvent(text, quantity));
    }
  }

  void resetResults(String value) {
    context.read<HighestFrequencyBloc>().add(HFResetEvent());
    context.read<WordFrequencyBloc>().add(WFResetEvent());
    context.read<MostFrequentReportBloc>().add(MFWResetEvent());
  }
}

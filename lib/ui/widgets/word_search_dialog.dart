import 'package:flutter/material.dart';

class WordSearchDialog extends StatefulWidget {
  const WordSearchDialog({Key? key}) : super(key: key);

  @override
  _WordSearchDialogState createState() => _WordSearchDialogState();
}

class _WordSearchDialogState extends State<WordSearchDialog> {
  TextEditingController wordController = TextEditingController();

  @override
  void dispose() {
    wordController.dispose();
    super.dispose();
  }

  void submit() {
    Navigator.of(context).pop(wordController.text);
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text('Please insert the word to search'),
          TextField(
            key: Key('word field'),
            style: Theme.of(context).textTheme.bodyText2,
            minLines: 1,
            maxLines: 1,
            controller: wordController,
            autofocus: true,
            autocorrect: false,
            onSubmitted: (_) => submit(),
          )
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: cancel,
        ),
        ElevatedButton(
          child: Text(
            "Search!",
            semanticsLabel: 'search',
          ),
          onPressed: submit,
        )
      ],
    );
  }
}

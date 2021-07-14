import 'package:flutter/material.dart';

class MostFrequentWordsDialog extends StatefulWidget {
  const MostFrequentWordsDialog({Key? key}) : super(key: key);

  @override
  _MostFrequentWordsDialogState createState() => _MostFrequentWordsDialogState();
}

class _MostFrequentWordsDialogState extends State<MostFrequentWordsDialog> {
  TextEditingController numController = TextEditingController();
  String _error = '';

  @override
  void initState() {
    numController.text = '3';
    super.initState();
  }

  @override
  void dispose() {
    numController.dispose();
    super.dispose();
  }

  void submit() {
    int quantity = 0;
    try {
      quantity = int.parse(numController.text);
    } catch (e) {
      setState(() {
        _error = 'Please insert an integer number';
      });
    }

    if (quantity > 0)
      Navigator.of(context).pop(quantity);
    else
      setState(() {
        _error = 'Please insert a number greater than 0';
      });
  }

  void cancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text('How many words do you want to find?'),
          TextField(
            key: Key('num field'),
            style: Theme.of(context).textTheme.bodyText2,
            minLines: 1,
            maxLines: 1,
            controller: numController,
            keyboardType: TextInputType.number,
            autofocus: true,
            autocorrect: false,
            onSubmitted: (_) => submit(),
          ),
          Text(
            _error,
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: cancel,
        ),
        ElevatedButton(
          child: Text(
            "Scan!",
            semanticsLabel: 'scan',
          ),
          onPressed: submit,
        ),
      ],
    );
  }
}

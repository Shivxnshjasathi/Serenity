import 'package:flutter/material.dart';
import 'package:serenity/constants/const.dart';
import 'package:serenity/constants/wedgets.dart';

class ApiKeyWidget extends StatelessWidget {
  ApiKeyWidget({required this.onSubmitted, super.key});

  final ValueChanged<String> onSubmitted;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'To use the Gemini API, you\'ll need an API key. '
              'If you don\'t already have one, '
              'create a key in Google AI Studio.',
              style: primaryTextStyle,
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration:
                        textFieldDecoration(context, 'Enter your API key'),
                    controller: _textController,
                    onSubmitted: (value) {
                      onSubmitted(value);
                    },
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    onSubmitted(_textController.value.text);
                  },
                  child: Text(
                    'Submit',
                    style: primaryTextStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

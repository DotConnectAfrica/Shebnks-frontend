import 'package:flutter/material.dart';

class CustomResponse extends StatelessWidget {
  final String question;
  final String answer;

  CustomResponse({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      elevation: 0.9,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.subtitle2!.copyWith(),
                text: question,
                children: <TextSpan>[
                  TextSpan(
                    text: '*',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.red),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10), // Add spacing between question and answer
            Text(
              'Answer: $answer',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

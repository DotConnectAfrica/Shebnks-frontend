import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String question;
  final String hintText;
  final TextEditingController controller;
  
  final FormFieldValidator<String>? validator;

  CustomCard({
    required this.question,
    required this.hintText,
    required this.controller,
    
    this.validator, 
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
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 30,
          bottom: 30,
        ),
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
            TextFormField(
              controller: controller,
              validator: validator,
            
              decoration: InputDecoration(
                hintText: hintText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SectorSelectionCard extends StatefulWidget {
  final String question;
  final List<String> sectorOptions;

  SectorSelectionCard({
    required this.question,
    required this.sectorOptions,
  });

  @override
  _SectorSelectionCardState createState() => _SectorSelectionCardState();
}

class _SectorSelectionCardState extends State<SectorSelectionCard> {
  List<String> selectedSectors = [];
  bool isOtherEnabled = false;
  TextEditingController sectorsController = TextEditingController();

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
                text: widget.question,
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
            for (String sector in widget.sectorOptions)
              CheckboxListTile(
                title: Text(sector),
                value: selectedSectors.contains(sector),
                activeColor: const Color(0xffed39ca),
                onChanged: (bool? value) {
                  setState(() {
                    if (value!) {
                      selectedSectors.add(sector);
                    } else {
                      selectedSectors.remove(sector);
                    }
                  });
                },
              ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.trailing,
              title: const Text('Others'),
              value: isOtherEnabled,
              activeColor: const Color(0xffed39ca),
              onChanged: (bool? value) {
                setState(() {
                  isOtherEnabled = value!;
                });
              },
            ),
            if (isOtherEnabled)
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TextFormField(
                  controller: sectorsController,
                  decoration: const InputDecoration(
                    labelText: 'Enter others here (separate with comma)',
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF6200EE)),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

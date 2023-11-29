import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/ui/providers/animal_provider.dart';
import '../../../../providers/page_changed_provider.dart';
import 'spin_animation.dart';

class ReplayWidget extends StatelessWidget {
  const ReplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    AnimalProvider animalProvider =
        Provider.of<AnimalProvider>(context, listen: false);
    return SpinAnimationWidget(
      child: AlertDialog(
        backgroundColor: Colors.deepPurple,
        content: const Text(
          '🥳',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 80),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                //buy
                child: Text(animalProvider.getUiTexts[3]),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.landscapeLeft,
                  DeviceOrientation.landscapeRight,
                ]).then((value) {
                  Navigator.of(context).pop();
                  Provider.of<PageChangedProvider>(context, listen: false)
                      .pageChangedFunction(2);
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                //quit
                child: Text(animalProvider.getUiTexts[5]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

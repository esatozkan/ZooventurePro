import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/data/services/text_services.dart';
import '../../../../providers/page_changed_provider.dart';
import 'spin_animation.dart';

class ReplayWidget extends StatelessWidget {
  const ReplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                child: Text(texts["quit"].toString()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

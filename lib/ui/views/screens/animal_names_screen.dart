import '../widgets/listening_animals_widgets/grid_card_widget.dart';
import 'package:flutter/material.dart';

class AnimalNamesScreen extends StatefulWidget {
  const AnimalNamesScreen({super.key});

  @override
  State<AnimalNamesScreen> createState() => _AnimalNamesScreenState();
}

class _AnimalNamesScreenState extends State<AnimalNamesScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: GridCardWidget(),
    );
  }
}

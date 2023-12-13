import '/data/repository/generate_animal.dart';
import '../widgets/listening_animals_widgets/grid_card_widget.dart';
import 'package:flutter/material.dart';

class ListeningAnimalsScreen extends StatelessWidget {
  const ListeningAnimalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controlOfAddAnimalToApp(context);
    return const GridCardWidget();
    
  }
}

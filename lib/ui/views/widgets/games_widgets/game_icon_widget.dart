import '/ui/providers/page_changed_provider.dart';
import '../../../../data/services/application_data_service.dart';
import '../internet_connection_widget.dart';
import '/ui/providers/animal_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/constants/constants.dart';

class GameIconWidget extends StatefulWidget {
  const GameIconWidget({
    Key? key,
    required this.icon,
    required this.text1,
    required this.whichFunction,
  }) : super(key: key);

  final String icon;
  final String text1;
  final String whichFunction;

  @override
  State<GameIconWidget> createState() => _GameIconWidgetState();
}

class _GameIconWidgetState extends State<GameIconWidget> {
  @override
  Widget build(BuildContext context) {
    PageChangedProvider pageChangedProvider =
        Provider.of<PageChangedProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        if (Provider.of<AnimalProvider>(context, listen: false)
            .getIsAllInformationDownload) {
          Future.delayed(const Duration(milliseconds: 500)).then((value) {
            if (widget.whichFunction == "memoryGame") {
              applicationData("Memory Game");
              pageChangedProvider.pageChangedFunction(7);
            } else if (widget.whichFunction == "SpellingBeeGame") {
              applicationData("Spelling Bee Game");
              pageChangedProvider.pageChangedFunction(8);
            } else if (widget.whichFunction == "knowWhatVirtualAnimalScreen") {
              applicationData("Find Virtual Image Game");
              pageChangedProvider.pageChangedFunction(6);
            } else if (widget.whichFunction == "knowWhatHearAnimalScreen") {
              applicationData("Know Animal Sounds Game");
              pageChangedProvider.pageChangedFunction(3);
            } else if (widget.whichFunction == "knowWhatRealAnimalScreen") {
              applicationData("Find Real Image Game");
              pageChangedProvider.pageChangedFunction(4);
            } else if (widget.whichFunction == "knowWhatTypeAnimalScreen") {
              applicationData("Know Animal Types Game");
              pageChangedProvider.pageChangedFunction(5);
            }
          });
        } else {
          showInformationSnackbar(context, "text");
        }
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              widget.icon,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Consumer<AnimalProvider>(
              builder: (context, animalProvider, _) => Text(
                widget.text1,
                style: TextStyle(
                    fontFamily: "displayFont", fontSize: 18, color: itemColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '/ui/providers/page_changed_provider.dart';

// ignore: must_be_immutable
class QuestionTitleWidget extends StatelessWidget {
  QuestionTitleWidget({
    Key? key,
    required this.question,
  }) : super(key: key);
  late String question;

  @override
  Widget build(BuildContext context) {
    PageChangedProvider pageChangedProvider =
        Provider.of<PageChangedProvider>(context, listen: false);
    final Size size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]).then(
            (value) => pageChangedProvider.pageChangedFunction(2),
          );
        },
        child: Image.asset(
          "assets/game_control/back_icon.png",
          height: size.height < 1100 ? 60 : 100,
          width: size.height < 1100 ? 60 : 100,
          fit: BoxFit.cover,
          color: const Color(0xffeb92e5),
        ),
      ),
    );
  }
}

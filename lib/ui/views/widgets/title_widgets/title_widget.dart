import '/data/services/text_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/constants/constants.dart';
import '../../../providers/page_changed_provider.dart';

bool isEN = true;

class TitleWidget extends StatefulWidget {
  const TitleWidget({super.key});

  @override
  State<TitleWidget> createState() => _TitleWidgetState();
}

class _TitleWidgetState extends State<TitleWidget> {
  @override
  Widget build(BuildContext context) {
    PageChangedProvider pageChangedProvider =
        Provider.of<PageChangedProvider>(context);

    final Size size = MediaQuery.of(context).size;

    return Positioned(
      top: 0,
      left: MediaQuery.of(context).size.width/3,
      child: Center(
        child: Text(
          pageChangedProvider.getPageChanged == 0
              ? texts["animal names"].toString()
              : (pageChangedProvider.getPageChanged == 1)
                  ? texts["animal sounds"].toString()
                  : texts["games"].toString(),
          style: TextStyle(
            fontSize: size.width < 800 ? 32 : 50,
            fontFamily: "displayFont",
            color: itemColor,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

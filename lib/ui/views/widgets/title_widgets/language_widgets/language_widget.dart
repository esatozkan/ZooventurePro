import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/ui/providers/language_provider.dart';
import 'loading_widget.dart';

languageWidget(context) {
  LanguageProvider languageProvider =
      Provider.of<LanguageProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (_) => Center(
      child: Container(
        color: Colors.transparent,
        height: (MediaQuery.of(context).size.height * 7) / 8,
        width: (MediaQuery.of(context).size.width * 7) / 8,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 120,
              mainAxisSpacing: 20,
            ),
            itemCount: languageProvider.getLanguageService.length,
            itemBuilder: (BuildContext context, index) {
              return IconButton(
                onPressed: () async {
                  languageProvider.setFlagIndex(index);
                  // ignore: use_build_context_synchronously
                  await loadingWidget(context);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                icon: CachedNetworkImage(
                  imageUrl: languageProvider.getLanguageService[index],
                ),
              );
            },
          ),
        ),
      ),
    ),
  );
}

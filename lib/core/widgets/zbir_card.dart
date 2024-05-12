import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/features/detailed_card_page/presentation/pages/detailed_card_page.dart';

import 'line_progress_of_zbir.dart';

class ZbirCard extends StatelessWidget {
  const ZbirCard(
      {super.key,
      required this.organizationName,
      required this.organizationType,
      required this.collectionImage,
      required this.collectionTitle,
      required this.collectionDescription,
      required this.collectionCollectedAmount,
      required this.collectionGoalAmount,
      required this.collectionId});

  final String organizationName;
  final String organizationType;
  final String collectionImage;
  final String collectionTitle;
  final String collectionDescription;
  final double collectionCollectedAmount;
  final double collectionGoalAmount;
  final int collectionId;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16), bottom: Radius.circular(16)),
          color: Theme.of(context).colorScheme.surfaceVariant,
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: collectionImage,
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(collectionTitle,
                      style: bodySemiBoldText.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer)),
                  Text(collectionDescription,
                      style: bodyMedium14Text.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer)),
                  const SizedBox(height: 24),
                  LineProgressOfZbir(
                    collected: collectionCollectedAmount,
                    goal: collectionGoalAmount,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailedCardPage(
                                collectionId: collectionId,
                              )));
                },
                child: Text(
                  'Підтримати',
                  style: bodySemiBold14Text.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      )
    ]);
  }
}

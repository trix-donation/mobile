import 'package:flutter/material.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/features/detailed_card_page.dart';

import 'line_progress_of_zbir.dart';

class ZbirCard extends StatelessWidget {
  const ZbirCard({super.key});

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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 34,
                    backgroundImage: NetworkImage('https://picsum.photos/200/300'),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  SizedBox(
                    width: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Притула',
                          style: bodySemiBoldText.copyWith(
                              color: Theme.of(context).colorScheme.primary),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text('Благодійний Фонд',
                            style: bodyMedium14Text.copyWith(
                                color: Theme.of(context).colorScheme.secondary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        // LinearProgressIndicator(value: 0.5)
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        size: 30,
                      ))
                ],
              ),
            ),
            SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.network('https://picsum.photos/300/500', fit: BoxFit.fill)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Опис',
                      style: bodySemiBoldText.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer)),
                  Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, eleifend nunc',
                      style: bodyMedium14Text.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer)),
                  const SizedBox(height: 24),
                  const LineProgressOfZbir(
                    collected: 80000,
                    goal: 300000,
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
                      context, MaterialPageRoute(builder: (context) => const DetailedCardPage()));
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

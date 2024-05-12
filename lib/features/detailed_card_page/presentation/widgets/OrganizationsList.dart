import 'package:flutter/material.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/features/detailed_card_page/data/models/get_selected_collection_model.dart';

class OrganizationItem extends StatelessWidget {
  const OrganizationItem({super.key, required this.organizations});

  final Organization organizations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Збором займаються: ",
                  style:
                      bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground)),
              const SizedBox(width: 4),
              Text(
                organizations.name ?? 'Не вказано',
                style: bodySemiBoldText.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

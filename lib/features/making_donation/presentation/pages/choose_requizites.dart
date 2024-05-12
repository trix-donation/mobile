import 'package:flutter/material.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../detailed_card_page/data/models/get_selected_collection_model.dart';

class ChooseRequzites extends StatelessWidget {
  const ChooseRequzites({super.key, this.requisites});

  final Requisites? requisites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Оберіть реквізити', style: bodyMediumText),
      ),
      body: Builder(builder: (context) {
        if (requisites == null) {
          return Center(
              child: Text("Реквізити відсутні",
                  style: headlineMediumText.copyWith(color: Theme.of(context).colorScheme.error)));
        }
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              RequziteItem(
                iconData: Icons.credit_card_rounded,
                title: "Монобанка",
                iconColor: Theme.of(context).colorScheme.onBackground,
                onTap: () async {
                  Uri monobankURI = Uri.parse(requisites!.monobankJarLink);
                  if (await launchUrl(monobankURI)) {
                    throw Exception('Could not launch $monobankURI');
                  }
                },
              ),
              RequziteItem(
                iconData: Icons.credit_card,
                title: "Монобанк Картка",
                iconColor: Theme.of(context).colorScheme.onBackground,
                onTap: () {},
              ),
              requisites?.paypalEmail != null
                  ? RequziteItem(
                      iconData: Icons.credit_card,
                      title: "PayPal",
                      iconColor: Colors.blue,
                      onTap: () {},
                    )
                  : const SizedBox.shrink(),
              requisites?.bitcoinWalletAddress != null
                  ? RequziteItem(
                      iconData: Icons.credit_card,
                      title: "Bitcoin",
                      iconColor: accent200Color,
                      onTap: () {},
                    )
                  : const SizedBox.shrink(),
              requisites?.usdtWalletAddress != null
                  ? RequziteItem(
                      iconData: Icons.credit_card,
                      title: "USDT",
                      iconColor: Colors.green,
                      onTap: () {},
                    )
                  : const SizedBox.shrink(),
              requisites?.bankCards?.length != 0
                  ? RequziteItem(
                      iconData: Icons.credit_card,
                      title: "Банківські картки",
                      iconColor: Colors.teal,
                      onTap: () {},
                    )
                  : const SizedBox.shrink(),
              requisites?.otherRequisites?.length != 0
                  ? RequziteItem(
                      iconData: Icons.credit_card,
                      title: "Інші реквізити",
                      iconColor: Colors.deepOrangeAccent,
                      onTap: () {},
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
      }),
    );
  }
}

class RequziteItem extends StatelessWidget {
  const RequziteItem(
      {super.key,
      required this.iconData,
      required this.title,
      required this.iconColor,
      required this.onTap});

  final IconData iconData;
  final Color iconColor;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          overlayColor: MaterialStateProperty.all(accent100Color),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).colorScheme.onBackground),
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.credit_card, size: 40, color: iconColor),
                const SizedBox(width: 24),
                Text(title,
                    style:
                        bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                onTap: () {
                  showListTileInfo(
                      context, 250, "Номер картки банки", requisites!.monobankJarNumber, 1);
                },
              ),
              requisites?.paypalEmail != "" && requisites?.paypalEmail != null
                  ? RequziteItem(
                      iconData: Icons.credit_card,
                      title: "PayPal",
                      iconColor: Colors.blue,
                      onTap: () {
                        showListTileInfo(
                            context, 200, "PayPal Email", requisites!.paypalEmail ?? "", 1);
                      })
                  : const SizedBox.shrink(),
              requisites?.bitcoinWalletAddress != "" && requisites?.bitcoinWalletAddress != null
                  ? RequziteItem(
                      iconData: Icons.credit_card,
                      title: "Bitcoin",
                      iconColor: accent200Color,
                      onTap: () {
                        showListTileInfo(
                            context, 200, "Bitcoin", requisites!.bitcoinWalletAddress ?? "", 2);
                      })
                  : const SizedBox.shrink(),
              requisites?.usdtWalletAddress != "" && requisites?.usdtWalletAddress != null
                  ? RequziteItem(
                      iconData: Icons.credit_card,
                      title: "USDT",
                      iconColor: Colors.green,
                      onTap: () {
                        showListTileInfo(
                            context, 200, "USDT адреса", requisites!.usdtWalletAddress ?? "", 2);
                      },
                    )
                  : const SizedBox.shrink(),
              requisites?.bankCards?.length != 0
                  ? RequziteItem(
                      iconData: Icons.credit_card,
                      title: "Банківські картки",
                      iconColor: Colors.teal,
                      onTap: () {
                        showBankCardsTileInfo(
                            context, 400, "Банківські картки", requisites!.bankCards, 1);
                      },
                    )
                  : const SizedBox.shrink(),
              requisites?.otherRequisites?.length != 0
                  ? RequziteItem(
                      iconData: Icons.credit_card,
                      title: "Інші реквізити",
                      iconColor: Colors.deepOrangeAccent,
                      onTap: () {
                        showOtherRequisitesTileInfo(
                            context, 400, "Інші реквізити", requisites?.otherRequisites, 1);
                      },
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        );
      }),
    );
  }

  void showListTileInfo(
      BuildContext context, double height, String title, String requizite, int maxlinesData) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: accent100Color,
          ),
          child: Column(
            children: [
              Text(title, style: headlineMediumText.copyWith(color: text100Color)),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(ClipboardData(text: requizite));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Дані скопійовано",
                          style: bodyMediumText.copyWith(color: text100Color)),
                      backgroundColor: accent100Color,
                    ),
                  );
                },
                child: AutoSizeText(
                    maxLines: maxlinesData,
                    requizite,
                    style: headlineMediumText.copyWith(color: text100Color)),
              ),
            ],
          ),
        );
      },
    );
  }

  void showBankCardsTileInfo(BuildContext context, double height, String title,
      List<BankCard>? bankCards, int maxlinesData) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: height,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: accent100Color,
            ),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: bankCards![index].cardNumber));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Дані скопійовано",
                                style: bodyMediumText.copyWith(color: text100Color)),
                            backgroundColor: accent100Color,
                          ),
                        );
                      },
                      child: AutoSizeText(
                          maxLines: maxlinesData,
                          "${bankCards![index].bankName}: ${bankCards![index].cardNumber}",
                          style: bodyMediumText.copyWith(color: text100Color)),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 14);
                },
                itemCount: bankCards?.length ?? 0),
          ),
        );
      },
    );
  }

  void showOtherRequisitesTileInfo(BuildContext context, double height, String title,
      List<OtherRequisite>? otherRequisites, int maxlinesData) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: height,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: accent100Color,
            ),
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: otherRequisites![index].value));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Дані скопійовано",
                                style: bodyMediumText.copyWith(color: text100Color)),
                            backgroundColor: accent100Color,
                          ),
                        );
                      },
                      child: AutoSizeText(
                          maxLines: maxlinesData,
                          "${otherRequisites?[index].name}: ${otherRequisites?[index].value}",
                          style: bodyMediumText.copyWith(color: text100Color)),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 14);
                },
                itemCount: otherRequisites?.length ?? 0),
          ),
        );
      },
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

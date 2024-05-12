import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/core/widgets/line_progress_of_zbir.dart';
import 'package:trix_donation/features/detailed_card_page/presentation/cubit/get_selected_collection_cubit.dart';

import '../widgets/OrganizationsList.dart';

class DetailedCardPage extends StatefulWidget {
  const DetailedCardPage({super.key, this.collectionId});

  final collectionId;

  @override
  State<DetailedCardPage> createState() => _DetailedCardPageState();
}

class _DetailedCardPageState extends State<DetailedCardPage> {
  GetSelectedCollectionCubit getSelectedCollectionsCubit = GetSelectedCollectionCubit();

  @override
  void initState() {
    super.initState();

    getSelectedCollectionsCubit.loadInformation(widget.collectionId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Збір'),
        ),
        body: BlocConsumer<GetSelectedCollectionCubit, GetSelectedCollectionState>(
          bloc: getSelectedCollectionsCubit,
          listener: (context, state) {
            if (state is GetSelectedCollectionError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message,
                    style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onError),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is GetSelectedCollectionLoaded) {
              String cafor = state.collection.collectedAmountFromOtherRequisites ?? '0';
              double collectedAmountFromOtherRequisites = double.parse(cafor);
              String caop = state.collection.collectedAmountOnPlatform ?? '0';
              double collectedAmountOnPlatform = double.parse(caop);
              String caoj = state.collection.collectedAmountOnJar ?? '0';
              double collectedAmountOnJar = double.parse(caoj);
              String ga = state.collection.goalAmount ?? '0';
              double goalAmount = double.parse(ga);
              double collected = collectedAmountFromOtherRequisites +
                  collectedAmountOnPlatform +
                  collectedAmountOnJar;

              return CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: HeaderDelegate(state.collection.preview),
                    pinned: true, // This keeps the header pinned at the top
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                          child: LineProgressOfZbir(
                            collected: collected,
                            goal: goalAmount,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                          child: Text(state.collection.goalTitle ?? 'no title',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.onBackground)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
                          child: Text(state.collection.description ?? 'no description',
                              style: bodyMediumText.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 8),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.collection.organizations?.length ?? 0,
                            itemBuilder: (context, index) {
                              return OrganizationItem(
                                organizations: state.collection.organizations![index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
              onPressed: () {},
              child: Text('Пожертвувати',
                  style: bodySemiBoldText.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer)),
            ),
          ),
        ));
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  HeaderDelegate(this.imageURL);

  final String? imageURL;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: imageURL != null
          ? CachedNetworkImage(
              imageUrl: imageURL ?? "",
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
            )
          : const Placeholder(),
    );
  }

  @override
  double get maxExtent => 300.0;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}

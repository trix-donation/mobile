import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/core/widgets/zbir_card.dart';
import 'package:trix_donation/features/organization/presentation/manager/active_zbory_cubit.dart';
import 'package:trix_donation/features/organization/presentation/manager/inactive_zbory_cubit.dart';
import 'package:trix_donation/features/organization/presentation/manager/my_organization_cubit.dart';

class MyOrganizationPage extends StatefulWidget {
  const MyOrganizationPage({super.key});

  @override
  State<MyOrganizationPage> createState() => _MyOrganizationPageState();
}

class _MyOrganizationPageState extends State<MyOrganizationPage>
    with SingleTickerProviderStateMixin {
  MyOrganizationCubit myOrganizationCubit = MyOrganizationCubit();
  ActiveZboryCubit activeZboryCubit = ActiveZboryCubit();
  InactiveZboryCubit inactiveZboryCubit = InactiveZboryCubit();

  late TabController _tabController;

  @override
  void initState() {
    myOrganizationCubit.initData();
    _tabController = TabController(length: 3, vsync: this);

    activeZboryCubit.getActveZbory();
    inactiveZboryCubit.getInactveZbory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(controller: _tabController, children: [
      BlocConsumer<MyOrganizationCubit, MyOrganizationState>(
        bloc: myOrganizationCubit,
        listener: (context, state) {
          if (state is MyOrganizationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
                content: Text(state.message, style: bodyMediumText.copyWith(color: Colors.red)),
              ),
            );
          }

          if (state is MyOrganizationRequestCreateSend) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                content: Text(
                  state.message,
                  style: bodyMediumText.copyWith(
                      color: Theme.of(context).colorScheme.onTertiaryContainer),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is MyOrganizationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MyOrganizationNotCreated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Організація не створена',
                    style: bodySemiBoldText,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/creating_organization');
                    },
                    child: const Text('Створити організацію'),
                  ),
                ],
              ),
            );
          }

          if (state is MyOrganizationLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: state.myOrganizationModel.avatar,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(state.myOrganizationModel.name,
                      style: headlineSemiBoldText, textAlign: TextAlign.center),
                ),
                ProfileIcons(
                  instagram: state.myOrganizationModel.instagram,
                  twitter: state.myOrganizationModel.twitter,
                  facebook: state.myOrganizationModel.facebook,
                  customUrl: state.myOrganizationModel.customUrl,
                ),
                const Divider(),
                Center(
                    child: ElevatedButton(
                        onPressed: () {
                          _tabController.animateTo(1);
                        },
                        child: Text("Активні збори"))),
                const SizedBox(height: 20),
                Center(
                    child: OutlinedButton(
                        onPressed: () {
                          _tabController.animateTo(2);
                        },
                        child: Text("Неактивні збори"))),
              ],
            );
          }
          return const Center(
            child: Text('Error'),
          );
        },
      ),
      BlocBuilder(
        bloc: activeZboryCubit,
        builder: (context, state) {
          if (state is ActiveZboryLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                itemCount: state.zboryModel.results!.length,
                itemBuilder: (context, index) {
                  return ZbirCard(
                    collectionImage: state.zboryModel.results![index].preview,
                    collectionTitle: state.zboryModel.results![index].goalTitle,
                    collectionDescription: state.zboryModel.results![index].description,
                    collectionCollectedAmount: double.parse(
                            state.zboryModel.results![index].collectedAmountFromOtherRequisites) +
                        double.parse(state.zboryModel.results![index].collectedAmountOnPlatform) +
                        double.parse(state.zboryModel.results![index].collectedAmountOnJar),
                    collectionId: state.zboryModel.results![index].id,
                    collectionGoalAmount: double.parse(state.zboryModel.results![index].goalAmount),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 24);
                },
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      BlocBuilder(
        bloc: inactiveZboryCubit,
        builder: (context, state) {
          if (state is ActiveZboryLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                itemCount: state.zboryModel.results!.length,
                itemBuilder: (context, index) {
                  return ZbirCard(
                    collectionImage: state.zboryModel.results![index].preview,
                    collectionTitle: state.zboryModel.results![index].goalTitle,
                    collectionDescription: state.zboryModel.results![index].description,
                    collectionCollectedAmount: double.parse(
                            state.zboryModel.results![index].collectedAmountFromOtherRequisites) +
                        double.parse(state.zboryModel.results![index].collectedAmountOnPlatform) +
                        double.parse(state.zboryModel.results![index].collectedAmountOnJar),
                    collectionId: state.zboryModel.results![index].id,
                    collectionGoalAmount: double.parse(state.zboryModel.results![index].goalAmount),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 24,
                  );
                },
              ),
            );
          }

          return Center(
            child: Text(
              'Неактивні збори відсутні',
              style: bodyMediumText,
            ),
          );
        },
      )
    ]);
  }
}

class ProfileIcons extends StatelessWidget {
  final String? instagram;
  final String? facebook;
  final String? twitter;
  final String? customUrl;

  const ProfileIcons({super.key, this.instagram, this.facebook, this.twitter, this.customUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          instagram == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: primary300Color,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 30,
                          color: Colors.pink,
                        )),
                  ),
                ),
          facebook == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: primary300Color,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.face,
                          size: 30,
                          color: Colors.blueAccent,
                        )),
                  ),
                ),
          twitter == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: primary300Color,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.post_add,
                          size: 30,
                          color: Colors.cyanAccent,
                        )),
                  ),
                ),
          customUrl == null
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: primary300Color,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.api_rounded,
                          size: 30,
                          color: accent100Color,
                        )),
                  ),
                ),
        ],
      ),
    );
  }
}

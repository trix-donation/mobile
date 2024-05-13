import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trix_donation/core/theme/colors.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/features/personal_profile/data/models/PersonalProfileModel.dart';
import 'package:trix_donation/features/personal_profile/presentation/manager/personal_profile_cubit.dart';

class PersonalProfilePage extends StatefulWidget {
  const PersonalProfilePage({super.key});

  @override
  State<PersonalProfilePage> createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();

  PersonalProfileCubit personalProfileCubit = PersonalProfileCubit();

  @override
  void initState() {
    personalProfileCubit.getPersonalProfile();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Особистий профіль',
            style: bodySemiBoldText.copyWith(color: Theme.of(context).colorScheme.onBackground)),
      ),
      body: BlocConsumer<PersonalProfileCubit, PersonalProfileState>(
        bloc: personalProfileCubit,
        listener: (context, state) {
          if (state is PersonalProfileLoaded) {
            emailController.text = state.personalProfileModel.email;
            nameController.text = state.personalProfileModel.name ?? "";
            surnameController.text = state.personalProfileModel.surname ?? "";
          }

          if (state is PersonalProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Дані оновлено",
                    style: bodyMediumText.copyWith(
                        color: Theme.of(context).colorScheme.onTertiaryContainer)),
                backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
              ),
            );
          }

          if (state is PersonalProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message,
                    style: bodyMediumText.copyWith(
                        color: Theme.of(context).colorScheme.onErrorContainer)),
                backgroundColor: Theme.of(context).colorScheme.errorContainer,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PersonalProfileLoaded) {
            return PersonalProfileColumnInfo(
              personalProfileCubit: personalProfileCubit,
              personalProfileModel: state.personalProfileModel,
              emailController: emailController,
              nameController: nameController,
              surnameController: surnameController,
            );
          }

          if (state is PersonalProfileUpdated) {
            return PersonalProfileColumnInfo(
              personalProfileCubit: personalProfileCubit,
              personalProfileModel: state.personalProfileModel,
              emailController: emailController,
              nameController: nameController,
              surnameController: surnameController,
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PersonalProfileColumnInfo extends StatelessWidget {
  final PersonalProfileCubit personalProfileCubit;
  final PersonalProfileModel personalProfileModel;

  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController surnameController;

  const PersonalProfileColumnInfo(
      {super.key,
      required this.personalProfileCubit,
      required this.personalProfileModel,
      required this.emailController,
      required this.nameController,
      required this.surnameController});

  void getImageData() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    } else {
      personalProfileCubit.updatePersonalProfileImage(
        file: File(pickedImage.path),
        personalProfileModel: personalProfileModel,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          InkWell(
            onTap: () => getImageData(),
            borderRadius: BorderRadius.circular(20),
            overlayColor: MaterialStateProperty.all(
              accent100Color,
            ),
            child: CircleAvatar(
              radius: 100,
              child: personalProfileModel.avatar == null
                  ? const Icon(Icons.person_rounded, size: 80, color: accent200Color)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        imageUrl: personalProfileModel.avatar,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
            controller: emailController,
            enabled: false,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelStyle:
                  bodyMedium14Text.copyWith(color: Theme.of(context).colorScheme.onBackground),
              labelText: 'Email',
              hintText: 'hello@world.ua',
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
            controller: nameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelStyle:
                  bodyMedium14Text.copyWith(color: Theme.of(context).colorScheme.onBackground),
              labelText: 'Ім\'я',
              hintText: 'Тарас',
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
            controller: surnameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelStyle:
                  bodyMedium14Text.copyWith(color: Theme.of(context).colorScheme.onBackground),
              labelText: 'Прізвище',
              hintText: 'Донатченко',
            ),
          ),
          const SizedBox(height: 36),
          ElevatedButton(
            onPressed: () {
              personalProfileCubit.updatePersonalProfile(
                name: nameController.text,
                surname: surnameController.text,
                personalProfileModel: personalProfileModel,
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Text(
              'Зберегти',
              style: bodySemiBoldText.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

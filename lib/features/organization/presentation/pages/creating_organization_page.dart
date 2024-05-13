import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/features/organization/presentation/manager/my_organization_cubit.dart';

class CreatingOrganizationPage extends StatefulWidget {
  const CreatingOrganizationPage({super.key});

  @override
  State<CreatingOrganizationPage> createState() => _CreatingOrganizationPageState();
}

class _CreatingOrganizationPageState extends State<CreatingOrganizationPage> {
  MyOrganizationCubit myOrganizationCubit = MyOrganizationCubit();

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _userDetailsController = TextEditingController();
  final _instagramController = TextEditingController();
  final _twitterController = TextEditingController();
  final _facebookController = TextEditingController();
  final _customController = TextEditingController();
  final _edrpouController = TextEditingController();
  bool _isFoundation = false;

  File? _image;

  void getImageData() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    } else {
      _image = File(pickedImage.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Створення організації'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Назва організації',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText: 'БЛАГОДІЙНИЙ ФОНД "ЛЕВИ НА ДЖИПІ',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _userDetailsController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Опис організації',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText:
                        'Наш фокус: ми взяли на себе обов’язок забезпечувати бійців саме першої лінії фронту, а також бійців гарячих точок. Прямі контакти: ведемо пряму комунікацію безпосередньо з ротними, взводними, батальйонами, командирами та забезпечуємо їх найнеобхіднішим.',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _instagramController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Instagram',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText: 'https://www.instagram.com/levy_na_dzhipi/',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _twitterController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Twitter',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText: 'https://twitter.com/levy_na_dzhipi',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _facebookController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Facebook',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText: 'https://www.facebook.com/levynadzhipi',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _customController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Custom URL',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText: 'https://levy-na-dzhipi.com',
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () => getImageData(),
                    child: Text('Завантажити логотип', style: bodyMediumText)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Фонд?",
                        style: bodyMedium14Text.copyWith(
                            color: Theme.of(context).colorScheme.onBackground)),
                    Checkbox(
                        value: _isFoundation,
                        onChanged: (value) {
                          setState(() {
                            _isFoundation = value!;
                          });
                        }),
                  ],
                ),
                const SizedBox(height: 20),
                _isFoundation
                    ? TextFormField(
                        style: bodyMediumText.copyWith(
                            color: Theme.of(context).colorScheme.onBackground),
                        controller: _edrpouController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'ЄДРПОУ',
                          labelStyle: bodyMedium14Text.copyWith(
                              color: Theme.of(context).colorScheme.onBackground),
                          hintText: '12345678',
                        ),
                      )
                    : const SizedBox.shrink(),
                ElevatedButton(
                  onPressed: () {
                    myOrganizationCubit.createOrganization(
                      name: _nameController.text,
                      user_details: _userDetailsController.text,
                      image: _image,
                      instagram_url:
                          _instagramController.text == '' ? null : _instagramController.text,
                      twitter_url: _twitterController.text == '' ? null : _twitterController.text,
                      facebook_url:
                          _facebookController.text == '' ? null : _facebookController.text,
                      custom_url: _customController.text == '' ? null : _customController.text,
                      foundation: _isFoundation ? true : null,
                      EGRPOU_code: _isFoundation ? int.parse(_edrpouController.text) : null,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Створити організацію'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

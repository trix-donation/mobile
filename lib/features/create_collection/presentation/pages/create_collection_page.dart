import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trix_donation/core/theme/text_style.dart';
import 'package:trix_donation/core/validators/auth_validators.dart';
import 'package:trix_donation/features/create_collection/presentation/cubit/create_collection_cubit.dart';

class CreateCollectionPage extends StatefulWidget {
  const CreateCollectionPage({super.key});

  @override
  State<CreateCollectionPage> createState() => _CreateCollectionPageState();
}

class _CreateCollectionPageState extends State<CreateCollectionPage> {
  CreateCollectionCubit createCollectionCubit = CreateCollectionCubit();

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _goalAmountController = TextEditingController();
  final _monobankLinkController = TextEditingController();
  final _monoCardController = TextEditingController();
  final _paypalController = TextEditingController();
  final _bitCoinController = TextEditingController();
  final _ethereumController = TextEditingController();
  final _usdtController = TextEditingController();

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
        title: const Text('Створення збору'),
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
                    labelText: 'Назва Збору',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText: 'На FPV',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Опис збору',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText:
                        'Наш фокус: ми взяли на себе обов’язок забезпечувати бійців саме першої лінії фронту, а також бійців гарячих точок. Прямі контакти: ведемо пряму комунікацію безпосередньо з ротними, взводними, батальйонами, командирами та забезпечуємо їх найнеобхіднішим.',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _goalAmountController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Цільова сума',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText: '200000',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _monobankLinkController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Посилання на монобанку',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _monoCardController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Номер монобанки (як картка)',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText: '1234 1234 1234 1234',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _paypalController,
                  validator: emailValidator,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'PayPal Email',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    hintText: 'slava@ukraini.ua',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _bitCoinController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Адреса BitCoin',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _ethereumController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Адреса Ethereum',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: bodyMediumText.copyWith(color: Theme.of(context).colorScheme.onBackground),
                  controller: _usdtController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Адреса USDT',
                    labelStyle: bodyMedium14Text.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () => getImageData(),
                    child: Text('Завантажити фото поста', style: bodyMediumText)),
                const SizedBox(height: 20),
                BlocListener<CreateCollectionCubit, CreateCollectionState>(
                  bloc: createCollectionCubit,
                  listener: (context, state) {
                    if (state is CreateCollectionCreated) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Збір створено',
                            style: bodyMediumText.copyWith(
                                color: Theme.of(context).colorScheme.onTertiaryContainer)),
                        backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                      ));
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pop(context);
                      });
                    }

                    if (state is CreateCollectionError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).colorScheme.errorContainer,
                        content: Text(state.message,
                            style: bodyMediumText.copyWith(
                                color: Theme.of(context).colorScheme.onErrorContainer)),
                      ));
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      if (_image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Завантажте фото поста'),
                        ));
                        return;
                      }

                      createCollectionCubit.createCollection(
                          image: _image!,
                          goal_title: _nameController.text,
                          description: _descriptionController.text,
                          goal_amount: _goalAmountController.text,
                          monobank_jar_link: _monobankLinkController.text,
                          monobank_jar_number: _monoCardController.text,
                          paypal_email: _paypalController.text,
                          bitcoin_wallet_address: _bitCoinController.text,
                          ethereum_wallet_address: _ethereumController.text,
                          usdt_wallet_address: _usdtController.text);
                    },
                    child: const Text('Створити збір'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

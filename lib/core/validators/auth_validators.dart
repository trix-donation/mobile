String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Введіть email';
  }

  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return 'Введіть коректний email';
  }

  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Введіть пароль';
  }

  if (value.length < 6) {
    return 'Пароль повинен бути не менше 6 символів';
  }

  return null;
}

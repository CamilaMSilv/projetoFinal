// ignore_for_file: avoid_print

import 'dart:io';

import 'package:aula_flutter/components/MyDropdownButton.dart';
import 'package:aula_flutter/components/myButton.dart';
import 'package:aula_flutter/components/myTextInput.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  String _selectedLanguage = 'Português';
  final List<String> _topicsOfInterest = [];
  bool _emailNotification = true;
  PickedFile _imageFile = PickedFile('');

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile!;
    });
  }

  Future<void> _removeImage() async {
    setState(() {
      _imageFile = PickedFile('');
    });
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2024),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  validateName(String value) {
    if (value.isEmpty) {
      return 'Por favor, insira seu nome.';
    }
  }

  validadeCidade(String value) {
    if (value.isEmpty) {
      return 'Por favor, insira sua cidade.';
    }
  }

  validadePais(String value) {
    if (value.isEmpty) {
      return 'Por favor, insira seu país.';
    }
  }

  updateButton() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Perfil Atualizado'),
            content: const Text('Seu perfil foi atualizado com sucesso!'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  // saveButton() {
  //   if (_formKey.currentState!.validate()) {
  //     print('Nome: ${txtName.text}');
  //     print('E-mail: ${txtEmail.text}');
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Padding(
  //       padding: const EdgeInsets.all(20.0),
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           children: [
  //             MyTextInput(
  //                 labelText: 'Nome',
  //                 validator: (value) => validateName(value!),
  //                 txtController: txtName),
  //             const SizedBox(height: 10),
  //             MyTextInput(
  //                 labelText: 'Email',
  //                 validator: (value) => validadeEmail(value!),
  //                 txtController: txtEmail),
  //             const SizedBox(height: 10),
  //             MyButton(labelText: 'Enviar', pressed: saveButton)
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuário'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            ClipOval(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: _imageFile.path.trim().isNotEmpty
                        ? ClipOval(
                            child: Image.file(
                              File(_imageFile.path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Center(
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                width: 200,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: _pickImage,
                      child: Ink(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: const Text(
                          'Editar',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: _removeImage,
                      child: Ink(
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: const Text(
                          'Remover',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MyTextInput(
                labelText: 'Nome Completo',
                validator: (value) => validateName(value!),
                txtController: _nameController),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () => _selectDate(context),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Data de Nascimento',
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          formattedDate,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            MyTextInput(
                labelText: 'Cidade de Residência',
                validator: (value) => validadeCidade(value!),
                txtController: _cityController),
            MyTextInput(
                labelText: 'País de Residência',
                validator: (value) => validadePais(value!),
                txtController: _countryController),
            const SizedBox(height: 16.0),
            const Text('Tópicos de Interesse:'),
            CheckboxListTile(
              title: const Text('Moda Feminina'),
              value: _topicsOfInterest.contains('Moda Feminina'),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _topicsOfInterest.add('Moda Feminina');
                  } else {
                    _topicsOfInterest.remove('Moda Feminina');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Moda Masculina'),
              value: _topicsOfInterest.contains('Moda Masculina'),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _topicsOfInterest.add('Moda Masculina');
                  } else {
                    _topicsOfInterest.remove('Moda Masculina');
                  }
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Moda Infantil'),
              value: _topicsOfInterest.contains('Moda Infantil'),
              onChanged: (value) {
                setState(() {
                  if (value!) {
                    _topicsOfInterest.add('Moda Infantil');
                  } else {
                    _topicsOfInterest.remove('Moda Infantil');
                  }
                });
              },
            ),
            MyDropdownButton(
              labelText: 'Idioma Preferido',
              value: _selectedLanguage,
              items: ['Inglês', 'Espanhol', 'Português']
                  .map((lang) => DropdownMenuItem(
                        value: lang,
                        child: Text(lang),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text('Receber Notificações por E-mail:'),
                Switch(
                  value: _emailNotification,
                  onChanged: (value) {
                    setState(() {
                      _emailNotification = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            MyButton(labelText: 'Atualizar', pressed: updateButton),
          ],
        ),
      ),
    );
  }
}

import 'package:aula_flutter/models/cliente.dart';
import 'package:aula_flutter/services/clientes_service.dart';
import 'package:flutter/material.dart';

class ClienteForm extends StatefulWidget {
  final ClientesService clientesService = ClientesService();
  final Cliente? cliente;

  ClienteForm({super.key, this.cliente});

  @override
  _ClienteFormState createState() => _ClienteFormState();
}

class _ClienteFormState extends State<ClienteForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _cpfController;
  late TextEditingController _celularController;
  late Genero _selectedGenero;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.cliente?.nome ?? '');
    _cpfController = TextEditingController(text: widget.cliente?.cpf ?? '');
    _celularController =
        TextEditingController(text: widget.cliente?.celular ?? '');
    _selectedGenero = widget.cliente?.genero ?? Genero.MASCULINO;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.cliente == null ? 'Adicionar Cliente' : 'Editar Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cpfController,
                decoration: const InputDecoration(labelText: 'CPF'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um CPF';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _celularController,
                decoration: const InputDecoration(labelText: 'Celular'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um número de celular';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<Genero>(
                value: _selectedGenero,
                onChanged: (Genero? value) {
                  setState(() {
                    _selectedGenero = value!;
                  });
                },
                items: Genero.values
                    .map<DropdownMenuItem<Genero>>((Genero genero) {
                  return DropdownMenuItem<Genero>(
                    value: genero,
                    child: Text(genero.toString().split('.').last),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Gênero'),
                validator: (value) {
                  if (value == null) {
                    return 'Por favor, selecione o gênero';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                child: Text(widget.cliente == null ? 'Adicionar' : 'Atualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      final Cliente novoCliente = Cliente(
        id: widget.cliente?.id ?? 0,
        nome: _nomeController.text,
        cpf: _cpfController.text,
        celular: _celularController.text,
        genero: _selectedGenero,
      );

      try {
        if (widget.cliente == null) {
          bool cpfExists =
              await widget.clientesService.checkCpfExists(novoCliente.cpf);
          if (cpfExists) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('CPF já cadastrado. Escolha outro CPF.'),
              ),
            );
            return;
          } else {
            await widget.clientesService.addCliente(novoCliente);
          }
        } else {
          await widget.clientesService
              .updateCliente(widget.cliente!.id, novoCliente);
        }

        Navigator.pop(context, true);
      } catch (e) {
        print('Erro ao enviar formulário: $e');
      }
    }
  }
}

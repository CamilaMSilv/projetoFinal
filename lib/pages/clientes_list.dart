import 'package:aula_flutter/models/cliente.dart';
import 'package:aula_flutter/services/clientes_service.dart';
import 'package:flutter/material.dart';

import 'cliente_form.dart';

class ClientesList extends StatefulWidget {
  const ClientesList({super.key});

  @override
  _ClientesListState createState() => _ClientesListState();
}

class _ClientesListState extends State<ClientesList> {
  final ClientesService clientesService = ClientesService();
  late List<Cliente> clientes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchClientes();
  }

  Future<void> _fetchClientes() async {
    try {
      List<Cliente> listaClientes = await clientesService.fetchClientes();
      setState(() {
        clientes = listaClientes;
        isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar clientes: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _confirmarExclusao(int id, String nome) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: Text('Você deseja excluir o cliente $id - $nome?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _excluirCliente(id);
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  void _excluirCliente(int id) {
    clientesService.deleteCliente(id).then((_) {
      _fetchClientes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Clientes'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : clientes != null
              ? ListView.builder(
                  itemCount: clientes.length,
                  itemBuilder: (context, index) {
                    final cliente = clientes[index];
                    return ListTile(
                      title: Text(cliente.nome),
                      subtitle: Text(
                          'CPF: ${cliente.cpf} | Celular: ${cliente.celular}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClienteForm(cliente: cliente),
                          ),
                        ).then((value) {
                          if (value == true) {
                            _fetchClientes();
                          }
                        });
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _confirmarExclusao(cliente.id, cliente.nome);
                        },
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('Erro ao carregar dados.'),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClienteForm(),
            ),
          ).then((value) {
            if (value == true) {
              _fetchClientes();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'dart:convert';

import 'package:aula_flutter/models/cliente.dart';
import 'package:http/http.dart' as http;

class ClientesService {
  final String apiUrl = 'http://localhost:8081/farmacia/resources/clientes';

  Future<List<Cliente>> fetchClientes() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonClientes = json.decode(response.body);
      return jsonClientes.map((json) => Cliente.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar lista de clientes');
    }
  }

  Future<bool> checkCpfExists(String cpf) async {
    try {
      final response = await http.get(Uri.parse('$apiUrl?cpf=$cpf'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        if (data.isNotEmpty) {
          return true;
        }
      }
      return false;
    } catch (e) {
      throw Exception('Erro ao verificar CPF: $e');
    }
  }

  Future<Cliente> addCliente(Cliente cliente) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cliente.toJson()),
    );

    if (response.statusCode == 200) {
      return Cliente.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao adicionar cliente.');
    }
  }

  Future<Cliente> updateCliente(int id, Cliente cliente) async {
    final response = await http.put(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(cliente.toJson()),
    );

    if (response.statusCode == 200) {
      return Cliente.fromJson(json.decode(response.body));
    } else {
      throw Exception('Falha ao atualizar cliente');
    }
  }

  Future<void> deleteCliente(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 204) {
      throw Exception('Falha ao excluir cliente');
    }
  }
}

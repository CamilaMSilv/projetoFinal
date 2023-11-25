// ignore: constant_identifier_names
enum Genero { MASCULINO, FEMININO }

class Cliente {
  final int id;
  final String nome;
  final String cpf;
  final String celular;
  final Genero genero;

  Cliente({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.celular,
    required this.genero,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      celular: json['celular'],
      genero:
          json['genero'] == 'MASCULINO' ? Genero.MASCULINO : Genero.FEMININO,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'celular': celular,
      'genero': genero.toString().split('.').last,
    };
  }
}

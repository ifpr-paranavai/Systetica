// ignore_for_file: file_names

class BrasilCnpj {
  BrasilCnpj({this.nomeFantasia});

  String? nomeFantasia;

  BrasilCnpj.fromJson(Map<String, dynamic> json) {
    nomeFantasia = json['nome_fantasia'] ?? '';
  }
}

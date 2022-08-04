// ignore_for_file: file_names

class Role {
  Role({
    required this.id,
    required this.name,
  });

  late final int id;
  late final String name;

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nome'] = name;
    return _data;
  }
}

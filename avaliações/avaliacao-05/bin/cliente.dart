import 'dart:convert';
import 'dart:io';

class Aluno {
  final int id;
  final String nome;
  final String disciplina;
  final double media;
  final int faltas;

  Aluno({
    required this.id,
    required this.nome,
    required this.disciplina,
    required this.media,
    required this.faltas,
  });

  factory Aluno.fromJson(Map<String, dynamic> json) {
    return Aluno(
      id: json['id'],
      nome: json['nome'],
      disciplina: json['disciplina'],
      media: (json['media'] as num).toDouble(),
      faltas: json['faltas'],
    );
  }
}

Future<void> main() async {
  final client = HttpClient();

  try {
    final request = await client.getUrl(
      Uri.parse('http://localhost:8080/api/alunos'),
    );

    final response = await request.close();

    print('Status: ${response.statusCode}');

    final resposta = await response.transform(utf8.decoder).join();

    final json = jsonDecode(resposta);

    final List alunosJson = json['dados'];

    final alunos = alunosJson
        .map((aluno) => Aluno.fromJson(aluno))
        .toList();

    print('ID NOME DISCIPLINA MEDIA FALTAS MENSAGEM');

    for (final aluno in alunos) {
      String mensagem;

      if (aluno.faltas > 20) {
        mensagem = 'Reprovado por Faltas';
      } else if (aluno.media < 6.0) {
        mensagem = 'Reprovado';
      } else {
        mensagem = 'Aprovado';
      }

      print(
        '${aluno.id} '
        '${aluno.nome} '
        '${aluno.disciplina} '
        '${aluno.media} '
        '${aluno.faltas} '
        '$mensagem',
      );
    }
  } finally {
    client.close();
  }
}
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

class Aluno {
  final int id;
  final String nome;
  final String disciplina;
  final double media;
  final int faltas;

  const Aluno({
    required this.id,
    required this.nome,
    required this.disciplina,
    required this.media,
    required this.faltas,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nome': nome,
        'disciplina': disciplina,
        'media': media,
        'faltas': faltas,
      };

  static Aluno fromJson(Map<String, dynamic> json) => Aluno(
        id: json['id'] as int,
        nome: json['nome'] as String,
        disciplina: json['disciplina'] as String,
        media: (json['media'] as num).toDouble(),
        faltas: json['faltas'] as int,
      );
}

final List<Aluno> alunos = [
  const Aluno(
    id: 1,
    nome: 'Ana Souza',
    disciplina: 'Programação',
    media: 8.7,
    faltas: 5,
  ),
  const Aluno(
    id: 2,
    nome: 'Bruno Lima',
    disciplina: 'Banco de Dados',
    media: 5.5,
    faltas: 10,
  ),
  const Aluno(
    id: 3,
    nome: 'Carla Mendes',
    disciplina: 'Redes',
    media: 7.2,
    faltas: 25,
  ),
  const Aluno(
    id: 4,
    nome: 'Diego Alves',
    disciplina: 'Programação',
    media: 4.5,
    faltas: 22,
  ),
];

Response jsonResponse(Object body, {int status = 200}) {
  return Response(
    status,
    body: jsonEncode(body),
    headers: {'content-type': 'application/json; charset=utf-8'},
  );
}

Response listarAlunos(Request request) {
  return jsonResponse({
    'total': alunos.length,
    'dados': alunos.map((aluno) => aluno.toJson()).toList(),
  });
}

Response buscarAluno(Request request, String id) {
  final idNumerico = int.tryParse(id);

  if (idNumerico == null) {
    return jsonResponse(
      {'erro': 'O id deve ser um número inteiro.'},
      status: 400,
    );
  }

  final aluno = alunos.where((item) => item.id == idNumerico).firstOrNull;

  if (aluno == null) {
    return jsonResponse(
      {'erro': 'Aluno não encontrado.'},
      status: 404,
    );
  }

  return jsonResponse(aluno.toJson());
}

Future<Response> criarAluno(Request request) async {
  try {
    final body = await request.readAsString();
    final json = jsonDecode(body) as Map<String, dynamic>;

    final novoAluno = Aluno.fromJson({
      ...json,
      'id': alunos.isEmpty ? 1 : alunos.last.id + 1,
    });

    alunos.add(novoAluno);

    return jsonResponse(novoAluno.toJson(), status: 201);
  } on FormatException {
    return jsonResponse({'erro': 'JSON inválido.'}, status: 400);
  } catch (_) {
    return jsonResponse(
      {
        'erro':
            'Dados inválidos. Informe nome, disciplina, media e faltas.',
      },
      status: 400,
    );
  }
}

Response health(Request request) {
  return jsonResponse({
    'status': 'ok',
    'servico': 'api-alunos',
    'timestamp': DateTime.now().toUtc().toIso8601String(),
  });
}

Router createRouter() {
  return Router()
    ..get('/health', health)
    ..get('/api/alunos', listarAlunos)
    ..get('/api/alunos/<id>', buscarAluno)
    ..post('/api/alunos', criarAluno);
}

Future<void> main() async {
  final port = int.tryParse(Platform.environment['PORT'] ?? '') ?? 8080;
  final address = InternetAddress.anyIPv4;

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(createRouter().call);

  final server = await shelf_io.serve(handler, address, port);
  server.autoCompress = true;

  print(
    'Servidor iniciado em '
    'http://${server.address.host}:${server.port}',
  );
}
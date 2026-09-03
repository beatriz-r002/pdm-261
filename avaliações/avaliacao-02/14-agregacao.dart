// 14-agregacao.dart  
// Agregação e Composição
import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  // Getter para permitir a conversão para JSON
  String get nome => _nome;

  Map<String, dynamic> toJson() => {
    'nome': _nome,
  };
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  // Getters para permitir a conversão para JSON
  String get nome => _nome;
  List<Dependente> get dependentes => _dependentes;

  Map<String, dynamic> toJson() => {
    'nome': _nome,
    'dependentes': _dependentes.map((d) => d.toJson()).toList(),
  };
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  // Getters para permitir a conversão para JSON
  String get nomeProjeto => _nomeProjeto;
  List<Funcionario> get funcionarios => _funcionarios;

  Map<String, dynamic> toJson() => {
    'nomeProjeto': _nomeProjeto,
    'funcionarios': _funcionarios.map((f) => f.toJson()).toList(),
  };
}

void main() {
  // 1. Criar varios objetos Dependentes
  var dep1 = Dependente('Ana Silva');
  var dep2 = Dependente('Carlos Souza');
  var dep3 = Dependente('Mariana Costa');

  // 2. Criar varios objetos Funcionario
  // 3. Associar os Dependentes criados aos respectivos funcionarios
  var func1 = Funcionario('João Pedro', [dep1, dep2]);
  var func2 = Funcionario('Maria Oliveira', [dep3]);
  var func3 = Funcionario('Lucas Mendes', []); // Funcionario sem dependentes

  // 4. Criar uma lista de Funcionarios
  List<Funcionario> listaFuncionarios = [func1, func2, func3];

  // 5. Criar um objeto Equipe Projeto chamando o metodo
  //    construtor que da nome ao projeto e insere uma coleção de funcionario
  var equipe = EquipeProjeto('Sistema de Gestão Escolar', listaFuncionarios);

  // 6. Printar no formato JSON o objeto Equipe Projeto.
  // Utilizando JsonEncoder.withIndent para formatar o JSON de forma legível
  String jsonFormatted = JsonEncoder.withIndent('  ').convert(equipe.toJson());
  print(jsonFormatted);
}
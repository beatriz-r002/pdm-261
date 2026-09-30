# Cliente HTTP e Servidor Web em Dart

Atividade prática desenvolvida em Dart para trabalhar com comunicação entre um **cliente HTTP** e um **servidor Web**, utilizando JSON.

O servidor disponibiliza uma lista de alunos por meio de uma API HTTP, enquanto o cliente realiza uma requisição ao servidor, recebe os dados, interpreta o JSON e verifica a situação acadêmica de cada aluno.

## 📚 Objetivo da atividade

* Modificar a estrutura de alunos do servidor Web.
* Disponibilizar os alunos através de uma API HTTP.
* Criar um cliente HTTP em Dart.
* Fazer o cliente acessar os alunos registrados no servidor.
* Interpretar os dados recebidos em JSON.
* Verificar a situação de cada aluno de acordo com média e faltas.
* Exibir os alunos no formato:

```text
ID NOME DISCIPLINA MEDIA FALTAS MENSAGEM
```

## 🛠️ Tecnologias utilizadas

* Dart
* Shelf
* Shelf Router
* HTTP
* JSON

## 📁 Estrutura

```text
servidor_alunos/bin
├── server.dart
├── client.dart
└── README.md
```

## 🖥️ 1. Servidor Web

O arquivo `server.dart` é responsável por criar o servidor HTTP utilizando o pacote `shelf`.

A estrutura do aluno utilizada nesta atividade é:

```text
Aluno(
    id,
    nome,
    disciplina,
    media,
    faltas
)
```

O servidor disponibiliza a rota:

```text
GET /api/alunos
```

Ao acessar:

```text
http://localhost:8080/api/alunos
```

o servidor retorna os alunos em formato JSON.


## ▶️ Executando o servidor

No terminal:

```bash
dart run server.dart
```

O servidor é executado na porta `8080`.

```text
Servidor iniciado em http://0.0.0.0:8080
```

Também é possível testar a API diretamente pelo navegador:

```text
http://localhost:8080/api/alunos
```

Nesse caso, o navegador funciona como um cliente HTTP e exibe os dados retornados pelo servidor.

## 💻 2. Cliente HTTP

Depois de colocar o servidor para funcionar, foi criado o arquivo `client.dart`.

O cliente utiliza `HttpClient` para realizar uma requisição:

```dart
final request = await client.getUrl(
  Uri.parse('http://localhost:8080/api/alunos'),
);
```

O servidor responde com os dados dos alunos em JSON.

O cliente então transforma a resposta em objetos `Aluno`:

```dart
final json = jsonDecode(resposta);

final List alunosJson = json['dados'];

final alunos = alunosJson
    .map((aluno) => Aluno.fromJson(aluno))
    .toList();
```

## 🔎 3. Verificação da situação dos alunos

Depois de receber os alunos, o cliente verifica a média e a quantidade de faltas.

A regra utilizada é:

```text
Se Faltas > 20
    Reprovado por Faltas

Senão, se Média < 6.0
    Reprovado

Senão
    Aprovado
```

A verificação é realizada no **cliente**, e não no servidor.

Isso significa que o servidor apenas fornece os dados dos alunos, enquanto o cliente recebe esses dados e aplica a regra da atividade.

## 📊 Resultado

Ao executar o cliente:

```bash
dart run client.dart
```

o resultado esperado é semelhante a:

```text
Status: 200
ID NOME DISCIPLINA MEDIA FALTAS MENSAGEM
1 Ana Souza Programação 8.7 5 Aprovado
2 Bruno Lima Banco de Dados 5.5 10 Reprovado
3 Carla Mendes Redes 7.2 25 Reprovado por Faltas
4 Diego Alves Programação 4.5 22 Reprovado por Faltas
```

## 🔄 Comunicação entre cliente e servidor

A comunicação desenvolvida na atividade funciona da seguinte forma:

```text
┌──────────────────┐
│   client.dart    │
│                  │
│ Requisição HTTP  │
└────────┬─────────┘
         │
         │ GET /api/alunos
         ↓
┌──────────────────┐
│   server.dart    │
│                  │
│ API HTTP :8080   │
└────────┬─────────┘
         │
         │ JSON
         ↓
┌──────────────────┐
│   client.dart    │
│                  │
│ Interpreta JSON  │
│ Verifica média   │
│ Verifica faltas  │
│ Exibe resultado  │
└──────────────────┘
```

## 🌐 Teste pelo navegador

Também foi realizado o teste acessando diretamente:

```text
http://localhost:8080/api/alunos
```

Nesse caso, o navegador realiza a requisição ao servidor e recebe apenas os dados dos alunos em JSON.

A classificação de **Aprovado**, **Reprovado** ou **Reprovado por Faltas** não aparece no navegador porque essa regra foi implementada no `client.dart`.

## 💡 O que foi praticado

Com esta atividade foi possível praticar:

* criação de um servidor HTTP em Dart;
* criação de um cliente HTTP;
* comunicação entre cliente e servidor;
* requisições `GET`;
* utilização de `localhost`;
* utilização de portas;
* APIs;
* JSON;
* conversão de JSON para objetos Dart;
* separação entre servidor e cliente;
* processamento dos dados recebidos.


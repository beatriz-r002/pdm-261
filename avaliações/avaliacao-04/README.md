# API REST de Alunos em Dart

API REST simples desenvolvida em Dart para gerenciar uma lista de alunos simulando um banco de dados.

## 🚀 Funcionalidades

- Listar todos os alunos
- Buscar aluno por ID
- Criar novo aluno
- Filtros por nome, curso e status (ativo/inativo)
- Health check

## 📋 Pré-requisitos

- [Dart SDK](https://dart.dev/get-dart) instalado
- Terminal (PowerShell ou CMD no Windows)

## 🛠️ Passo a passo

### 1. Criar o projeto Dart

```bash
dart create servidor_alunos
```

### 2. Entrar no diretório do projeto

```bash
cd servidor_alunos
```

### 3. Configurar as dependências

Edite o arquivo `pubspec.yaml` e adicione:

```yaml
name: servidor_alunos
description: API REST simples em Dart para consulta de alunos.
version: 1.0.0

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  shelf: ^1.4.1
  shelf_router: ^1.1.4
```

### 4. Criar o servidor

Crie o arquivo `bin/server.dart` com o código do servidor (ver seção "Códigos" abaixo).

### 5. Instalar as dependências

```bash
dart pub get
```

### 6. Rodar o servidor

```bash
dart run bin\server.dart
```

Saída esperada:
Servidor iniciado em http://0.0.0.0:8080


## 🌐 Endpoints

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/health` | Health check da API |
| GET | `/api/alunos` | Lista todos os alunos |
| GET | `/api/alunos/<id>` | Busca aluno por ID |
| POST | `/api/alunos` | Cria novo aluno |

### Exemplos de uso

**Listar todos os alunos:**

```bash
http://localhost:8080/api/alunos
```

**Buscar aluno por ID:**

```bash
http://localhost:8080/api/alunos/1
```

**Health check:**

```bash
http://localhost:8080/health
```

## 📁 Estrutura do projeto
servidor_alunos/
├── bin/
│ └── server.dart
├── pubspec.yaml

## 📄 Licença

Este projeto é apenas para fins educacionais.



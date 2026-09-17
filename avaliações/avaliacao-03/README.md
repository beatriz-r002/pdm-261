# 📧 Projeto Dart — Envio de E-mail com Gmail

Projeto desenvolvido em **Dart** com o objetivo de criar um programa capaz de enviar e-mails utilizando uma conta do **Gmail** através do protocolo SMTP.

A atividade foi desenvolvida utilizando o **WSL (Windows Subsystem for Linux)** como ambiente de desenvolvimento e o pacote [`mailer`](https://pub.dev/packages/mailer) para realizar o envio do e-mail.

---

## 📋 Objetivo da atividade

Criar um projeto Dart e desenvolver um programa capaz de enviar um e-mail utilizando o Gmail.

O programa foi inicialmente gerado com auxílio do **Gemini**, utilizando o seguinte prompt solicitado na atividade:

> **Crie um programa dart que envia um email usando o gmail.**

---

## 🛠️ Tecnologias utilizadas

* **Dart 3.13.4**
* **WSL / Ubuntu**
* **Visual Studio Code**
* **Gmail**
* **SMTP**
* Pacote Dart [`mailer`](https://pub.dev/packages/mailer)

---

# 1. Instalação do Dart pelo WSL

O desenvolvimento foi realizado dentro do WSL, sem a necessidade de instalar o Dart diretamente no Windows.

Primeiro, foi atualizado o índice de pacotes do Ubuntu:

```bash
sudo apt update
```

Depois foram instalados alguns pacotes necessários para adicionar o repositório do Dart:

```bash
sudo apt install apt-transport-https curl gnupg
```

---

## 1.1. Adicionando a chave do repositório Dart

Foi adicionada a chave de assinatura do repositório oficial do Dart:

```bash
sudo wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor | sudo tee /usr/share/keyrings/dart.gpg > /dev/null
```

---

## 1.2. Adicionando o repositório do Dart

Em seguida, o repositório do Dart foi adicionado ao Ubuntu:

```bash
echo 'deb [signed-by=/usr/share/keyrings/dart.gpg] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list
```

Depois foi executada novamente a atualização dos pacotes:

```bash
sudo apt update
```

---

## 1.3. Instalando o Dart

O Dart SDK foi instalado com:

```bash
sudo apt install dart
```

Após a instalação, foi verificada a versão:

```bash
dart --version
```

Resultado obtido:

```text
Dart SDK version: 3.13.4
```

---

# 2. Criação do projeto Dart

Foi criada uma pasta para organizar os projetos do IFCE:

```text
/mnt/c/Users/anabe/Projetos-IFCE/
```

Dentro dela foi criado o projeto:

```text
meu_projeto
```

O projeto foi criado utilizando o Dart CLI.

Após a criação, a estrutura básica do projeto foi gerada automaticamente pelo Dart.

A estrutura utilizada ficou semelhante a:

```text
meu_projeto/
├── bin/
│   └── meu_projeto.dart
├── lib/
├── test/
├── analysis_options.yaml
├── pubspec.yaml
├── README.md
└── ...
```

---

# 3. Abrindo o projeto no VS Code

Com o terminal posicionado dentro da pasta do projeto:

```bash
cd /mnt/c/Users/anabe/Projetos-IFCE/meu_projeto
```

O projeto foi aberto no Visual Studio Code utilizando:

```bash
code .
```

---

# 4. Geração do código utilizando Gemini

Foi utilizado o Gemini para gerar o programa solicitado na atividade.

### Prompt utilizado

```text
Crie um programa dart que envia um email usando o gmail.
```

O código gerado utilizou o pacote `mailer`, responsável pela comunicação com o servidor SMTP e pelo envio da mensagem.

---

# 5. Instalação da dependência `mailer`

Para adicionar o pacote ao projeto, foi utilizado o comando:

```bash
dart pub add mailer
```

Esse comando adicionou automaticamente a dependência ao arquivo:

```text
pubspec.yaml
```

O arquivo passou a conter uma dependência semelhante a:

```yaml
dependencies:
  mailer: ^6.x.x
```

A versão pode variar de acordo com a versão disponível no momento da instalação.

---

# 6. Código do programa

O código foi colocado no arquivo:

```text
bin/meu_projeto.dart
```

Código utilizado:

```dart
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {
  final String username = 'SEU_EMAIL@gmail.com';

  final String appPassword = 'SUA_SENHA_DE_APP';

  final smtpServer = gmail(username, appPassword);

  final message = Message()
    ..from = Address(username, 'Seu Nome')
    ..recipients.add('EMAIL_DESTINATARIO@gmail.com')
    ..subject = 'Teste de E-mail via Dart'
    ..text = 'Olá! Este é um e-mail enviado automaticamente usando Dart.'
    ..html =
        '<h1>Olá!</h1><p>Este é um e-mail com suporte a <b>HTML</b>.</p>';

  try {
    final sendReport = await send(message, smtpServer);
    print('E-mail enviado com sucesso: $sendReport');
  } on MailerException catch (e) {
    print('O e-mail não pôde ser enviado.');

    for (var p in e.problems) {
      print('Problema: ${p.code}: ${p.msg}');
    }
  }
}
```

> **Importante:** os valores de e-mail e senha apresentados acima são apenas exemplos. As credenciais reais não devem ser publicadas no GitHub.

---

# 7. Configuração da conta Gmail

Para permitir que o programa realize a autenticação no servidor SMTP do Gmail, foi utilizada uma **Senha de app**.

Primeiramente, foi necessário ativar a **Verificação em duas etapas** na Conta Google.

Depois foi acessada a opção **Senhas de app**, onde foi criada uma senha específica para utilização pelo programa.

A senha de app possui 16 caracteres e foi utilizada no código no lugar da senha normal da conta.

Exemplo:

```dart
final String appPassword = 'SUA_SENHA_DE_APP';
```

### 🔐 Segurança

A senha de app é uma credencial privada e **não deve ser enviada para o GitHub**.

Antes de publicar o projeto, a senha real deve ser removida do código ou substituída por uma variável de ambiente.

---

# 8. Execução do programa

Com o terminal dentro da pasta do projeto:

```text
/mnt/c/Users/anabe/Projetos-IFCE/meu_projeto
```

o programa foi executado utilizando:

```bash
dart run
```

O programa realizou a conexão com o servidor SMTP do Gmail e enviou a mensagem.

Quando o envio foi realizado corretamente, o terminal apresentou uma mensagem semelhante a:

```text
E-mail enviado com sucesso: ...
```

---

# 9. Resultado

Após a execução do programa, o e-mail foi recebido corretamente pelo endereço configurado como destinatário.

A mensagem enviada continha:

**Assunto:**

```text
Teste de E-mail via Dart
```

**Mensagem:**

```text
Olá! Este é um e-mail enviado automaticamente usando Dart.
```

Também foi utilizado conteúdo HTML:

```html
<h1>Olá!</h1>
<p>Este é um e-mail com suporte a <b>HTML</b>.</p>
```

---

# 10. Evidências da atividade

Foram realizadas capturas de tela para comprovar a execução.

### 🖥️ Evidência 1 — Terminal

Print mostrando a execução:

```bash
dart run
```

e a mensagem indicando que o e-mail foi enviado com sucesso.

### 📧 Evidência 2 — E-mail recebido

Print da caixa de entrada mostrando o e-mail enviado pelo programa, incluindo:

* remetente;
* assunto;
* conteúdo da mensagem.

Essas imagens podem ser adicionadas posteriormente neste README, por exemplo:

```markdown
![Execução do programa](images/terminal.png)

![E-mail recebido](images/email-recebido.png)
```

---

# 📁 Estrutura do projeto

```text
meu_projeto/
│
├── bin/
│   └── meu_projeto.dart
│
├── lib/
│
├── test/
│
├── analysis_options.yaml
├── pubspec.yaml
├── pubspec.lock
└── README.md
```

---

# ✅ Resultado final

O projeto foi executado com sucesso utilizando **Dart 3.13.4 no WSL**, com o pacote `mailer` para comunicação SMTP.

O programa conseguiu realizar o envio de um e-mail através do Gmail e a mensagem foi recebida corretamente pelo destinatário.

---

## 📚 Referências

* [Dart](https://dart.dev/)
* [Dart Packages — mailer](https://pub.dev/packages/mailer)
* [Google Account](https://myaccount.google.com/)


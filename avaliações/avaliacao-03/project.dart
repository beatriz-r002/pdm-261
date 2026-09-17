import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {
  // Configurações da conta remetente
  final String username = 'seu_email@gmail.com';
  
  // Use a Senha de App de 16 caracteres gerada no Google (sem espaços)
  final String appPassword = 'abcd efgh ijkl mnop';

  // Configura o servidor SMTP do Gmail
  final smtpServer = gmail(username, appPassword);

  // Cria a mensagem de e-mail
  final message = Message()
    ..from = Address(username, 'Seu Nome')
    ..recipients.add('destino@exemplo.com') // E-mail do destinatário
    ..subject = 'Teste de E-mail via Dart'
    ..text = 'Olá! Este é um e-mail enviado automaticamente usando Dart.'
    ..html = '<h1>Olá!</h1><p>Este é um e-mail com suporte a <b>HTML</b>.</p>';

  try {
    // Envia o e-mail
    final sendReport = await send(message, smtpServer);
    print('E-mail enviado com sucesso: $sendReport');
  } on MailerException catch (e) {
    print('O e-mail não pôde ser enviado.');
    for (var p in e.problems) {
      print('Problema: ${p.code}: ${p.msg}');
    }
  }
}

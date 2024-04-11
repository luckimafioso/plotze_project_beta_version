import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:project_lista_compras/view/princ_view.dart';
import 'view/login_view.dart';
import 'view/cadastro_view.dart';
import 'view/rec_senha_view.dart';
import 'view/rec_senha_email_view.dart';
import 'view/criar_lista_view.dart';
import 'view/sobre_view.dart';
import 'view/gerenciar_listas_view.dart';


void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MainApp(),
    ),
  );
}

//
// MainApp
//
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navegação',

      //
      //Rotas de navegação
      //
      initialRoute: 'Login',
      routes: {
        'Login': (context) => const Login_View(),
        'Cadastro': (context) => const Cadastro_View(),
        'Rec': (context) => const Rec_Senha_View(),
        'Rec_Email': (context) => const Rec_Senha_Email_View(),
        'Princ': (context) => const Princ_View(),
        'Sobre' :(context) => const Sobre_View(),
        'Criar_Lista' :(context) => Criar_Lista_View(),
        'Gerenciar_Listas' :(context) => const Gerenciar_Listas_View(),
      },
    );
  }
}
// ignore_for_file: prefer_const_constructors, sort_child_properties_last, camel_case_types

import 'package:flutter/material.dart';

class Princ_View extends StatefulWidget {
  const Princ_View({super.key});

  @override
  State<Princ_View> createState() => _Princ_ViewState();
}

class _Princ_ViewState extends State<Princ_View> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Inicial'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      body: Center(
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(''),
            // ... Conteúdo da tela inicial ...
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
              context, 'Criar_Lista'); // Navigate to CriarListas screen
        },
        child: const Icon(Icons.add),
        tooltip: 'Criar Lista',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tela Inicial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Gerenciar Listas',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, 'Princ_view');
              break;
            case 1:
              Navigator.pushNamed(context, 'Gerenciar_Listas');
              break;
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 187, 134, 0), // You can set a fixed color here
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Bem vindo de volta, '),
                  FutureBuilder<String>(
                    future: _getUserName(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!);
                      } else {
                        return const Text('Carregando...');
                      }
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: const Text('Sobre'),
              onTap: () {
                Navigator.pushNamed(context, 'Sobre');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text('Sair'),
              onTap: () {
                // Implement logout logic (clear user data, tokens etc.)
                // Navigate back to login screen
                Navigator.pushNamedAndRemoveUntil(
                    context, 'Login', (Route route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getUserName() async {
    // Implementar a lógica para recuperar o nome do usuário logado
    // Retornar o nome do usuário
    return 'Usuario';
  }
}
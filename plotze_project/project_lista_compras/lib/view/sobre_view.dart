// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Sobre_View extends StatelessWidget {
  const Sobre_View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Sobre o Dev!!'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, 'princ'), 
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 340,
                width: 200,
              child: Image.asset(
                'lib/images/20240318_124106.jpg',
                fit:BoxFit.fill,                
              ),
            ),

            
            // Information section
            const Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.terminal_outlined),
                    title: Text('Código do aluno: 836116'),
                  ),
                  ListTile(
                    leading: Icon(Icons.person_add),
                    title: Text('Lucas Duarte Alves'),
                  ),
                  ListTile(
                    leading: Icon(Icons.comment_bank_rounded),
                    title: Text('Cursando: Engenharia da Computação'),
                  ),
                  ListTile(
                    leading: Icon(Icons.accessibility),
                    title: Text('Desenvolvedor nas horas vagas'),
                  ),
                  ListTile(
                    leading: Icon(Icons.travel_explore),
                    title: Text('Aplicativo de listas de compras'),
                  ),
                  ListTile(
                    leading: Icon(Icons.psychology_alt),
                    title: Text('Desenvolvido com o instuito de melhorar sua vida na hora de ir as compras!!'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class Rec_Senha_Email_View extends StatefulWidget {
  const Rec_Senha_Email_View({super.key});

  @override
  State<Rec_Senha_Email_View> createState() => _Rec_Senha_Email_ViewState();
}

class _Rec_Senha_Email_ViewState extends State<Rec_Senha_Email_View> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //Controladores para os Campos de Texto
  var txtValor1 = TextEditingController();
  var txtValor2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Icon(Icons.phonelink_lock,
                    size: 80.0, color: Colors.orange),

                SizedBox(height: 30),
                TextFormField(
                  controller: txtValor1,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'Exemplolucas@algomail.com',
                    border: OutlineInputBorder(),
                  ),

                  //
                  // Validação
                  //
                   validator: (value) {
                      if (value == null) {
                        return 'Informe um valor';
                      } else if (value.isEmpty) {
                        return 'Informe um valor';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Informe um e-mail válido';
                      }
                      return null;
                      },
                ),

                //ElevatedButton
                //TextButton
                //OutlinedButton
                SizedBox(height: 15),

                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(200, 60),
                    backgroundColor: Color.fromARGB(255, 184, 223, 255),
                    foregroundColor: Color.fromARGB(255, 97, 95, 74),
                  ),
                  onPressed: () {
                    //
                    // Executar o processo de VALIDAÇÃO
                    //
                    if (formKey.currentState!.validate()) {
                      //Validação com sucesso
                      Navigator.pushNamed(context, 'Rec');
                    } else {
                      //Erro na Validação
                    }
                  },
                  child: Text(
                    'validar e-mail',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
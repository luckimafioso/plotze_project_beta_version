// ignore_for_file: prefer_const_constructors, camel_case_types, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class Login_View extends StatefulWidget {
  const Login_View({Key? key});

  @override
  State<Login_View> createState() => _Login_ViewState();
}

class _Login_ViewState extends State<Login_View> {
  var formKey = GlobalKey<FormState>();
  //Controladores para os Campos de Texto
  var txtValor1 = TextEditingController();
  var txtValor2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 50, 50, 100),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
              height: 400,
                width: 300,
              child: Image.asset(
                'lib/images/imagem_lista.png',
                fit:BoxFit.scaleDown,                
              ),
            ),

                TextFormField(
                  controller: txtValor1,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    hintText: 'Exemplo@algomail.com',
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

                SizedBox(height: 30),
                TextFormField(
                  controller: txtValor2,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    hintText: '********',
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
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),

                // ElevadoButton
                // TextButton
                // OutlinedButton
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(140, 40),
                        backgroundColor: Color.fromARGB(255, 184, 223, 255),
                        foregroundColor: Color.fromARGB(255, 54, 53, 41),
                      ),
                      onPressed: () {
                        //
                        // Executar o processo de VALIDAÇÃO
                        //
                        if (formKey.currentState!.validate()) {
                          // Validação com sucesso
                          Navigator.pushNamed(context, 'Princ');
                        } else {
                          // Erro na Validação
                        }
                      },
                      child: Text(
                        'Log-in',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(140, 40),
                        backgroundColor: Color.fromARGB(255, 184, 223, 255),
                        foregroundColor: Color.fromARGB(255, 54, 53, 41),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'Cadastro');
                      },
                      child: Text(
                        'Sign-up',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'Rec_Email');
                  },
                  child: Text(
                    'forgot your password?',
                    style: TextStyle(fontSize: 18),
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

// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class Cadastro_View extends StatefulWidget {
  const Cadastro_View({super.key});

  @override
  State<Cadastro_View> createState() => _Cadastro_ViewState();
}

class _Cadastro_ViewState extends State<Cadastro_View> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //Controladores para os Campos de Texto
  var txtValor1 = TextEditingController();
  var txtValor2 = TextEditingController();
  var txtValor3 = TextEditingController();
  var txtValor4 = TextEditingController();

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
                Icon(Icons.format_list_bulleted_add,
                    size: 80.0, color: Colors.orange),

                SizedBox(height: 30),
                TextFormField(
                  controller: txtValor1,
                  decoration: InputDecoration(
                    labelText: 'Nome de Usuario',
                    hintText: 'Larissa Alves',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Infome um valor';
                    } else if (value.isEmpty) {
                      return 'Infome um valor';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 30),
                TextFormField(
                  controller: txtValor2,
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

                SizedBox(height: 30),
                TextFormField(
                  controller: txtValor3,
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
                TextFormField(
                  controller: txtValor4,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirmar senha',
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
                    } else if (value != txtValor3.text) {
                      return 'As senhas não coincidem';
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
                      Navigator.pushNamed(context, 'Login');
                    } else {
                      //Erro na Validação
                    }
                  },
                  child: Text(
                    'criar conta',
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

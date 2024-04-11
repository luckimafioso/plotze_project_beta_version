// ignore_for_file: library_private_types_in_public_api, camel_case_types, prefer_const_constructors, use_build_context_synchronously, prefer_const_constructors_in_immutables, use_super_parameters

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Gerenciar_Listas_View extends StatefulWidget {
  const Gerenciar_Listas_View({super.key});

  @override
  _Gerenciar_Listas_ViewState createState() => _Gerenciar_Listas_ViewState();
}
  
class _Gerenciar_Listas_ViewState extends State<Gerenciar_Listas_View> {
    List<String> listas = [];

  @override
  void initState() {
    super.initState();
    _loadListas();
  }

  _loadListas() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> savedListas = prefs.getStringList('listas') ?? [];
    setState(() {
      // Remova entradas vazias, se houver
      listas = savedListas.where((lista) => lista.isNotEmpty).toList();
    });
  }

  Future<void> _editListName(BuildContext context, String currentName, int index) async {
    String? newName = await showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController(text: currentName);
        return AlertDialog(
          title: Text('Editar Nome da Lista'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Novo Nome'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, controller.text);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
    
    if (newName != null && newName != currentName) {
      setState(() {
        listas[index] = newName;
      });
      
      final prefs = await SharedPreferences.getInstance();
      // Renomear a chave do SharedPreferences para refletir o novo nome da lista
      final List<String>? listaItens = prefs.getStringList(currentName);
      if (listaItens != null) {
        await prefs.remove(currentName);
        await prefs.setStringList(newName, listaItens);
      }
      
      prefs.setStringList('listas', listas);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Listas'),
      ),
      body: listas.isEmpty
          ? Center(
              child: Text('Nenhuma lista disponível'),
            )
          : ListView.builder(
              itemCount: listas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(listas[index]),
                  subtitle: Text('Clique para gerenciar itens'),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListaItensView(nomeLista: listas[index]),
                      ),
                    );
                    // Recarrega as listas após adição ou edição de itens
                    _loadListas();
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      await _editListName(context, listas[index], index);
                    },
                  ),
                );
              },
            ),
    );
  }
}

class ListaItensView extends StatefulWidget {
  final String nomeLista;

  ListaItensView({Key? key, required this.nomeLista}) : super(key: key);

  @override
  _ListaItensViewState createState() => _ListaItensViewState();
}

class _ListaItensViewState extends State<ListaItensView> {
  List<ItemLista> itens = [];

  @override
  void initState() {
    super.initState();
    _loadItens();
  }

  _loadItens() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? itensStrings =
        prefs.getStringList(widget.nomeLista); // Usar o nome da lista como chave
    if (itensStrings != null) {
      setState(() {
        itens = itensStrings.map((itemString) {
          final parts = itemString.split(',');
          return ItemLista(
            name: parts[0],
            quantity: parts[1],
            notes: parts[2],
            isBought: parts[3] == 'true',
          );
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomeLista),
      ),
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Nome: ${itens[index].name}'),
            subtitle: Text(
              'Quantidade: ${itens[index].quantity}\nNotas: ${itens[index].notes}',
            ),
            trailing: Icon(
              itens[index].isBought ? Icons.check : Icons.close,
              color: itens[index].isBought ? Colors.green : Colors.red,
            ),
            onTap: () async {
              await _editItem(context, widget.nomeLista, itens[index]);
              // Recarrega os itens após edição
              _loadItens();
            },
            onLongPress: () async {
              await _deleteItem(itens[index]);
              // Recarrega os itens após exclusão
              _loadItens();
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Adicionar Item',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _editItem(
      BuildContext context, String listaName, ItemLista item) async {
    // Implementar lógica para editar item
  }

  Future<void> _deleteItem(ItemLista item) async {
    setState(() {
      itens.remove(item);
    });

    final prefs = await SharedPreferences.getInstance();
    final List<String> updatedItensStrings = itens
        .map((item) =>
            '${item.name},${item.quantity},${item.notes},${item.isBought}')
        .toList();
    await prefs.setStringList(widget.nomeLista, updatedItensStrings);
  }

  Future<void> _addItem() async {
    // Implementar lógica para adicionar item
  }
}

class ItemLista {
  final String name;
  final String quantity;
  final String notes;
  final bool isBought;

  ItemLista({
    required this.name,
    required this.quantity,
    required this.notes,
    this.isBought = false,
  });
}
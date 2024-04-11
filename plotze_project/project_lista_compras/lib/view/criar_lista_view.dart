// ignore_for_file: camel_case_types, library_private_types_in_public_api, use_key_in_widget_constructors, deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Criar_Lista_View(),
    );
  }
}

class Criar_Lista_View extends StatefulWidget {
  @override
  _Criar_Lista_ViewState createState() => _Criar_Lista_ViewState();
}

class _Criar_Lista_ViewState extends State<Criar_Lista_View> {
  String listName = '';
  List<ItemLista> items = [];
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _listNameController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  bool isEditingListName = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      listName = prefs.getString('Nome da lista') ?? '';
      final List<String> itemsStrings = prefs.getStringList('Items') ?? [];
      items = itemsStrings.map((itemString) {
        final parts = itemString.split(',');
        return ItemLista(
          name: parts[0],
          quantity: parts[1],
          notes: parts[2],
          isBought: parts[3] == 'true',
        );
      }).toList();
    });

    if (listName.isEmpty && items.isEmpty) {
      _chooseListName();
    }
  }

  _saveData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('listName', listName);
  final List<String> itemsStrings = items.map((item) {
    return '${item.name},${item.quantity},${item.notes},${item.isBought}';
  }).toList();
  await prefs.setStringList(listName, itemsStrings); // Usar o nome da lista como chave
  

    // Salvar o nome da lista na lista de listas
    final List<String> listas = prefs.getStringList('listas') ?? [];
    if (!listas.contains(listName)) {
      listas.add(listName);
      await prefs.setStringList('listas', listas);
    }
  }

  _chooseListName() async {
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escolha um nome:'),
        content: TextField(
          controller: _listNameController,
          decoration: const InputDecoration(
            labelText: 'Adicione um nome:',
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, 'Princ');
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final name = _listNameController.text;
              if (name.isNotEmpty) {
                Navigator.of(context).pop(name);
              }
            },
            child: const Text('Criar'),
          ),
        ],
      ),
    );
    if (name != null) {
      setState(() {
        listName = name;
        _saveData();
      });
    }
  }

  _editListName() async {
  setState(() {
    isEditingListName = true;
  });
  _listNameController.text = listName;

  final newName = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Editar nome'),
      content: TextField(
        controller: _listNameController,
        decoration: const InputDecoration(
          labelText: 'Nome da lista:',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              isEditingListName = false;
            });
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            final newName = _listNameController.text;
            if (newName.isNotEmpty) {
              // Exclua a entrada antiga com o nome anterior
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove(listName);
              // Atualize o nome na lista de listas
              final List<String> listas = prefs.getStringList('listas') ?? [];
              listas.remove(listName);
              listas.add(newName);
              await prefs.setStringList('listas', listas);
              // Atualize o nome atual da lista e salve os dados
              setState(() {
                listName = newName;
                isEditingListName = false;
                _saveData();
              });
              Navigator.of(context).pop(newName);
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    ),
  );
  if (newName != null) {
    setState(() {
      listName = newName;
      _saveData();
    });
  }
  }

  _editItem(int index) async {
    _itemController.text = items[index].name;
    _quantityController.text = items[index].quantity;
    _notesController.text = items[index].notes;

    final isBought = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _itemController,
              decoration: const InputDecoration(
                labelText: 'Nome do Item:',
              ),
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantidade:',
              ),
            ),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notas:',
              ),
            ),
            Row(
              children: [
                const Text('Marcar como comprado: '),
                Checkbox(
                  value: items[index].isBought,
                  onChanged: (value) {
                    Navigator.of(context).pop(value);
                  },
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final newItem = ItemLista(
                name: _itemController.text,
                quantity: _quantityController.text,
                notes: _notesController.text,
                isBought: items[index].isBought,
              );
              if (newItem.name.isNotEmpty) {
                setState(() {
                  items[index] = newItem;
                  _saveData();
                  Navigator.of(context).pop();
                });
              }
            },
            child: const Text('Salvar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                items.removeAt(index);
                _saveData();
                Navigator.of(context).pop();
              });
            },
            child: const Text('excluir'),
          ),
        ],
      ),
    );
    if (isBought != null) {
      setState(() {
        items[index].isBought = isBought;
        _saveData();
      });
    }
  }

  _addNewItem() async {
    _itemController.text = '';
    _quantityController.text = '';
    _notesController.text = '';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar item'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _itemController,
              decoration: const InputDecoration(
                labelText: 'Nome item:',
              ),
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantidade:',
              ),
            ),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notas:',
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final newItem = ItemLista(
                name: _itemController.text,
                quantity: _quantityController.text,
                notes: _notesController.text,
                isBought: false,
              );
              if (newItem.name.isNotEmpty) {
                setState(() {
                  items.add(newItem);
                  _saveData();
                  Navigator.of(context).pop();
                });
              }
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<ItemLista> filteredItems = _searchController.text.isEmpty
        ? items
        : items
            .where((item) =>
                item.name.toLowerCase().contains(_searchController.text))
            .toList();

    return WillPopScope(
      onWillPop: () async {
        // Clear data before popping the screen
        setState(() {
          listName = '';
          items.clear();
          _saveData();
        });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              if (!isEditingListName) {
                _editListName();
              }
            },
            child: Row(
              children: [
                Text(listName.isNotEmpty ? listName : ''),
                const Icon(Icons.edit),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Procurar'),
                    content: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: '',
                      ),
                      onChanged: (text) {
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Row(
                children: [
                  filteredItems[index].isBought
                      ? const Icon(Icons.check_circle)
                      : const Icon(Icons.radio_button_unchecked),
                  const SizedBox(width: 7),
                  Text(filteredItems[index].name),
                ],
              ),
              subtitle: Text(
                  'Quantidade: ${filteredItems[index].quantity}\nNotas: ${filteredItems[index].notes}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _editItem(items.indexOf(filteredItems[index])),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNewItem,
          tooltip: 'Adicionar item',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class ItemLista {
  final String name;
  final String quantity;
  final String notes;
  bool isBought;

  ItemLista({
    required this.name,
    required this.quantity,
    required this.notes,
    this.isBought = false,
  });
}

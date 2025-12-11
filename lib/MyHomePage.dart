import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //
  // _recuperarBD() async {
  //   final caminhoBD = await getDatabasesPath();
  //   final localBD = join(caminhoBD, "banco_minhas_anotacoes.db");
  //
  //   var bd = await openDatabase(
  //     localBD,
  //     version: 1,
  //     onCreate: (bd, bdVersaoRecente) {
  //       String sql =
  //           "CREATE TABLE anotacoes (id INTEGER PRIMARY KEY AUTOINCREMENT, titulo VARCHAR, descricao TEXT, data DATETIME)";
  //       bd.execute(sql);
  //     },
  //   );
  // }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void _exibirTelaCadastro() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Nova an"
                "otação"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  autofocus: true,
                  decoration: const InputDecoration(
                      labelText: "Título",
                      hintText: "Digite título..."),

                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      labelText: "Descrição",
                      hintText: "Digite descrição..."),
                )
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar")
                  ),
              ElevatedButton(
                  onPressed: () {
                    //função para salvar/atualizar
                    Navigator.pop(context);
                  },
                  child: const Text("Salvar"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Minhas Anotações"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        foregroundColor: Theme.of(context).colorScheme.inverseSurface,
        child: const Icon(Icons.add),
        onPressed: () {
          _exibirTelaCadastro();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:notas_diarias_app/model/Anotacao.dart';
import 'package:notas_diarias_app/helper/AnotacoesHelper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  AnotacoesHelper _db = AnotacoesHelper();
  List<Anotacao> anotacoes = [];

  @override
  void initState() {
    super.initState();
    _recuperarAnotacoes();
  }

  void _exibirTelaCadastro() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Nova anotação"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: "Título",
                  hintText: "Digite título...",
                ),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: "Descrição",
                  hintText: "Digite descrição...",
                ),
              )
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                _salvarAtualizarAnotacao();
                Navigator.pop(context);
              },
              child: const Text("Salvar"),
            )
          ],
        );
      },
    );
  }

  _salvarAtualizarAnotacao() async {
    String? titulo = _titleController.text;
    String? descricao = _descriptionController.text;

    Anotacao anotacao = Anotacao(titulo, descricao, DateTime.now().toString());

    int resultado = await _db.salvarAnotacao(anotacao);

    print("Dados salvos: " + resultado.toString());

    _titleController.clear();
    _descriptionController.clear();

    _recuperarAnotacoes();
  }

  _recuperarAnotacoes() async {
    List anotacoesRecuperadas = await _db.recuperarAnotacoes();

    print("Lista anotacoes:\n" + anotacoesRecuperadas.toString());

    List<Anotacao> listaTemporaria = [];
    for (var item in anotacoesRecuperadas) {
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }

    setState(() {
      anotacoes = listaTemporaria;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Minhas Anotações"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: anotacoes.length,
              itemBuilder: (context, index) {
                final anotacao = anotacoes[index];
                return ListTile(
                  title: Text(anotacao.titulo ?? ''),
                  subtitle: Text(anotacao.descricao ?? ''),
                );
              },
            ),
          ),
        ],
      ),
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

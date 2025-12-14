import 'package:flutter/material.dart';
import 'package:notas_diarias_app/model/anotacao.dart';
import 'package:notas_diarias_app/helper/anotacoes_helper.dart';
import 'detalhes_anotacao.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final AnotacoesHelper _db = AnotacoesHelper();
  List<Anotacao> anotacoes = [];

  @override
  void initState() {
    super.initState();
    _recuperarAnotacoes();
  }

  Future<void> _exibirTelaCadastro({Anotacao? anotacao}) async {
    String textoSalvarAtualizar = "";
    if (anotacao == null) {
      _titleController.text = "";
      _descriptionController.text = "";
      textoSalvarAtualizar = "Salvar";
    } else {
      _titleController.text = anotacao.titulo.toString();
      _descriptionController.text = anotacao.descricao.toString();
      textoSalvarAtualizar = "Atualizar";
    }

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("$textoSalvarAtualizar anotação"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
              onPressed: () async {
                await _salvarAtualizarAnotacao(anotacaoSelecionada: anotacao);
                if (!mounted) return;
                Navigator.pop(context);
              },
              child: Text(textoSalvarAtualizar),
            )
          ],
        );
      },
    );
  }

  _salvarAtualizarAnotacao({Anotacao? anotacaoSelecionada}) async {
    String? titulo = _titleController.text;
    String? descricao = _descriptionController.text;

    if (anotacaoSelecionada == null) {
      Anotacao anotacao =
          Anotacao(titulo, descricao, DateTime.now().toString());
      await _db.salvarAnotacao(anotacao);
    } else {
      anotacaoSelecionada.titulo = titulo;
      anotacaoSelecionada.descricao = descricao;
      anotacaoSelecionada.data = DateTime.now().toString();
      await _db.atualizarAnotacao(anotacaoSelecionada);
    }

    _titleController.clear();
    _descriptionController.clear();

    _recuperarAnotacoes();
  }

  _recuperarAnotacoes() async {
    List anotacoesRecuperadas = await _db.recuperarAnotacoes();

    List<Anotacao> listaTemporaria = [];
    for (var item in anotacoesRecuperadas) {
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }

    setState(() {
      anotacoes = listaTemporaria;
    });
  }

  _removerAnotacao(int id) async {
    await _db.removerAnotacao(id);
    _recuperarAnotacoes();
  }

  void _removerAnotacaoComConfirmacao(int id) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Certeza que deseja excluir?"),
          content: const Text("Esta ação não poderá ser desfeita."),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () async {
                await _db.removerAnotacao(id);
                await _recuperarAnotacoes();
                if (!mounted) return;
                Navigator.pop(context);
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

  String _formatarData(String data) {
    try {
      DateTime dateTime = DateTime.parse(data);
      return "${dateTime.day.toString().padLeft(2, '0')}/"
          "${dateTime.month.toString().padLeft(2, '0')}/"
          "${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:"
          "${dateTime.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return data;
    }
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
                return Card(
                  child: ListTile(
                    title: Text(anotacao.titulo.toString()),
                    subtitle: Text(
                        "${_formatarData(anotacao.data.toString())} - ${anotacao.descricao}"),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalhesAnotacao(
                            anotacao: anotacao,
                            onEdit: (anotacao) async =>
                                await _exibirTelaCadastro(anotacao: anotacao),
                            onDelete: (id) => _removerAnotacao(id),
                          ),
                        ),
                      );
                      _recuperarAnotacoes();
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _exibirTelaCadastro(anotacao: anotacao);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(Icons.edit, color: Colors.green),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _removerAnotacaoComConfirmacao(anotacao.id!);
                          },
                          child: const Icon(Icons.delete, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
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

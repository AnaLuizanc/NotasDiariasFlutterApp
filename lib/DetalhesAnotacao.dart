import 'package:flutter/material.dart';
import 'package:notas_diarias_app/model/Anotacao.dart';

class DetalhesAnotacao extends StatelessWidget {
  final Anotacao anotacao;
  final Function(Anotacao) onEdit;
  final Function(int) onDelete;

  const DetalhesAnotacao({
    super.key,
    required this.anotacao,
    required this.onEdit,
    required this.onDelete,
  });

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

  void _confirmarExclusao(BuildContext context) {
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
              onPressed: () {
                Navigator.pop(context);
                onDelete(anotacao.id!);
                Navigator.pop(context);
              },
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(anotacao.titulo ?? 'Anotação'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.green),
            onPressed: () async {
              await onEdit(anotacao);
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _confirmarExclusao(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data: ${_formatarData(anotacao.data.toString())}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 20),
            Text(
              'Descrição:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  anotacao.descricao ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

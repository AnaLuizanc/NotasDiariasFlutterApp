import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/Anotacao.dart';

class AnotacoesHelper {
  static final String nomeTabela = "anotacoes";

  factory AnotacoesHelper() {
    return _anotacoesHelper;
  }

  AnotacoesHelper._internal();

  static final AnotacoesHelper _anotacoesHelper = AnotacoesHelper._internal();

  Database? _db;

  get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDB();
      return _db;
    }
  }

  inicializarDB() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco_minhas_anotacoes.db");

    var db = await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    String sql =
        "CREATE TABLE $nomeTabela (id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "titulo VARCHAR, descricao TEXT, data DATETIME)";
    await db.execute(sql);
  }

  Future<int> salvarAnotacao(Anotacao anotacao) async {
    var bancoDados = await db;
    int resultado = await bancoDados.insert(nomeTabela, anotacao.toMap());
    return resultado;
  }

  recuperarAnotacoes() async {
    var bancoDados = await db;
    String sql = "SELECT * FROM $nomeTabela ORDER BY data DESC";
    List anotacoes = await bancoDados.rawQuery(sql);
    return anotacoes;
  }

  Future<int> removerAnotacao(int id) async {
    var bancoDados = await db;
    return await bancoDados.delete(nomeTabela, where: "id = ?", whereArgs: [id]);
  }
}

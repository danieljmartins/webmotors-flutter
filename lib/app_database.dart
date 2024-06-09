import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:webmotors/main.dart';

Future<Database> createDatabase() {
  return getDatabasesPath().then(
    (dbPath) {
      final String path = join(
        dbPath,
        'webmotors.db',
      );
      return openDatabase(
        path,
        onCreate: (db, version) {
          db.execute('CREATE TABLE veiculos('
              'id INTEGER PRIMARY KEY, '
              'marca TEXT, '
              'modelo TEXT, '
              'ano INTEGER, '
              'kilometragem REAL, '
              'cor TEXT, '
              'preco REAL)');
        },
        version: 1,
        onDowngrade:
            onDatabaseDowngradeDelete, // Força a recriação do banco de dados
      );
    },
  );
}

Future<int> save(Veiculo veiculo) {
  return createDatabase().then(
    (db) {
      final Map<String, dynamic> veiculoMap = {};
      veiculoMap['marca'] = veiculo.marca;
      veiculoMap['modelo'] = veiculo.modelo;
      veiculoMap['ano'] = veiculo.ano;
      veiculoMap['kilometragem'] = veiculo.kilometragem;
      veiculoMap['cor'] = veiculo.cor;
      veiculoMap['preco'] = veiculo.preco;
      return db.insert('veiculos', veiculoMap);
    },
  );
}

Future<List<Veiculo>> findAll() {
  return createDatabase().then(
    (db) {
      return db.query('veiculos').then(
        (maps) {
          final List<Veiculo> veiculos = [];
          for (Map<String, dynamic> map in maps) {
            final int id = map['id'] ?? 0;
            final String marca = map['marca'] ?? '';
            final String modelo = map['modelo'] ?? '';
            final int ano = map['ano'] ?? 0;
            final double kilometragem = map['kilometragem'] ?? 0.0;
            final String cor = map['cor'] ?? '';
            final double preco = map['preco'] ?? 0.0;

            final Veiculo veiculo =
                Veiculo(id, marca, modelo, ano, kilometragem, cor, preco);
            veiculos.add(veiculo);
          }
          return veiculos;
        },
      ).catchError((error) {
        debugPrint('Erro ao consultar o banco de dados: $error');
        throw Exception('Erro ao consultar o banco de dados');
      });
    },
  );
}

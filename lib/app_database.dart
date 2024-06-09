import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'veiculo.dart';

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
          db.execute('''
            CREATE TABLE veiculos(
              id INTEGER PRIMARY KEY, 
              marca TEXT, 
              modelo TEXT, 
              ano INTEGER, 
              kilometragem REAL, 
              cor TEXT, 
              preco REAL)
          ''');
        },
        version: 1,
        onDowngrade: onDatabaseDowngradeDelete,
      );
    },
  );
}

Future<int> save(Veiculo veiculo) {
  return createDatabase().then(
    (db) {
      final Map<String, dynamic> veiculoMap = {
        'marca': veiculo.marca,
        'modelo': veiculo.modelo,
        'ano': veiculo.ano,
        'kilometragem': veiculo.kilometragem,
        'cor': veiculo.cor,
        'preco': veiculo.preco,
      };
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
            final Veiculo veiculo = Veiculo(
              map['id'] ?? 0,
              map['marca'] ?? '',
              map['modelo'] ?? '',
              map['ano'] ?? 0,
              map['kilometragem'] ?? 0.0,
              map['cor'] ?? '',
              map['preco'] ?? 0.0,
            );
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

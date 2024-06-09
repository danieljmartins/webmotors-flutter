import 'package:flutter/material.dart';
import 'veiculo.dart';
import 'app_database.dart';

class FormularioVeiculos extends StatefulWidget {
  const FormularioVeiculos({super.key});

  @override
  _FormularioVeiculosState createState() => _FormularioVeiculosState();
}

class _FormularioVeiculosState extends State<FormularioVeiculos> {
  final TextEditingController _controladorMarca = TextEditingController();
  final TextEditingController _controladorModelo = TextEditingController();
  final TextEditingController _controladorAno = TextEditingController();
  final TextEditingController _controladorKilometragem =
      TextEditingController();
  final TextEditingController _controladorCor = TextEditingController();
  final TextEditingController _controladorPreco = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 2, 2),
        title: const Text(
          'Novo Veículo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controladorMarca,
              decoration: const InputDecoration(
                labelText: 'Marca',
              ),
              style: const TextStyle(
                fontSize: 24.0,
              ),
            ),
            TextField(
              controller: _controladorModelo,
              decoration: const InputDecoration(
                labelText: 'Modelo',
              ),
              style: const TextStyle(
                fontSize: 24.0,
              ),
            ),
            TextField(
              controller: _controladorAno,
              decoration: const InputDecoration(
                labelText: 'Ano',
              ),
              style: const TextStyle(
                fontSize: 24.0,
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _controladorKilometragem,
              decoration: const InputDecoration(
                labelText: 'Kilometragem',
              ),
              style: const TextStyle(
                fontSize: 24.0,
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _controladorCor,
              decoration: const InputDecoration(
                labelText: 'Cor',
              ),
              style: const TextStyle(
                fontSize: 24.0,
              ),
            ),
            TextField(
              controller: _controladorPreco,
              decoration: const InputDecoration(
                labelText: 'Preço',
              ),
              style: const TextStyle(
                fontSize: 24.0,
              ),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    final String marca = _controladorMarca.text;
                    final String modelo = _controladorModelo.text;
                    final int ano = int.tryParse(_controladorAno.text) ?? 0;
                    final double kilometragem =
                        double.tryParse(_controladorKilometragem.text) ?? 0.0;
                    final String cor = _controladorCor.text;
                    final double preco =
                        double.tryParse(_controladorPreco.text) ?? 0.0;

                    final Veiculo novoVeiculo = Veiculo(
                        0, marca, modelo, ano, kilometragem, cor, preco);
                    save(novoVeiculo).then(
                      (id) => Navigator.pop(context),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 241, 2, 2)),
                  ),
                  child: const Text(
                    'Salvar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

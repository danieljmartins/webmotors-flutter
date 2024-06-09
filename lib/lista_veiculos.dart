import 'package:flutter/material.dart';
import 'formulario_veiculos.dart';
import 'veiculo.dart';
import 'app_database.dart';

class ListaVeiculos extends StatefulWidget {
  const ListaVeiculos({super.key});

  @override
  _VeiculosListaState createState() => _VeiculosListaState();
}

class _VeiculosListaState extends State<ListaVeiculos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 2, 2),
        title: const Text(
          'Carros',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Veiculo>>(
        initialData: const [],
        future: findAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("Carregando..."),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Erro: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            final List<Veiculo> veiculos = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) {
                final Veiculo veiculo = veiculos[index];
                return VeiculoItem(veiculo);
              },
              itemCount: veiculos.length,
            );
          } else {
            return const Center(
              child: Text("Nenhum veículo encontrado."),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 241, 2, 2),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => const FormularioVeiculos(),
                ),
              )
              .then(
                (value) => setState(() {}),
              );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35.0,
        ),
      ),
    );
  }
}

class VeiculoItem extends StatelessWidget {
  final Veiculo veiculo;

  const VeiculoItem(this.veiculo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.directions_car),
        title: Text(veiculo.modelo),
        subtitle: Text('Ano: ${veiculo.ano}, Cor: ${veiculo.cor}'),
      ),
    );
  }
}

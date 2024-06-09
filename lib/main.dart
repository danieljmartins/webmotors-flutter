import 'package:webmotors/app_database.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const WebmotorsApp(),
  );
}

class WebmotorsApp extends StatelessWidget {
  const WebmotorsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 241, 2, 2),
        title: const Text(
          'Webmotors',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
                'https://grandesnomesdapropaganda.com.br/wp-content/uploads/2017/01/webmotors-logo.jpg'),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ListaVeiculos(),
                    ),
                  );
                },
                child: Container(
                  height: 140,
                  width: 120,
                  padding: const EdgeInsets.all(8.0),
                  color: const Color.fromARGB(255, 241, 2, 2),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text(
                        'Lista de Carros',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
                return _VeiculoItem(veiculo);
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

class Veiculo {
  final int id;
  final String marca;
  final String modelo;
  final int ano;
  final double kilometragem;
  final String cor;
  final double preco;

  Veiculo(this.id, this.marca, this.modelo, this.ano, this.kilometragem,
      this.cor, this.preco);
}

class _VeiculoItem extends StatelessWidget {
  final Veiculo veiculo;

  const _VeiculoItem(this.veiculo);

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

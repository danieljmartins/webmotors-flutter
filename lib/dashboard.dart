import 'package:flutter/material.dart';
import 'lista_veiculos.dart';

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

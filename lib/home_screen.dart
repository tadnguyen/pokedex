import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comic_app/pokemon_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List pokeDex = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      fetchPokemonData();
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: 100,
            left: 20,
            child: Text(
              'Pokedex',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: -40,
            right: -50,
            child: Image.asset(
              'images/pokeball.png',
              width: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: 150,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                pokeDex.length != null
                    ? Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.4,
                          ),
                          itemCount: pokeDex.length,
                          itemBuilder: (context, index) {
                            var type = pokeDex[index]['type'][0];
                            return InkWell(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: type == 'Grass'
                                        ? Colors.greenAccent
                                        : type == 'Fire'
                                            ? Colors.redAccent
                                            : type == 'Water'
                                                ? Colors.blueAccent
                                                : type == 'Electric'
                                                    ? Colors.yellow
                                                    : type == 'Rock'
                                                        ? Colors.grey
                                                        : type == 'Ground'
                                                            ? Colors.brown
                                                            : type == 'Psychic'
                                                                ? Colors.indigo
                                                                : type ==
                                                                        'Fighting'
                                                                    ? Colors
                                                                        .orange
                                                                    : type ==
                                                                            'Bug'
                                                                        ? Colors
                                                                            .lightGreen
                                                                        : type ==
                                                                                'Ghost'
                                                                            ? Colors.deepPurple
                                                                            : type == 'Normal'
                                                                                ? Colors.black26
                                                                                : type == 'Poison'
                                                                                    ? Colors.deepPurpleAccent
                                                                                    : Colors.pink,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: -10,
                                        right: -10,
                                        child: Image.asset(
                                          'images/pokeball.png',
                                          height: 100,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Positioned(
                                        top: 20,
                                        left: 10,
                                        child: Text(
                                          pokeDex[index]['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 45,
                                        left: 20,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                            color: Colors.black26,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              top: 4,
                                              bottom: 4,
                                            ),
                                            child: Text(
                                              type.toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        right: 5,
                                        child: CachedNetworkImage(
                                          imageUrl: pokeDex[index]['img'],
                                          height: 100,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => PokemonDetail(
                                              pokemonDetail: pokeDex[index],
                                              color: type == 'Grass'
                                                  ? Colors.greenAccent
                                                  : type == 'Fire'
                                                      ? Colors.redAccent
                                                      : type == 'Water'
                                                          ? Colors.blueAccent
                                                          : type == 'Electric'
                                                              ? Colors.yellow
                                                              : type == 'Rock'
                                                                  ? Colors.grey
                                                                  : type ==
                                                                          'Ground'
                                                                      ? Colors
                                                                          .brown
                                                                      : type ==
                                                                              'Psychic'
                                                                          ? Colors
                                                                              .indigo
                                                                          : type == 'Fighting'
                                                                              ? Colors.orange
                                                                              : type == 'Bug'
                                                                                  ? Colors.lightGreen
                                                                                  : type == 'Ghost'
                                                                                      ? Colors.deepPurple
                                                                                      : type == 'Normal'
                                                                                          ? Colors.black26
                                                                                          : type == 'Poison'
                                                                                              ? Colors.deepPurpleAccent
                                                                                              : Colors.pink,
                                              heroTag: index,
                                            )));
                              },
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void fetchPokemonData() {
    var url = Uri.https("raw.githubusercontent.com",
        "Biuni/PokemonGO-Pokedex/master/pokedex.json");
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        var decodedJsonData = jsonDecode(value.body);
        pokeDex = decodedJsonData['pokemon'];
        setState(() {});
      }
    });
  }
}

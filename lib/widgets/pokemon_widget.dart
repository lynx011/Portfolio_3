import 'package:flutter/material.dart';
import 'package:pokemon/objects/pokemon_ob.dart';
import 'package:pokemon/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PokemonWidget extends StatelessWidget {
  PokemonOb pokemon;

  PokemonWidget(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDetail(context);
      },
      child: Card(
        elevation: 5.0,
        child: Column(
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: IMG_URL + pokemon.variations[0].image,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  backgroundColor: Colors.teal,
                  color: Colors.amber,
                  strokeWidth: 4.0,
                )),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
              //     child: Image.network(
              //   IMG_URL + pokemon.variations[0].image,
              //   fit: BoxFit.fill,
              // ),
            ),
            const SizedBox(height: 10.0),
            Text(
              pokemon.name.toString(),
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[400],
                  letterSpacing: 2.0),
            ),
            const SizedBox(height: 10.0),
            Container(
              margin: const EdgeInsets.only(left: 5.0,right: 5.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.amber[400],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  pokemon.variations[0].specie,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2.0),
                )),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  showDetail(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 3.0,
            title: Text(
              pokemon.name,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[400]),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 50),
                  alignment: Alignment.center,
                  child: Image.network(IMG_URL + pokemon.variations[0].image),
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 5.0),
                Text(
                  'Types',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[400]),
                ),
                const SizedBox(height: 10.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: pokemon.variations[0].types.map((val) {
                    return Container(
                        margin: const EdgeInsets.all(5.0),
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.amber[400],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          val,
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2.0),
                        ));
                  }).toList(),
                ),
                const SizedBox(height: 15.0),
                Text(
                  'Abilities',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[400]),
                ),
                const SizedBox(height: 10.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: pokemon.variations[0].abilities.map((val) {
                    return Expanded(
                      child: Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.amber[400],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            val,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2.0),
                          )),
                    );
                  }).toList(),
                ),
                SizedBox(height: 15.0),
                Text(
                  "Height : ${pokemon.variations[0].height.toString()} m",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      letterSpacing: 2.0),
                ),
                const SizedBox(height: 5.0),
                Text(
                  "Weight : ${pokemon.variations[0].height.toString()} kg",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[700],
                      letterSpacing: 2.0),
                ),

                const SizedBox(height: 15.0),
                Center(
                  child: TextButton.icon(
                      onPressed: () async {
                        if (await canLaunch(pokemon.link)) {
                          await launch(pokemon.link);
                        } else {
                          const Text("Can't Launch");
                        }
                      },
                      label: const Text('More Details'),
                      icon: const Icon(Icons.chevron_right)),
                )
              ],
            ),
          );
        });
  }
}

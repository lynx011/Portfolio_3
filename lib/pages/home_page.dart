import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/bloc/home_bloc.dart';
import 'package:pokemon/objects/pokemon_ob.dart';
import 'package:pokemon/objects/response_ob.dart';
import 'dart:convert';
import 'package:pokemon/utils/constants.dart';
import 'package:pokemon/widgets/pokemon_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = HomeBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon'),
        centerTitle: true,
      ),
      body: StreamBuilder<ResponseOb?>(
          stream: _bloc.getStream(),
          initialData: ResponseOb(
              msgState: MsgState.loading,
              errState: ErrState.unknownErr,
              data: MsgState.data),
          builder: (BuildContext context, AsyncSnapshot<ResponseOb?> snapshot) {
            ResponseOb? res = snapshot.data;
            if (res!.msgState == MsgState.data) {
              List<PokemonOb> pokemonList = res.data;
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    ),
                    itemCount: pokemonList.length,
                    itemBuilder: (context, index) {
                      return PokemonWidget(pokemonList[index]);
                    }),
              );
            } else if (res.msgState == MsgState.error) {
              if (res.errState == ErrState.serverErr) {
                return Center(
                    child: Text(
                  '500 | Server Error',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.grey[600]),
                ));
              } else if (res.errState == ErrState.notFoundErr) {
                return Center(
                    child: Text(
                  '404 | not found',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.grey[600]),
                ));
              } else if (res.errState == ErrState.unknownErr) {
                return Center(
                    child: Text(
                  'Unknown Error',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      color: Colors.grey[600]),
                ));
              }
            } else if (res.msgState == MsgState.loading) {
              return const Center(child: CircularProgressIndicator(
                strokeWidth: 4.0,
              ));
            } else {
              const Center(child: CircularProgressIndicator());
            }
            return Container();
          }),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

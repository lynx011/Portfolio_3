import 'package:http/http.dart' as http;
import 'package:pokemon/objects/pokemon_ob.dart';
import 'dart:async';
import 'package:pokemon/objects/response_ob.dart';
import 'dart:convert';

import 'package:pokemon/utils/constants.dart';

class HomeBloc{
  
  
  final StreamController<ResponseOb> _controller = StreamController<ResponseOb>();
  
  Stream<ResponseOb> getStream() => _controller.stream;

  getData()async{

    ResponseOb resOb = ResponseOb(msgState: MsgState.loading, errState: ErrState.unknownErr, data: MsgState.data);
    _controller.sink.add(resOb);

    var response = await http.get(Uri.parse(BASE_URL));

    if(response.statusCode==200){
      
      List<dynamic> list = json.decode(response.body);
      List<PokemonOb> pokemonList = [];
      for (var element in list) {
        pokemonList.add(PokemonOb.fromMap(element));
      }
      resOb.msgState = MsgState.data;
      resOb.data = pokemonList;
      _controller.sink.add(resOb);
    }
    else if(response.statusCode==500){
      resOb.msgState = MsgState.error;
      resOb.errState = ErrState.serverErr;
      _controller.sink.add(resOb);
    }
    else if(response.statusCode==404){
      resOb.msgState = MsgState.error;
      resOb.errState = ErrState.notFoundErr;
      _controller.sink.add(resOb);
    }
    else{
      resOb.msgState = MsgState.error;
      resOb.errState = ErrState.unknownErr;
      _controller.sink.add(resOb);
    }
  }
  
  
  
  // dispose(){
  //   _controller.dispose();
  // }
}
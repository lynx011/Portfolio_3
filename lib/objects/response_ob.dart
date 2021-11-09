
class ResponseOb{

  MsgState msgState;
  ErrState errState;
  dynamic data;

  ResponseOb({required this.msgState,required this.errState,required this.data});
}

enum MsgState{
  data,
  error,
  loading,
  other,
}

enum ErrState{
  serverErr,
  notFoundErr,
  unknownErr,
}
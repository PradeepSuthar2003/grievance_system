class Session{
  static final Session _session = Session._internal();

  String? userId;

  factory Session(){
    return _session;
  }

  Session._internal(){

  }
}
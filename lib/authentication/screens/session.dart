class Session{
  static final Session _session = Session._internal();

  String? userId;
  String? role;
  String? email;

  factory Session(){
    return _session;
  }

  Session._internal(){

  }
}
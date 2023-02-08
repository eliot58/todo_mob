class Apisignin{
  final String token;


  Apisignin.fromApi(Map<String, dynamic> map)
      : token = map['results']['sunrise'];
}
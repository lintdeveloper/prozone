class Token {
  Token(this.name, this.value);
  final String name;
  final String value;

  Token.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        value = json['value'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'value': value
  };

}
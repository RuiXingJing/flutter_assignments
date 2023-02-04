class Contact {
  int id;
  String name;
  String mobile;
  String? landline;
  String? photo;
  bool isFavorite;

  Contact(this.id, this.name, this.mobile, this.isFavorite, {this.landline, this.photo});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'landline': landline,
      'photo': photo,
      'isFavorite': isFavorite ? 1 : 0
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      map['id'] as int,
      map['name'] as String,
      map['mobile'] as String,
      map['isFavorite'] == 0 ? false : true,
      landline: map['landline'] ?? '',
      photo: map['photo'] ?? '',
    );
  }
}

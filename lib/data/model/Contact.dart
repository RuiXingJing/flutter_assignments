class Contact {
  String name;
  String mobile;
  String? landline;
  String? photo;
  bool isFavorite;

  Contact(this.name, this.mobile, this.isFavorite,
      {this.landline, this.photo});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'mobile': mobile,
      'landline': landline,
      'photo': photo,
      'isFavorite': isFavorite
    };
  }
}

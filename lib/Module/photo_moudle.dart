class Photo {
  String? linkPhoto;
  String? description;
  bool isPaid=false;
  String? point="0";
  String? id;
  Photo(
      {this.linkPhoto,
        this.description,
        required this.isPaid,
        required this.point,
        this.id,
      });
  Photo.fromJson(Map<String, dynamic> json)
  {
    linkPhoto = json['link'];
    description = json['description'];
    isPaid = json['isPaid'];
    point = json['point'];
    id = json['id'];
  }
  Map<String, dynamic> toJson()
  {
    return {
      'link': linkPhoto,
      'description': description,
      'isPaid': isPaid,
      'point': point,
      'id': id,
    };
  }
}

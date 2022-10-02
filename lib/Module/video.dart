class Video {
  String? linkVideo;
  String? description;
bool isPaid=false;
String? point="0";
String? id;
  Video(
      {this.linkVideo,
        this.description,
        required this.isPaid,
        required this.point,
        this.id,
      });
  Video.fromJson(Map<String, dynamic> json)
  {
    linkVideo = json['link'];
    description = json['description'];
    isPaid = json['isPaid'];
    point = json['point'];
    id = json['id'];
  }
  Map<String, dynamic> toJson()
  {
    return {
      'link': linkVideo,
      'description': description,
      'isPaid': isPaid,
      'point': point,
      'id': id,
    };
  }
}

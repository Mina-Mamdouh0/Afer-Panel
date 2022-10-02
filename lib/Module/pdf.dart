class Pdf {
  String? linkPdf;
  String? description;
  bool isPaid=false;
  String? point="0";
  String? id;
  Pdf(
      {this.linkPdf,
        this.description,
        required this.isPaid,
        required this.point,
        this.id,
      });
  Pdf.fromJson(Map<String, dynamic> json)
  {
    linkPdf = json['link'];
    description = json['description'];
    isPaid = json['isPaid'];
    point = json['point'];
    id = json['id'];
  }
  Map<String, dynamic> toJson()
  {
    return {
      'link': linkPdf,
      'description': description,
      'isPaid': isPaid,
      'point': point,
      'id': id,
    };
  }
}

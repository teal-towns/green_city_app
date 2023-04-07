class LendLibraryItemClass {
  String? id, title, description, imageUrl, userIdOwner;
  List<String> tags = [];
  Map<String, dynamic> xOwner = {};
  double xDistanceKm = -999;
  LendLibraryItemClass(this.id, this.title, this.description, this.imageUrl, this.userIdOwner, this.tags,
    this.xOwner, this.xDistanceKm);
  LendLibraryItemClass.fromJson(Map<String, dynamic> json) {
    this.id = json['_id'];
    this.title = json['title'];
    this.userIdOwner = json['userIdOwner'];
    this.description = json['description'];
    this.imageUrl = json['imageUrl']?? '';
    //this.created_at = json['created_at'];
    this.tags = parseTags(json['tags'] != null ? json['tags'] : []);
    this.xOwner = json['xOwner'] != null ? json['xOwner'] : {};
    this.xDistanceKm = json['xDistanceKm'] != null ? json['xDistanceKm'] : -999;
  }

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'title': title,
      'description': description,
      'userIdOwner': userIdOwner,
      'imageUrl': imageUrl,
      //'created_at': created_at
    };

  List<String> parseTags(List<dynamic> tagsRaw) {
    List<String> tags = [];
    if (tagsRaw != null) {
      for (var tag in tagsRaw) {
        tags.add(tag);
      }
    }
    return tags;
  }
}

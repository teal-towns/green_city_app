class BlogClass {
  String? id, title, slug, text, image_url, image_credit, user_id_creator, created_at;
  List<String> tags = [];
  BlogClass(this.id, this.title, this.slug, this.text, this.image_url, this.image_credit, this.user_id_creator, this.created_at,
    this.tags);
  BlogClass.fromJson(Map<String, dynamic> json) {
    this.id = json['_id'];
    this.title = json['title'];
    this.slug = json['slug'];
    this.user_id_creator = json['user_id_creator'];
    this.text = json['text'];
    this.image_url = json['image_url'];
    this.image_credit = json['image_credit'];
    this.created_at = json['created_at'];
    this.tags = parseTags(json['tags'] != null ? json['tags'] : []);
  }

  Map<String, dynamic> toJson() =>
    {
      'id': id,
      'title': title,
      'slug': slug,
      'user_id_creator': user_id_creator,
      'text': text,
      'image_url': image_url,
      'image_credit': image_credit,
      'created_at': created_at
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

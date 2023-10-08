class ContactModel {
  int id = 0;
  String name = '';
  String phone = '';
  String avatar = '';

  ContactModel(this.id, this.name, this.phone, this.avatar);

  ContactModel.empty();

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    avatar = json['avatar'];
  }
}

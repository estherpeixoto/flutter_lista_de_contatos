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

  String getInitials() {
    var nameSplit = name.split(' ');
    var firstInitial = nameSplit[0].substring(0, 1);
    var lastInitial = nameSplit[nameSplit.length - 1].substring(0, 1);

    return '$firstInitial$lastInitial';
  }
}

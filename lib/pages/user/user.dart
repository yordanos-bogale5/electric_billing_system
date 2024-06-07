class Users {
  String name;
  double billAmount;

  Users({required this.name, this.billAmount = 0.0});
}

List<Users> users = [
  Users(name: 'Tadele Roba', billAmount: 100.0),
  Users(name: 'Amare Mamo', billAmount: 150.0),
  Users(name: 'Minalu Mesele', billAmount: 200.0),
];

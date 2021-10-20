class Contact{

  String name;
  String number;
  late DateTime time;

  Contact(this.name, this.number, int year, int month, int day, int hour, int minute, int second) {
    this.time = DateTime(year, month, day, hour, minute, second);
  }

}
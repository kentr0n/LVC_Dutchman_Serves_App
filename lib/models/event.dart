import 'package:intl/intl.dart';

class Event {
  String eventName;
  DateTime date;
  String location;
  String description;
  List<int> interests;
  bool isCommunity;
  bool isResidential;
  bool isOngoing;
  int id;
  String imagepath;
  List<int> registered;
  bool deleted;

  // constructor
  Event(String eventName, DateTime date, String location, String description,
      List<int> interests, bool isCommunity,
      {int id, String imagepath, bool isResidential, bool isOngoing}) {
    this.eventName = eventName;
    this.date = date; // can be set to null for ongoing event
    this.location = location;
    this.description = description;
    this.interests = interests;
    this.isCommunity = isCommunity;
    this.isResidential = isResidential ?? false;
    this.isOngoing = isOngoing ?? false;
    this.id = id;
    this.imagepath = imagepath;
    registered = [];
    deleted = false;
  }

  Event.blank() {
    eventName = '';
    date = null;
    location = '';
    description = '';
    interests = [];
    isCommunity = false;
    this.isResidential = false;
    this.isOngoing = false;
    registered = [];
    id = null;
    imagepath = null;
    deleted = false;
  }

  Event.individual(
      String eventName, DateTime date, String description, bool isCommunity,
      {List<int> interests, int id}) {
    this.eventName = eventName;
    this.date = date;
    this.location =
        'blank'; // not tracked, Jen doesn't need, but cannot be blank
    this.description = description;
    this.isCommunity = isCommunity;
    this.isResidential = false;
    this.isOngoing = false;
    this.interests = []; // currently not built to input interests
    this.id = id;
    imagepath = null;
    deleted = false;
  }

  // convert Event to a json Map
  Map<String, dynamic> toJson() => {
        'eventName': eventName,
        'date': date.toIso8601String(),
        'location': location,
        'description': description,
        'interests': interests,
        'isCommunity': isCommunity,
        'isResidential': isResidential,
        'isOngoing': isOngoing,
        'id': id, // may be null
        'imagepath': imagepath, // may be null
        'registered': registered, // may be empty
        'deleted': deleted,
      };

  // another constructor given a json Map
  Event.fromJson(Map<String, dynamic> json) {
    id = json['id']; // will be filled in by database
    eventName = json['eventName'];
    date = DateTime.parse(json['date']);
    location = json['location'];
    description = json['description'];
    isCommunity = json['isCommunity'];
    isResidential = json['isResidential'];
    isOngoing = json['isOngoing'];
    imagepath = json['imagepath'];
    interests = parseList(json['interests']);
    // a.removeWhere((value) => value == null);
    registered = parseList(json['registered']);
    deleted = json['deleted'];
  }

  List<int> parseList(List<dynamic> json) {
    return json != null ? List<int>.from(json) : null;
  }

  void delete() {
    this.deleted = true;
  }

  String dateString() {
    // return DateFormat.yMMMEd().format(dt);
    // final DateFormat formatter = DateFormat('MM/dd/yyyy H:mm');
    final DateFormat formatter = DateFormat('EEE. M/d, h:mm a');
    return formatter.format(date);
  }

  int dateCompare(DateTime dt) {
    if (date.year == dt.year && date.month == dt.month && date.day == dt.day)
      return 0;
    return date.compareTo(dt);
  }

  void printEvent() {
    print(eventName + ': ' + date.toString() + ' | ' + location);
    print('id: ' + id.toString());
    print(registered.toString());
    print(interests.toString());
  }

  // void changeDate(String newdate) {
  //   date = newdate;
  //   dt = DateFormat('M/d/yy').add_jm().parse(newdate);
  // }

  bool eventEquals(Event o) {
    return o is Event &&
        o.eventName == eventName &&
        o.date == date &&
        o.location == location &&
        o.description == description;
  }
}

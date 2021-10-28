import 'package:dutchmenserve/models/event.dart';

class User {
  String firstName;
  String lastName;
  String username;
  String password;
  String emailAddress;
  int id;
  List<int> interests;
  List<int> organizations;
  List<int> officer;
  String imagepath;
  List<int> events;

  User(String firstName, String lastName, String username, String password,
      {String emailAddress,
      int id,
      List<int> interests,
      List<int> organizations,
      List<int> officer,
      String imagepath,
      List<int> events,
      List<int> favorites}) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.username = username;
    this.password = password;
    this.emailAddress = emailAddress ?? (username + '@lvc.edu');
    this.id = id;
    this.interests = interests ?? [];
    this.organizations = organizations ?? [];
    this.officer = officer ?? [];
    this.imagepath = imagepath;
    this.events = events ?? [];
  }

// // Empty user which represents an unauthenticated user.
//   static const empty = User(emailAddress: '', id: '', name: null, imagepath: null);

  // convert User to a json Map
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'username': username,
        'password': password,
        'emailAddress': emailAddress,
        'id': id, // may be null
        'interests': interests ?? [],
        'organizations': organizations,
        'officer': officer,
        'imagepath': imagepath,
        'events': events ?? [],
      };

  // another constructor given a json Map
  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    username = json['username'];
    password = json['password'];
    emailAddress = json['emailAddress'];
    id = json['id'];
    interests = parseList(json['interests']);
    organizations = parseList(json['org']);
    officer = parseList(json['officer']);
    imagepath = json['imagepath'];
    events = parseList(json['events']);
  }

  List<int> parseList(List<dynamic> json) {
    return json != null ? List<int>.from(json) : null;
  }

  bool isRegistered(Event e) {
    return events.contains(e.id);
  }

  void unregister(Event e) {
    events.remove(e.id);
    e.registered.remove(id);
  }

  void register(Event e) {
    events.add(e.id);
    e.registered.add(id);
  }

  void registerAll(List<Event> ev) {
    for (var e in ev) {
      register(e);
    }
  }

  void printUser() {
    print(lastName + ', ' + firstName);
    print(username + ' | ' + password);
    print('id: ' + id.toString());
    print(interests.toString());
    print(events.toString());
  }


}

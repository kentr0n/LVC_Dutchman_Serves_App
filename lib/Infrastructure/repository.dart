import 'dart:convert';

import 'package:dutchmenserve/models/event.dart';
import 'package:dutchmenserve/models/interest.dart';
import 'package:dutchmenserve/models/organization.dart';
import 'package:dutchmenserve/models/report.dart';
import 'package:dutchmenserve/models/user.dart';

import 'package:http/http.dart' as http;

abstract class Repository {
  //INTEREST
  // organize service by interests
  Future<List<Interest>> getInterests();
  // get interest by id
  Future<Interest> getInterest(int id);
  // add interest
  Future<Interest> addInterest(
      String name, int iconDataConstant, String color, String fillColor);
  // edit interest by id
  Future<Interest> updateInterest(Interest i);
  // delete interest by id
  Future<bool> deleteInterest(int id);

  //REPORT
  // students want to see how many hours they have
  Future<List<Report>> getReports(int uid);
  // get one report
  Future<Report> getReport(int id);
  // someone wants to submit report
  Future<Report> addReport(Report r);
  // jen wants to edit or delete report
  Future<Report> updateReport(Report r);

  //EVENTS
  // Students want to see what events are available
  Future<List<Event>> getEvents();
  // get one event
  Future<Event> getEvent(int id);
  // Jen wants to see which students are registered for an event
  Future<List<User>> getRegistered(int id);
  // someone wants to add event(s)
  Future<Event> addEvent(Event e);
  // someone wants to edit or delete
  Future<Event> updateEvent(Event e);

  //ORGANIZATION
  //students want to see list of organziations
  Future<List<Organization>> getOrganizations() async {
    final List<Organization> orgs = [
      Organization(
          'Lebanon Valley Educational Partnership', 'B there or B square',
          id: 1,
          email: 'b@lvc.edu',
          officers: [1, 2, 3, 4, 5],
          members: [1, 2]),
      Organization('Colleges Against Cancer',
          'see me at Relay, this is a longer description',
          id: 2, email: 'c@lvc.edu', officers: [3], members: [3, 4, 5]),
      Organization('Alpha Phi Omega',
          'how fun fun fun we do so many fun things together with the brothers',
          id: 3,
          email: 'apo@lvc.edu',
          officers: [8],
          members: [6, 8, 9],
          imagepath: 'images/apo.jpeg'),
      Organization('AST', 'hello hi hi',
          id: 4, email: 'ast@lvc.edu', officers: [7], members: [7, 10, 12]),
      Organization('Gamma Sigma Sigma', 'xmas we organize the presents',
          id: 5, email: 'gs@lvc.edu', officers: [], members: [11, 12]),
    ];
    return orgs;
  }

  // get one org
  Future<Organization> getOrganization(int id);
  //someone can add an organization
  Future<Organization> addOrganization(Organization o);
  //to edit or delete
  Future<Organization> updateOrganization(Organization o);

  //USER
  // get all users
  Future<List<User>> getUsers();
  // get one user
  Future<User> getUser(int id);
  //register for first time, add new user
  Future<User> addUser(User u);
  //user should be able to edit info
  Future<User> updateUser(User u);
  //get current user
  Future<User> getCurrentUser();

  //REGISTRATION
  Future<bool> postRegistration(int eid, int uid);
  Future<bool> deleteRegistration(int eid, int uid);
}

class FakeRepository implements Repository {
  static final String url = 'http://10.0.2.2:5455/dutchmenserve/'; // emulator
  // static final String url = 'http://127.0.0.1:5455/dutchmenserve/';  // local
  // static final String url =
  //     'http://10.2.193.147:5455/dutchmenserve/'; // computer

  //HardCoded list of users to be replaced when server connection is done
  List<User> users = [
    User(
      'Josh',
      'Miller',
      'cc01',
      'pw',
      id: 1,
      interests: [1, 2],
    ),
    User(
      'Charles',
      'Shoemaker',
      'cs35',
      'pw',
      id: 2,
      interests: [2, 5, 6, 7],
    ),
    User(
      'Carl',
      'Catt',
      'cc02',
      'pw',
      id: 3,
      interests: [1, 6],
    ),
    User(
      'Abigail',
      'Dickinson',
      'ad632',
      'pw',
      id: 4,
      interests: [3, 4],
    ),
    User(
      'June',
      'Huh',
      'jh56',
      'pw',
      id: 5,
      interests: [7, 8],
    ),
    User(
      'Nissa',
      'Siddon',
      'ns67',
      'pw',
      id: 6,
      interests: [5, 8],
    ),
  ];

  //INTERESTS
  // get list of all interests
  @override
  Future<List<Interest>> getInterests() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(url + 'interests'));
      return parseInterests(response.body);
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  List<Interest> parseInterests(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Interest>((json) => Interest.fromJson(json)).toList();
  }

  // get one interest
  @override
  Future<Interest> getInterest(int id) async {
    var client = http.Client();
    try {
      var response =
          await client.get(Uri.parse(url + 'interests' + '/' + id.toString()));
      var parsed = jsonDecode(response.body);
      return Interest.fromJson(parsed);
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  @override
  Future<Interest> addInterest(
      String name, int iconDataConstant, String color, String fillColor) async {
    var client = http.Client();
    var response;
    try {
      response = await client.post(
        Uri.parse(url + 'interests'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(Interest(
          name,
          iconDataConstant,
          color,
          fillColor,
        )),
      );
      return Interest.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  @override
  Future<Interest> updateInterest(Interest i) async {
    var client = http.Client();
    var response;
    try {
      response = await client.put(
        Uri.parse(url + 'interests/' + i.id.toString()),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(i),
      );
      return Interest.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  @override
  Future<bool> deleteInterest(int id) async {
    var client = http.Client();
    var response;
    try {
      response = await client.delete(
          Uri.parse(url + 'interests/' + id.toString()),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
    return response.statusCode == 204;
  }

  //EVENTS
  // get list of all current service events
  @override
  Future<List<Event>> getEvents() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(url + 'events'));
      return parseEvents(response.body);
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  List<Event> parseEvents(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Event>((json) => Event.fromJson(json)).toList();
  }

  // get one event
  @override
  Future<Event> getEvent(int id) async {
    var client = http.Client();
    try {
      var response =
          await client.get(Uri.parse(url + 'event' + '/' + id.toString()));
      var parsed = jsonDecode(response.body);
      return Event.fromJson(parsed);
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  @override
  Future<Event> addEvent(Event e) async {
    if (e.id != null) {
      throw Exception('New event should not have an ID already.');
    }

    var client = http.Client();
    var response;
    try {
      response = await client.post(
        Uri.parse(url + 'events'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(e),
      );
    } catch (e) {
      print(e.errMsg());
    } finally {
      client.close();
    }
    if (response != null && response.statusCode == 201) {
      var parsed = jsonDecode(response.body);
      return Event.fromJson(parsed);
    } else {
      throw Exception('Failed to add event');
    }
  }

  @override
  Future<Event> updateEvent(Event e) async {
    var client = http.Client();
    var response;
    try {
      response = await client.put(
        Uri.parse(url + 'events/' + e.id.toString() + '/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(e),
      );
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
    if (response != null && response.statusCode == 201) {
      return Event.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update events');
    }
  }

  // REPORT
  @override
  Future<List<Report>> getReports(int uid) async {
    var client = http.Client();
    try {
      var response =
          await client.get(Uri.parse(url + 'reports/' + uid.toString()));
      return parseReports(response.body);
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
    // can try using compute(parseReports..) to move it to isolate if slow
  }

  List<Report> parseReports(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Report>((json) => Report.fromJson(json)).toList();
  }

  // get one report
  @override
  Future<Report> getReport(int id) async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse(url + 'report' + '/' + id.toString() + '/'));
      var parsed = jsonDecode(response.body);
      return Report.fromJson(parsed);
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  @override
  Future<Report> addReport(Report r) async {
    if (r.id != null) {
      throw Exception('New report should not have an ID already.');
    }

    var client = http.Client();
    var response;
    try {
      response = await client.post(
        Uri.parse(url + 'reports'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(r),
      );
    } catch (e) {
      print(e.errMsg());
    } finally {
      client.close();
    }
    if (response != null && response.statusCode == 201) {
      var parsed = jsonDecode(response.body);
      return Report.fromJson(parsed);
    } else {
      throw Exception('Failed to add report');
    }
  }

  @override
  Future<Report> updateReport(Report r) async {
    var client = http.Client();
    var response;
    try {
      response = await client.put(
        Uri.parse(url + 'report/' + r.id.toString() + '/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(r),
      );
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
    // if (response != null && response.statusCode == 201) {
    return Report.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to edit report');
    // }
  }

  // ORGANIZATION
  @override
  Future<List<Organization>> getOrganizations() async {
    var client = http.Client();
    try {
      var response = await client.get(Uri.parse(url + 'orgs'));
      return parseOrganizations(response.body);
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  List<Organization> parseOrganizations(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Organization>((json) => Organization.fromJson(json))
        .toList();
  }

  // get one org
  @override
  Future<Organization> getOrganization(int id) async {
    var client = http.Client();
    try {
      var response =
          await client.get(Uri.parse(url + 'orgs' + '/' + id.toString() + '/'));
      var parsed = jsonDecode(response.body);
      return Organization.fromJson(parsed);
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  @override
  Future<Organization> addOrganization(Organization o) async {
    if (o.id != null) {
      throw Exception('New organization should not have an ID already.');
    }

    var client = http.Client();
    var response;
    try {
      response = await client.post(
        Uri.parse(url + 'orgs'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(o),
      );
    } catch (e) {
      print(e.errMsg());
    } finally {
      client.close();
    }
    if (response != null && response.statusCode == 201) {
      return Organization.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to submit report');
    }
  }

  @override
  Future<Organization> updateOrganization(Organization o) async {
    var client = http.Client();
    var response;
    try {
      response = await client.put(
        Uri.parse(url + 'orgs/' + o.id.toString() + '/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(o),
      );
    } catch (e) {
      print(e.errMsg());
    } finally {
      client.close();
    }
    if (response != null && response.statusCode == 201) {
      return Organization.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update organization');
    }
  }

  // USER
  //TODO replace hardcoded users with commeneted code.
  @override
  Future<List<User>> getUsers() async {
    // var client = http.Client();
    // try {
    //   var response = await client.get(Uri.parse(url + 'users'));
    //   return parseUsers(response.body);
    // } catch (e) {
    //   rethrow;
    // } finally {
    //   client.close();
    // }
    return users;
  }

  List<User> parseUsers(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  // get one user
  @override
  Future<User> getUser(int id) async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse(url + 'users' + '/' + id.toString() + '/'));
      var parsed = jsonDecode(response.body);
      return User.fromJson(parsed);
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }

  @override
  Future<User> addUser(User u) async {
    var client = http.Client();
    var response;
    try {
      response = await client.post(
        Uri.parse(url + 'users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(u),
      );
    } catch (e) {
      print(e.errMsg());
    } finally {
      client.close();
    }
    if (response != null && response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add user');
    }
  }

  @override
  Future<User> updateUser(User u) async {
    var client = http.Client();
    var response;
    try {
      response = await client.put(
        Uri.parse(url + 'users/' + u.id.toString() + '/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(u),
      );
    } catch (e) {
      print(e.errMsg());
    } finally {
      client.close();
    }
    if (response != null && response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to edit report');
    }
  }

  // REGISTRATION
  @override
  Future<List<User>> getRegistered(int id) async {
    var client = http.Client();
    var response;
    try {
      response = await client.get(
          Uri.parse(url + 'event/' + id.toString() + '/register'),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print(e.errMsg());
    } finally {
      client.close();
    }
    return parseUsers(response.body);
  }

  @override
  Future<bool> postRegistration(int eid, int uid) async {
    var client = http.Client();
    var response;
    try {
      response = await client.post(
        Uri.parse(
            url + 'event/' + eid.toString() + '/register/' + uid.toString()),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
    if (response != null && response.statusCode == 201) {
      return checkRegResponse(response.body, eid, uid);
    } else {
      throw Exception('Failed to post registration for event ' +
          eid.toString() +
          'for user ' +
          uid.toString());
    }
  }

  bool checkRegResponse(String responseBody, int eid, int uid) {
    final parsed = jsonDecode(responseBody);
    int userID = parsed['user'];
    int eventID = parsed['event'];
    return eid == eventID && uid == userID;
  }

  @override
  Future<bool> deleteRegistration(int eid, int uid) async {
    var client = http.Client();
    var response;
    try {
      response = await client.delete(
          Uri.parse(
              url + 'event/' + eid.toString() + '/register/' + uid.toString()),
          headers: {'Content-Type': 'application/json'});
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
    return response.statusCode == 204;
  }

  //TODO make not hardcarded and so it links to server/local repo
  Future<User> getCurrentUser() async {
    return users[0];
  }

  @override
  Future<User> addInterestAssociation(User u, int i) async {
    u.interests.add(i);
    this.updateUser(u);
  }

  @override
  Future<User> deleteInterestAssociation(User u, int i) async {
    u.interests.remove(i);
    this.updateUser(u);
  }

  @override
  Future<List<int>> getUserInterests(int id) async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse(url + 'users' + '/' + id.toString() + '/'));
      var parsed = jsonDecode(response.body);
      return User.fromJson(parsed).interests;
    } catch (e) {
      rethrow;
    } finally {
      client.close();
    }
  }
}

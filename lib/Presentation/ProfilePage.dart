import 'dart:ui';

import 'package:dutchmenserve/Infrastructure/cubit/users_cubit.dart';
import 'package:dutchmenserve/models/Constants.dart';
import 'package:dutchmenserve/models/interest.dart';
import 'package:dutchmenserve/models/organization.dart';
import 'package:dutchmenserve/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';

import 'interestEdit.dart';
import 'interestSelection.dart';
import 'organizationInfo.dart';

/*
This class builds the profile page for the user,
shows image (optional), name, email, interests, organizations followed.

Other users can see this profile.

TODO: does this have to be stateful??
*/

class ProfilePage extends StatelessWidget {
  ProfilePage({Key key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();
  final colors = Constants().colors;
  final interests = Constants().interests;
  final icons = Constants().icons;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 30, right: 30, left: 30),
          child: Column(
            children: [
              Center(child: Icon(Icons.account_circle, size: 120)),
              BlocBuilder<UsersCubit, UsersState>(builder: (context, state) {
                if (state is LoadedState) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      state.curUser.firstName + ' ' + state.curUser.lastName,
                      // user.firstName + ' ' + user.lastName,
                      style: TextStyle(fontSize: 24),
                    ),
                  );
                } else {
                  //TODO needs loading state and return to home state if no user is found
                  return Container();
                }
              }),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    BlocBuilder<UsersCubit, UsersState>(
                        builder: (context, state) {
                      if (state is LoadedState) {
                        return ListTile(
                          leading: Icon(Icons.email),
                          title: Text(
                            state.curUser.emailAddress,
                            // style: TextStyle(fontSize: 16),
                          ),
                        );
                      } else {
                        //TODO needs loading state and return to home state if no user is found
                        return Container();
                      }
                    }),
                    Divider(height: 8),
                    InkWell(
                      child: ListTile(
                        title: Text('Interests:'),
                        leading: Icon(Icons.favorite),
                        trailing: Icon(Icons.edit),
                        subtitle: Container(
                            margin: EdgeInsets.only(top: 4),
                            child: SizedBox(
                                height: 36,
                                child: BlocBuilder<UsersCubit, UsersState>(
                                    builder: (context, state) {
                                  if (state is LoadedState) {
                                    List<Widget> widgets = List.generate(
                                      state.curUser.interests.length,
                                      (index) => CircleAvatar(
                                        backgroundColor: colors[
                                            state.curUser.interests[index]],
                                        child: IconButton(
                                          tooltip: interests[state
                                                  .curUser.interests[index]]
                                              .interest,
                                          padding: EdgeInsets.zero,
                                          icon: Icon(
                                            icons[
                                                state.curUser.interests[index]],
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                    return Scrollbar(
                                        // isAlwaysShown: true,
                                        thickness: 3,
                                        radius: Radius.circular(90),
                                        controller: _scrollController,
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 8),
                                          child: ListView(
                                              shrinkWrap: true,
                                              controller: _scrollController,
                                              scrollDirection: Axis.horizontal,
                                              children: widgets),
                                        ));
                                  } else {
                                    //TODO needs loading state and return to home state if no user is found
                                    return Text(state.toString());
                                  }
                                }))),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contextInterests) => BlocProvider.value(
                                    value: context.read<UsersCubit>(),
                                    //TODO change selectinterests so that it is passed nothing and gets user from context
                                    child: InterestEdit(
                                        user: User(
                                      'Josh',
                                      'Miller',
                                      'cc01',
                                      'pw',
                                      id: 1,
                                      interests: [1, 2],
                                    )),
                                  )),
                        );
                      },
                    ),
                    Divider(
                      height: 0,
                    ),
                    ExpansionTile(
                      leading: Icon(Icons.group_work),
                      title: Text('Organizations'),
                      children: [
                        //TODO iterate through a list to build the expanded list
                      ],
                    ),
                  ],
                ),
              ),
              Divider(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  ListView buildOrgList(BuildContext context, List<Organization> orgs) {
    return ListView.separated(
      padding: EdgeInsets.all(20.0),
      itemBuilder: (BuildContext context, int index) {
        return createOrgCard(context, orgs[index]);
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemCount: orgs.length,
    );
  }

  Widget createOrgCard(BuildContext context, Organization o1) {
    return Card(
      elevation: 5,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrgInfo(
                org: o1,
              ),
            ),
          );
        },
        leading: o1.imagepath == null
            ? CircleAvatar(
                backgroundColor: Colors.white54,
                radius: 25.0,
                child: Icon(
                  Icons.group_work,
                  size: 40,
                  color: Color(0xffDDDDDE),
                ))
            : CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(o1.imagepath),
              ),
        title: Container(
          margin: EdgeInsets.only(top: 15, bottom: 2),
          child: Text(
            o1.orgName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              o1.email,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                o1.description,
                style: TextStyle(fontSize: 14),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // TODO Possibly implement the unfollow button
            // ButtonBar(
            //   alignment: MainAxisAlignment.end,
            //   children: [
            //     user.organizations.contains(o1.id)
            //         ? FlatButton(
            //             child: Text('Unfollow'),
            //             onPressed: () {
            //               setState(() {
            //                 user.organizations.remove(o1.id);
            //                 o1.members.remove(user.id);
            //               });
            //             },
            //           )
            //         : FlatButton(
            //             child: Text('Follow'),
            //             onPressed: () {
            //               setState(() {
            //                 user.organizations.add(o1.id);
            //                 o1.members.add(user.id);
            //               });
            //             },
            //           ),
            //     FlatButton(
            //       child: Text('Learn More'),
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => OrgInfo(
            //               org: o1,
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

// void choiceAction(String choice, BuildContext context) {
//   setState(() {
//     if (choice == Constants.LogOut) {
//       SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//         statusBarColor: Color(0xff002A4E),
//         statusBarBrightness: Brightness.dark,
//         statusBarIconBrightness: Brightness.dark,
//         systemNavigationBarColor: Color(0xff002A4E),
//         systemNavigationBarIconBrightness: Brightness.dark,
//       ));
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => InitialLoginHome()),
//         (Route<dynamic> route) => false,
//       );
//     }
//   });
// }

// ListView buildInterestList(BuildContext context, List<bool> interests,
//     List<String> interestsNames, List<Icon> icons) {
//   return ListView.separated(
//     padding: const EdgeInsets.all(20.0),
//     itemBuilder: (BuildContext context, int index) {
//       if (interests[index]) {
//         return createLists(context, interestsNames[index], icons[index]);
//       }
//     },
//     separatorBuilder: (BuildContext context, int index) => const Divider(),
//     itemCount: interests.length,
//   );

// ExpansionTile(
//   title: Center(
//       child: Text(
//     "Interests",
//     style: TextStyle(fontSize: 18),
//   )),
//   children: [
//     ListTile(
//       leading: Icon(Icons.gavel),
//       title: Text("Advocacy & Human Rights"),
//     ),
//     ListTile(
//       leading: Icon(Icons.pets),
//       title: Text("Animals"),
//     ),
//     ListTile(
//       leading: Icon(Icons.color_lens),
//       title: Text("Arts & Culture"),
//     ),
//     ListTile(
//       leading: Icon(Icons.child_care),
//       title: Text("Children & Youth"),
//     ),
//     ListTile(
//       leading: Icon(Icons.group),
//       title: Text("Community"),
//     ),
//     ListTile(
//       leading: Icon(Icons.computer),
//       title: Text("Technology"),
//     ),
//     ListTile(
//       leading: Icon(Icons.school),
//       title: Text("Education & Literacy"),
//     ),
//     ListTile(
//       leading: Icon(Icons.face),
//       title: Text("Seniors"),
//     ),
//     ListTile(
//       leading: Icon(Icons.more_horiz),
//       title: Text("Other"),
//     )
//   ],
// );

// //List<Icon> icons in parameter?
// ListTile createLists(BuildContext context, String interestsOrNo, Icon img) {
//   //final orgCube = context.bloc<OrganizationCubit>();
//   //orgCube.getOrgs();
//   return ListTile(
//     //padding: EdgeInsets.all(25),
//     leading: img,
//     title: Text(interestsOrNo),
//   );
// }

import 'package:dutchmenserve/Infrastructure/cubit/organization_cubit.dart';
import 'package:dutchmenserve/models/organization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
This class builds the OrganizationInfo page with more detailed 
view of a service organization.
Show contact info and officers.

TODO: allow officers/admin users to edit an organization's info
*/

class OrgInfo extends StatelessWidget {
  final Organization org;

  OrgInfo({Key key, @required this.org}) : super(key: key);

  Widget createOfficerCard(BuildContext context, int oid) {
    return ListTile(
      dense: true,
      leading:
          Icon(Icons.supervisor_account, size: 40, color: Colors.transparent),
      title: Text(
        oid.toString(),
        style: TextStyle(fontSize: 18),
      ),
      subtitle: Text(
        'email@lvc.edu',
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget showOfficers(BuildContext context) {
    return Column(
      children: [
        Divider(indent: 100, endIndent: 100, color: Colors.grey),
        Text("O F F I C E R S"),
        Divider(indent: 100, endIndent: 100, color: Colors.grey),
        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 0),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: createOfficerCard(context, org.officers[index]),
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            height: 0,
            color: Colors.transparent,
          ),
          itemCount: org.officers.length,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrganizationCubit>(
      create: (context) => OrganizationCubit(),
      //put bloc builder
      child: Scaffold(
        appBar: AppBar(
          title: Text(org.orgName),
          actions: [
            FlatButton(
              child: Text(
                'EDIT',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                //TODO: edit
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SplashPage()));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                child: Center(
                  child: org.imagepath == null
                      ? CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 65.0,
                          child: Icon(
                            Icons.group_work,
                            size: 130,
                            color: Color(0xffDDDDDE),
                          ))
                      : CircleAvatar(
                          radius: 65.0,
                          backgroundImage: AssetImage(org.imagepath)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  org.description,
                  textAlign: TextAlign.center,
                  // style: TextStyle(fontSize: 18.0),
                ),
              ),
              Card(
                margin: EdgeInsets.only(left: 40, right: 40, bottom: 20),
                child: ListTile(
                  leading: Icon(Icons.email, color: Color(0xff206090)),
                  title: Text(
                    org.email,
                    // style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              org.officers.isEmpty ? Container() : showOfficers(context),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class OrganizationInfo extends StatelessWidget {
  final Organization orgToDisplay;

  OrganizationInfo({Key key, @required this.orgToDisplay}) : super(key: key);

  @override
  Widget build(BuildContext ctxt) {
    return BlocProvider<OrganizationCubit>(
      create: (context) => OrganizationCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 75,
                ),
                CircleAvatar(
                  radius: 65.0,
                  backgroundImage: AssetImage('images/apo.jpeg'),
                ),
                Text(
                  orgToDisplay.orgName,
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: Colors.black,
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  orgToDisplay.description,
                  style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      color: Colors.black54,
                      fontSize: 20.0,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    height: 20.0,
                    width: 120.0,
                    child: Divider(color: Colors.black54)),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: ListTile(
                    leading: Icon(Icons.email, color: Colors.black54),
                    title: Text(orgToDisplay.email,
                        style: TextStyle(
                          color: Colors.black54,
                          fontFamily: 'SourceSansPro',
                          fontSize: 20,
                        )),
                  ),
                ),
                // Card(
                //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                //   child: ListTile(
                //     leading:
                //         Icon(Icons.supervisor_account, color: Colors.black54),
                //     title: Text('Officer Name',
                //         style: TextStyle(
                //           color: Colors.black54,
                //           fontFamily: 'SourceSansPro',
                //           fontSize: 20,
                //         )),
                //   ),
                // ),

                // ListView.separated(
                //   physics: NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   padding: const EdgeInsets.all(20.0),
                //   itemBuilder: (BuildContext context, int index) {
                //     return Container(
                //       child:
                //           createOfficers(context, orgToDisplay.officers[index]),
                //     );
                //   },
                //   separatorBuilder: (BuildContext context, int index) =>
                //       const Divider(),
                //   itemCount: orgToDisplay.officers.length,
                // ),
                SizedBox(
                    height: 20.0,
                    width: 120.0,
                    child: Divider(color: Colors.black54)),
                Container(
                  child: Text("M E M B E R S"),
                ),
                SizedBox(
                    height: 20.0,
                    width: 120.0,
                    child: Divider(color: Colors.black54)),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      elevation: .75,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: ListTile(
                        leading:
                            Icon(Icons.account_circle, color: Colors.black54),
                        title: Text('Steve Rogers',
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'SourceSansPro',
                              fontSize: 20,
                            )),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      elevation: .75,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: ListTile(
                        leading:
                            Icon(Icons.account_circle, color: Colors.black54),
                        title: Text('Tony Stark',
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'SourceSansPro',
                              fontSize: 20,
                            )),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      elevation: .75,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      child: ListTile(
                        leading:
                            Icon(Icons.account_circle, color: Colors.black54),
                        title: Text('Peter Parker',
                            style: TextStyle(
                              color: Colors.black54,
                              fontFamily: 'SourceSansPro',
                              fontSize: 20,
                            )),
                      )),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: () {},
                child: Text("Edit"),
                heroTag: null,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: FloatingActionButton(
            //     onPressed: () {
            //       removeOrganization(ctxt, orgToDisplay);
            //       Navigator.pop(ctxt);
            //     },
            //     child: Text("Delete"),
            //     heroTag: null,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // void removeOrganization(BuildContext context, Organization org) {
  //   //final orgCubit;
  //   final orgCubit = context.bloc<OrganizationCubit>();
  //   orgCubit.removeOrg(org);
  // }
}

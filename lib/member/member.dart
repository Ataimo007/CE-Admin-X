import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ce_admin/app.dart';

class MemberPage extends StatefulWidget {
  MemberPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MemberPageState createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  Church church;
  List<Completer<Member>> members = <Completer<Member>>[];
  static const _pageSize = 20;
  static const _firstPage = 20;

  void getWidget() {
    Firestore.instance
        .document("/church/3Jb7697uN5arfXILe5S8")
        .snapshots(includeMetadataChanges: true)
        .listen((data) {
      if (church == null)
        setState(() {
          print("church is ${data.data}");
          church = Church.fromDocument(data.data);
        });
    });
  }

  @override
  void initState() {
    super.initState();
    getWidget();
  }

  @override
  Widget build(BuildContext context) {
    print("App name ${Firestore.instance.app.name}");
//    getWidget();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 7),
        child: Center(
          child: church == null
              ? LinearProgressIndicator()
              : getMembersList(church),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getList(int index) {
    if (index >= members.length) {
      int increase = min(church.membershipStrength - index,
          members.isEmpty ? _firstPage : _pageSize);
      Firestore.instance
          .collection("/church/3Jb7697uN5arfXILe5S8/members")
          .startAt([members.length])
          .orderBy('first_name')
          .limit(increase)
          .getDocuments()
          .then((value) {
            value.documents.asMap().forEach((pos, value) {
              print("member is ${value.data}");
              members[index + pos].complete(Member.fromDocument(value.data));
            });
          });
      members.addAll(List.generate(increase, (index) => Completer<Member>()));
    }

    return FutureBuilder<Member>(
      future: members.elementAt(index).future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData)
          return getMemberWidget(snapshot.data);
        else
          return getDummy();
      },
    );
  }

  Widget getMembersList(Church church) {
    print("This are the snapshots");
    print(church);
    return ListView.builder(
      itemBuilder: (context, index) {
        return getList(index);
      },
      itemCount: church.membershipStrength,
    );
  }

  Widget getMemberWidget(Member member) {
    print("The Member is $member");
    return Card(
      margin: EdgeInsets.only(left: 2, right: 2, top: 1.5, bottom: 1.5),
      elevation: 0.3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              Assets.getAvatar(),
              height: 40,
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${member.firstName}${" ${member.surname}"}${" ${member.otherNames}"}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  member.phone != null
                      ? getInfo(member.phone, Icons.phone, Colors.green)
                      : Text(
                          "No Phone Number",
                          style: TextStyle(fontSize: 12),
                        ),
                  member.email != null
                      ? getInfo(member.email, Icons.email, Colors.red)
                      : Text(
                          "No Email Address",
                          style: TextStyle(fontSize: 12),
                        ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getDummy() {
    return Card(
      margin: EdgeInsets.only(left: 2, right: 2, top: 1.5, bottom: 1.5),
      elevation: 0.3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            SvgPicture.asset(
              Assets.getAvatar(),
              height: 40,
              width: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
            )
          ],
        ),
      ),
    );
  }

  Widget getInfo(var detail, var icon, var color) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        SizedBox(
          width: 7,
        ),
        Text(
          detail,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class Member {
  String firstName;
  String surname;
  String otherNames;
  String dob;
  String phone;
  String email;
  String address;

  Member.fromDocument(Map<String, dynamic> doc) {
    firstName = doc['first_name'];
    surname = doc['surname'];
    otherNames = doc['other_names'];
    dob = doc['doc'];
    phone = doc['phone'];
    email = doc['email'];
    address = doc['address'];
  }

  Map<String, dynamic> toMap() {
    var doc = <String, dynamic>{};
    return doc;
  }
}

class Church {
  int membershipStrength;
  String name;
  int update_at;
  int created_at;

  Church.fromDocument(Map<String, dynamic> doc) {
    membershipStrength = doc['membership_strength'];
    name = doc['name'];
    update_at = doc['update_at'];
    created_at = doc['created_at'];
  }

  Map<String, dynamic> toMap() {
    var doc = <String, dynamic>{};
    return doc;
  }
}

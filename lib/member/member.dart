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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 7),
        child: Center(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return getMemberWidget(index);
            },
            itemCount: 4,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getMemberWidget(int index) {
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
                    "Ataimo Edem",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  getInfo("08160594893", Icons.phone, Colors.green),
                  getInfo("flexwitlex@yahoo.com", Icons.email, Colors.red),
                ],
              ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'DetaiPage.dart';

class ListPage4 extends StatefulWidget {
  @override
  _ListPage4State createState() => _ListPage4State();
}

TextEditingController editingController;

class _ListPage4State extends State<ListPage4> {
  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                  post: post,
                )));
  }

  Future getPost1() async {
    var firestore = Firestore.instance;
    // else{
    //if(widget.currentIndex ==2 && widget.icounter==0) {
    QuerySnapshot qn =
        await firestore.collection("Web Based Simple").getDocuments();
    return qn.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Mobile Hard"),),
      // ignore: missing_return

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.3, 0.6, 0.9],
            colors: [
              Colors.deepOrange[300],
              Colors.deepOrange[200],
              Colors.deepPurple[200],
              Colors.deepPurple[300],
            ],
          ),
        ),
        child: FutureBuilder(
            future: getPost1(),
            // ignore: missing_return
            builder: (_, snapshot) {
              //proitem = snapshot.data["Problem Statement"];
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  //height: MediaQuery.of(context).size.height,
                  alignment: Alignment.topCenter,
                  child: Image.asset("assets/LOAD.gif"),
                );
              } else {
                return ListView.builder(
                    padding: const EdgeInsets.only(
                        bottom: kFloatingActionButtonMargin + 200),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 20,
                        margin: EdgeInsets.all(10.8),
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            /*"Problem Statement:- " +"\n"+*/
                            "$index. "+snapshot.data[index].data["Problem Statement"],
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Required Skills:- " +
                                    snapshot.data[index].data["Required Skill"],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38),
                              ),
                              RaisedButton.icon(
                                  onPressed: () =>
                                      navigateToDetail(snapshot.data[index]),
                                  label: Text("SeeMore"),
                                  icon: Icon(Icons.arrow_right))
                            ],
                          ),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}

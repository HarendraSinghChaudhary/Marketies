// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';


class TabClass extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: Icon(Icons.person_outline),
            title: Text('DASHBOARD',style: TextStyle(fontSize: 16.0),),
            bottom: PreferredSize(
                child: TabBar(
                    isScrollable: true,
                    unselectedLabelColor: Colors.white.withOpacity(0.3),
                    indicatorColor: Colors.white,
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      Tab(
                        child: Text('Tab 1'),
                      ),
                      Tab(
                        child: Text('Investment'),
                      ),
                      Tab(
                        child: Text('Your Earning'),
                      ),
                      Tab(
                        child: Text('Current Balance'),
                      ),
                      Tab(
                        child: Text('Tab 5'),
                      ),
                      Tab(
                        child: Text('Tab 6'),
                      )
                    ]),
                preferredSize: Size.fromHeight(30.0)),
            // ignore: prefer_const_literals_to_create_immutables
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(Icons.add_alert),
              ),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              Container(
                child: Center(
                  child: Text('Tab 1'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 2'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 3'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 4'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 5'),
                ),
              ),
              Container(
                child: Center(
                  child: Text('Tab 6'),
                ),
              ),
            ],
          )
          ),
    );
  }
  }

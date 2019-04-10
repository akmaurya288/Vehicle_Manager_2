import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: NestedScrollView(headerSliverBuilder:(BuildContext context,bool innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              titleSpacing: 10,
              forceElevated: innerBoxIsScrolled,
              title: Text("Menu"),
              elevation: 4.0,
              backgroundColor: Colors.red,
            )
          ];
        },
            body: Container(
                color: Colors.red[50],
                child:Padding( padding: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  ExpansionTile(
                    leading: Icon(Icons.add,size: 30,),
                    title: Text("Add", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Driver',
                      ),
                      leading: Icon(null),
                      onTap: ()=> {},
                    ),
                    ListTile(
                      title: Text(
                        'Car',
                      ),
                      leading: Icon(null),
                      onTap: ()=> {},
                    ),
                    ListTile(
                      title: Text(
                        'Income',
                      ),
                      leading: Icon(null),
                      onTap: ()=>{},
                    ),
                  ],),
                  
                  MaterialButton(onPressed: ()=> {},
                    elevation: 5,
                    height: 60,
                    minWidth: MediaQuery.of(context).size.width,
                    child: Row(
                        children: <Widget>[
                          Icon(Icons.directions_car,size: 30,),
                          Text("  Assign Vahicle",style: TextStyle(fontSize: 15),)
                        ]
                    ),
                  ),

                  MaterialButton(onPressed: ()=> {},
                    elevation: 5,
                    height: 60,
                    minWidth: MediaQuery.of(context).size.width,
                    child: Row(
                        children: <Widget>[
                          Icon(Icons.backup,size: 30,),
                          Text("  Backup",style: TextStyle(fontSize: 15),)
                        ]
                    ),
                  ),

                  MaterialButton(onPressed: ()=> {},
                    elevation: 5,
                    height: 60,
                    minWidth: MediaQuery.of(context).size.width,
                    child: Row(
                        children: <Widget>[
                          Icon(Icons.settings,size: 30,),
                          Text("  Settings",style: TextStyle(fontSize: 15),)
                        ]
                    ),
                  ),

                ],

              ),
            )),
        )
      ),
    );
  }
}

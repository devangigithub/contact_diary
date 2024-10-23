import 'package:flutter/material.dart';

import '../model/setting_list.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
       CustomScrollView(
        slivers: [

          SliverAppBar(
             backgroundColor: Colors.white,
            expandedHeight: 150.0,
            floating: false,
            pinned: true,
            stretch: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Settings'),

            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                leading: Icon(getIcon(index),color: Colors.black87,),
                title: Text(settingsOptions[index],style: TextStyle(
                  color: Colors.black87
                ),),
                onTap: () {},
              ),
              childCount: settingsOptions.length,
            ),
          ),
        ],
       );

  }

}

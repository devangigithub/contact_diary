import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/setting_list.dart';

class SettingsPageIso extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Settings'),
            stretch: false,
            backgroundColor: CupertinoColors.white,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => CupertinoListTile(
                leading: Icon(getIcon(index),color: CupertinoColors.black,),
                title: Text(settingsOptions[index],style: TextStyle(
                  color: CupertinoColors.black,
                ),),
                onTap: () {},
              ),
              childCount: settingsOptions.length,
            ),
          ),
        ],
      ),
    );
  }
}



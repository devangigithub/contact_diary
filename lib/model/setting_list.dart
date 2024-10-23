
  import 'package:flutter/material.dart';



final List<String> settingsOptions = [
    'Caller ID and spam',
    'Accessibility',
    'Assisted dialing',
    'Blocked numbers',
    'Calling accounts',
    'Call recording',
    'Display options',
    'Quick responses',
    'Sounds and vibration',
    'Voicemail',
    'Contact ringtones',
    'Caller ID announcement',
    'Flip to silence',
  ];

  IconData getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.report_problem;
      case 1:
        return Icons.accessibility;
      case 2:
        return Icons.dialpad;
      case 3:
        return Icons.block;
      case 4:
        return Icons.call;
      case 5:
        return Icons.mic;
      case 6:
        return Icons.display_settings;
      case 7:
        return Icons.message;
      case 8:
        return Icons.volume_up;
      case 9:
        return Icons.voicemail;
      case 10:
        return Icons.music_note;
      case 11:
        return Icons.campaign;
      case 12:
        return Icons.flip;
      default:
        return Icons.settings;
    }
  }
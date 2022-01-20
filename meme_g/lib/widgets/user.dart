import 'package:flutter/material.dart';
import 'package:meme_g/screens/personal_info.dart';

class UserF {
  dynamic uname, userId, ucountry, birthdate;
  dynamic _useremail = '', _userpassword = '';
  String? cuid;
  UserF.uid(this.cuid);
  UserF.emailandpass(this._useremail, this._userpassword);

  dynamic get getUid {
    return cuid;
  }

  UserF.accountDetails(this.uname, this.userId, this.ucountry, this.birthdate);
}

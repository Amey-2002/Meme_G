
import 'package:flutter/material.dart';
import 'package:meme_g/screens/personal_info.dart';


 class UserF extends  StatelessWidget {
   
   dynamic uname, userId, ucountry, birthdate; 
  dynamic _useremail='', _userpassword='';
 // personal_info display = new personal_info();
  //display.setuid(cuid);
  String? senduid()
  {
    return cuid;
  }//
  String? cuid;
  UserF.senduid();
  UserF.uid(this.cuid);
  UserF.emailandpass(this._useremail,this._userpassword);
  UserF.accountDetails(this.uname,this.userId,this.ucountry,this.birthdate);

   @override
   Widget build(BuildContext context) {
     return Container(
      
     );
      
   }
 }
 
  
 
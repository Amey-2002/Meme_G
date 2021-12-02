class UserF {
  dynamic _useremail='', _userpassword='';
  dynamic uid;
  UserF.uid(this.uid);
  UserF.emailandpass(this._useremail,this._userpassword);

  dynamic get getUid{
    return uid;
  }
}
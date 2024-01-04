class Word {
  late String primarywrd;
  late String secondwrd;
  late int wrdlvl;

  Word(this.primarywrd, this.secondwrd);
  Word.withlvl(this.primarywrd,this.secondwrd,this.wrdlvl);

  @override
  String toString() {
    return 'primary:$primarywrd, secondary:$secondwrd, level:$wrdlvl';
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['primarywrd'] = primarywrd;
    map['secondwrd'] = secondwrd;
    map['wrdlvl'] = wrdlvl;
    return map;
  }

  Word.fromMap(Map<dynamic, dynamic> map) {
    primarywrd = map['primarywrd'];
    secondwrd = map['secondwrd'];
    wrdlvl = map['wrdlvl'];
  }
}
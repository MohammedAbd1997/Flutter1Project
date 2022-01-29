class Category {

  int Catagoryid ;
  int numoftask ;
  String titlecatagory ;
  String Icon;
  String Color;


  Category({this.Catagoryid, this.numoftask = 0, this.titlecatagory,
    this.Icon,this.Color});

  Category.fromMap(Map map) {
    this.Catagoryid = map['Catagoryid'];
    this.numoftask = map['numoftask'];
    this.titlecatagory = map['titlecatagory'];
    this.Icon = map['Icon'];
    this.Color = map['Color'];
  }

  toMap() {
    return {'titlecatagory': this.titlecatagory, 'numoftask': this.numoftask,'Icon': this.Icon,'Color': this.Color};
  }

}
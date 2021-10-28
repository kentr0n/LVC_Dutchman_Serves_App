import 'dart:ui';

class Interest {
  int id;
  String interest;
  int iconDataConstant;
  String color;
  String fillColor;

  Interest(String interest, int iconConst, String color, String fillColor,
      {int id}) {
    this.interest = interest;
    this.id = id;
    iconDataConstant = iconConst;
    this.color = color;
    this.fillColor = fillColor;
  }

  Map<String, dynamic> toJson() => {
        'interest': interest,
        'id': id,
        'iconDataConstant': iconDataConstant,
        'color': color,
        'fillColor': fillColor,
      };

  Interest.fromJson(Map<String, dynamic> json) {
    id = json['id']; // will be filled in by database
    interest = json['interest'];
    iconDataConstant = json['iconDataConstant'];
    color = json['color'];
    fillColor = json['fillColor'];
  }

  void printInterest() {
    print(id.toString() + ': ' + interest + ', ' + iconDataConstant.toString());
  }

  Color getColor() {
    return color.toColor();
  }

  Color getFillColor() {
    return fillColor.toColor();
  }
}

extension ColorExtension on String {
  toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
} // '#f9f9f9'.toColor(), //f9f9f9 //55B9F4

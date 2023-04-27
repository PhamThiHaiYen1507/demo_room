class Data {
  int floor;
  num distanceRows;
  num distanceSeat;
  num widthSeat;
  List<DataBlock> listBlock;
  Data(
      {required this.floor,
      required this.distanceRows,
      required this.distanceSeat,
      required this.widthSeat,
      required this.listBlock});
}

class DataBlock {
  int x;
  int y;
  num radius;
  int lenghtRow;
  int lenghtSeatRow;
  List<List<DataSeat>> listSeat;

  DataBlock(
      {required this.x,
      required this.y,
      required this.radius,
      required this.lenghtRow,
      required this.lenghtSeatRow,
      required this.listSeat});
}

class DataSeat {
  int id;
  int column;
  int row;
  String type;
  DataSeat(
      {required this.id,
      required this.column,
      required this.row,
      required this.type});
}

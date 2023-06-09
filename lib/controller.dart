import 'dart:math';
import 'dart:ui';

import 'package:demo_room/main.dart';
import 'package:demo_room/model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

enum type { empty, enable, disable, selecting }

class Controller extends GetxController {
  late final Rx<List<Data>> listData;
  late final RxInt countSeatSelected;
  late final Rx<Map<String, Image>> mapImage;

  @override
  void onInit() {
    listData = Rx<List<Data>>([
      Data(
          floor: 1,
          distanceRows: 15,
          distanceSeat: 0,
          widthSeat: 30,
          listBlock: [
            DataBlock(
                x: 20,
                y: 100,
                radius: -pi / 6,
                lenghtRow: 1,
                lenghtSeatRow: 3,
                listSeat: [
                  [
                    DataSeat(
                        id: 1,
                        column: 0,
                        row: 0,
                        type: type.disable.toString()),
                    DataSeat(
                        id: 2, column: 0, row: 1, type: type.enable.toString()),
                    DataSeat(
                        id: 17,
                        column: 0,
                        row: 2,
                        type: type.enable.toString()),
                  ],
                ]),
            DataBlock(
                x: 140,
                y: 0,
                radius: 0,
                lenghtRow: 3,
                lenghtSeatRow: 4,
                listSeat: [
                  [
                    DataSeat(
                        id: 3, column: 0, row: 0, type: type.enable.toString()),
                    DataSeat(
                        id: 4, column: 0, row: 1, type: type.empty.toString()),
                    DataSeat(
                        id: 5, column: 0, row: 2, type: type.enable.toString()),
                    DataSeat(
                        id: 6, column: 0, row: 3, type: type.enable.toString())
                  ],
                  [
                    DataSeat(
                        id: 7, column: 1, row: 0, type: type.enable.toString()),
                    DataSeat(
                        id: 8, column: 1, row: 1, type: type.enable.toString()),
                    DataSeat(
                        id: 9, column: 1, row: 2, type: type.enable.toString()),
                    DataSeat(
                        id: 10,
                        column: 1,
                        row: 3,
                        type: type.enable.toString()),
                  ],
                  [
                    DataSeat(
                        id: 11,
                        column: 2,
                        row: 0,
                        type: type.enable.toString()),
                    DataSeat(
                        id: 12,
                        column: 2,
                        row: 1,
                        type: type.enable.toString()),
                    DataSeat(
                        id: 13,
                        column: 2,
                        row: 2,
                        type: type.enable.toString()),
                    DataSeat(
                        id: 14,
                        column: 2,
                        row: 3,
                        type: type.enable.toString()),
                  ]
                ]),
            DataBlock(
                x: 295,
                y: 100,
                radius: pi / 6,
                lenghtRow: 1,
                lenghtSeatRow: 3,
                listSeat: [
                  [
                    DataSeat(
                        id: 15,
                        column: 0,
                        row: 0,
                        type: type.disable.toString()),
                    DataSeat(
                        id: 16,
                        column: 0,
                        row: 1,
                        type: type.disable.toString()),
                    DataSeat(
                        id: 18,
                        column: 0,
                        row: 2,
                        type: type.disable.toString())
                  ]
                ]),
          ])
    ]);
    countSeatSelected = RxInt(0);
    mapImage = Rx({});
    super.onInit();
  }

  @override
  void onReady() {
    loadImage();
    super.onReady();
  }

  Future<void> loadImage() async {
    String homeIconString =
        '<svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" clip-rule="evenodd" d="M19.4931 0H10.3813C10.1423 0 9.90993 0.0341825 9.69417 0.102547C9.47509 0.168471 9.27592 0.268577 9.10995 0.388215L9.10331 0.393098C8.94066 0.515179 8.80788 0.659233 8.71826 0.817938C8.63195 0.971759 8.57884 1.14267 8.57884 1.32335V4.25572C8.57884 4.61707 8.78133 4.94913 9.10663 5.18841L9.11327 5.19574C9.43525 5.43257 9.8867 5.57907 10.3747 5.57907H19.4865C19.9778 5.57907 20.4292 5.43013 20.7545 5.19085L20.7611 5.18597C21.0831 4.94669 21.2823 4.61707 21.2823 4.25816V1.32091C21.2823 1.14511 21.2358 0.971759 21.1429 0.815496C21.0533 0.65435 20.9172 0.507854 20.7479 0.385774C20.5819 0.263693 20.3827 0.166029 20.1637 0.100106C19.9678 0.0341825 19.7388 0 19.4931 0ZM25.5046 21.6619V10.7211C25.5046 10.2254 25.3685 9.75421 25.1262 9.32205C24.8739 8.87279 24.5021 8.46993 24.0407 8.13054C23.5793 7.79116 23.0316 7.5177 22.4209 7.33214C21.8333 7.1539 21.1927 7.0538 20.5188 7.0538H9.13983C8.46598 7.0538 7.82533 7.1539 7.23779 7.33214C6.62702 7.52014 6.07931 7.79116 5.61791 8.13054C5.15651 8.46993 4.78473 8.87279 4.53246 9.32205C4.29014 9.75421 4.15404 10.2254 4.15404 10.7211V21.6277C4.6088 21.911 5.06025 22.2821 5.48513 22.7484C5.87351 23.1757 6.23864 23.6836 6.57059 24.272C7.80541 23.813 9.08339 23.4736 10.3979 23.249C11.7522 23.017 13.1464 22.9071 14.5837 22.912C16.0144 22.9169 17.4816 23.0414 18.9853 23.2758C20.4491 23.5053 21.9495 23.8398 23.4798 24.2793C23.6358 23.7495 23.888 23.2661 24.2134 22.8461C24.5652 22.3724 25.0133 21.9744 25.5046 21.6619ZM8.45602 12.3594L8.44274 12.3448C8.3332 12.2153 8.29669 12.064 8.33984 11.9248C8.37968 11.7856 8.48922 11.6538 8.66183 11.5683L8.68174 11.5586C8.85767 11.478 9.06348 11.4511 9.25269 11.4829C9.44853 11.5146 9.62778 11.5976 9.74396 11.727C10.3016 12.3521 10.8095 13.0064 11.2543 13.6925C11.6991 14.3811 12.0842 15.1038 12.3995 15.868C12.7149 16.6298 12.9572 17.4306 13.1265 18.273C13.2924 19.1153 13.3821 20.0016 13.3854 20.9392C13.3854 21.0979 13.2991 21.2395 13.1563 21.3421C13.0169 21.4471 12.8178 21.5105 12.6086 21.5105C12.3929 21.5105 12.2003 21.4471 12.0609 21.3421C11.9182 21.2371 11.8319 21.0955 11.8319 20.9368C11.8286 20.0602 11.7456 19.2325 11.5896 18.4414C11.4336 17.6528 11.2045 16.9081 10.9124 16.1976C10.6203 15.4895 10.2618 14.8181 9.85018 14.1784C9.44189 13.5411 8.97385 12.9356 8.45602 12.3594ZM20.1603 11.7246C20.2798 11.5927 20.4591 11.5073 20.6549 11.4804C20.8508 11.4487 21.0566 11.4755 21.2358 11.5586L21.2458 11.5634C21.4217 11.6513 21.5379 11.7807 21.5744 11.9224C21.6109 12.0664 21.581 12.2178 21.4682 12.3496L21.4615 12.3545C20.9437 12.9307 20.4757 13.5387 20.0641 14.1808C19.6525 14.8205 19.294 15.492 19.0019 16.2C18.7097 16.9106 18.4807 17.6552 18.3247 18.4439C18.1687 19.2325 18.0857 20.0627 18.079 20.9392C18.079 21.0979 17.9927 21.2395 17.85 21.3421C17.7073 21.4471 17.5147 21.5105 17.299 21.5105C17.0832 21.5105 16.8907 21.4471 16.748 21.3421L16.7413 21.3372C16.6052 21.2346 16.5189 21.093 16.5189 20.9368C16.5222 20.0016 16.6119 19.1153 16.7812 18.2705C16.9471 17.4282 17.1928 16.6273 17.5048 15.8655C17.8201 15.1013 18.2019 14.3762 18.6467 13.6901C19.0981 13.0015 19.6027 12.3496 20.1603 11.7246ZM3.09846 22.7435C3.03207 22.7265 2.97233 22.6996 2.91921 22.6727C2.86278 22.641 2.81299 22.6068 2.76652 22.5678C2.64702 22.514 2.53416 22.4676 2.41798 22.4335C2.29848 22.3944 2.1823 22.3675 2.06612 22.3456C1.93002 22.3236 1.80057 22.3138 1.67443 22.3187C1.54829 22.3212 1.42879 22.3382 1.31261 22.3675C1.18647 22.3993 1.07029 22.4457 0.954112 22.5116C0.841251 22.5751 0.73503 22.6508 0.635447 22.746C0.0844215 23.2685 -0.0516752 23.9277 0.011394 24.6211C0.0744632 25.3268 0.346656 26.0715 0.588975 26.7502L0.598933 26.7844C0.662002 26.9626 0.725071 27.1336 0.764904 27.2508L1.36904 29.0087C1.45535 29.2675 1.52505 29.5044 1.58148 29.6972L1.5848 29.7046C1.618 29.834 1.64123 29.9268 1.65451 29.9853C1.65451 29.9927 1.65451 29.9951 1.65119 30C1.65783 29.9976 1.67111 29.9951 1.68771 29.9951C1.79061 29.9902 1.96986 29.9805 2.24205 29.978L2.73333 29.9731H27.4199L27.4465 29.9756H27.629C27.9278 29.9756 28.117 29.9829 28.2299 29.9878C28.2465 29.9878 28.2597 29.9902 28.2763 29.9951V29.9853C28.2896 29.9365 28.3095 29.8584 28.346 29.7485L28.3494 29.7436C28.4091 29.563 28.4855 29.3359 28.5884 29.082L29.312 27.2996C29.7767 26.1594 29.9858 25.2291 29.9991 24.4893C30.0157 23.6592 29.7966 23.0732 29.4348 22.6972C29.3087 22.5702 29.1659 22.4701 29.0099 22.3968C28.8473 22.3212 28.6747 22.2723 28.4888 22.2503C28.2929 22.2284 28.0805 22.2333 27.868 22.265C27.649 22.2992 27.4232 22.3578 27.1975 22.4432C26.5967 22.6703 26.0291 23.0707 25.6009 23.6128C25.2158 24.0986 24.9503 24.6968 24.8806 25.3902L24.8772 25.4049C24.8739 25.4293 24.8673 25.4562 24.8606 25.4806V25.483C24.8507 25.5123 24.8407 25.5392 24.8241 25.566C24.7411 25.7125 24.5851 25.8175 24.3992 25.8737C24.2167 25.9298 24.0042 25.9323 23.8051 25.8712C22.1785 25.3658 20.5919 24.9801 19.0516 24.7188C17.5147 24.4576 16.021 24.3233 14.5771 24.3159C13.1464 24.3111 11.7589 24.4307 10.4211 24.6846C9.08007 24.9361 7.7855 25.3219 6.54071 25.8419L6.47764 25.8639C6.45773 25.8712 6.43117 25.8786 6.41125 25.8835L6.40461 25.8859C6.20213 25.9347 5.99633 25.9225 5.81708 25.859C5.63783 25.7956 5.49177 25.6808 5.42206 25.5319C5.1034 24.858 4.7449 24.2989 4.36317 23.8423C3.95488 23.3686 3.52667 22.9999 3.09846 22.7435Z" fill="black"/></sv >';
    // ignore: avoid_function_literals_in_foreach_calls
    listType.forEach((element) async {
      final picture = await SvgPicture.svgStringDecoder(
          homeIconString,
          ColorFilter.mode(
              listType.firstWhereOrNull((e) => element.type == e.type)?.color ??
                  const Color.fromRGBO(244, 67, 54, 1),
              BlendMode.srcIn),
          '');
      mapImage.value[element.type] = await picture.picture.toImage(30, 30);
    });
    update();
  }

  void selectedSeat({required DataSeat dataSeat}) {
    if (dataSeat.type == type.empty.toString()) {
      Get.snackbar('CHỌN GHẾ LỖI', 'Ghế không tồn tại');
    } else if (dataSeat.type == type.disable.toString()) {
      Get.snackbar('CHỌN GHẾ LỖI', 'Ghế đã được chọn');
    } else if (dataSeat.type == type.selecting.toString()) {
      dataSeat.type = type.enable.toString();
      countSeatSelected.value--;
    } else {
      dataSeat.type = type.selecting.toString();
      countSeatSelected.value++;
    }

    update();
  }
}

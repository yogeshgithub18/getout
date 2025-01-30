import 'package:get/get.dart';
import 'package:get_out/controller/base_controller.dart';
import 'package:get_out/storage/base_shared_preference.dart';

import '../backend/api_end_points.dart';
import '../backend/base_api.dart';
import '../modal/itienerary_details_response.dart';

class ItineraryDetailsController extends GetxController{
  Rx<ItineararyData> details=ItineararyData().obs;
  RxList<StepData> steps=<StepData>[].obs;

  Future<String> getItineraryPdfLink(String id) async{
    String  url='';
    int userId=Get.find<BaseController>().user.value.id!;
    String param="/$userId/$id";
    await BaseAPI().get(url: ApiEndPoints().downloadPdf+param).then((response){
      if(response!=null){
        url=response.data['url']??'';
      }
    });
    return url;
  }

  Future<void> getItineraryDetails(String id,String from) async{
    Map<String,dynamic> param={
      "id":id
    };
    await BaseAPI().get(url: ApiEndPoints().itineraryDetails,queryParameters: param).then((response){
      if(response!=null){
        ItieneraryDetailsResponse detailsResponse=ItieneraryDetailsResponse.fromJson(response.data);
        details.value=detailsResponse.data??ItineararyData();
        //steps.value=(details.value.itenaryDetails??[]).map((e)=>StepData(time: "${details.value.startTime} to ${details.value.endTime}",name: e.name,destination: e.vicinity,isLast:)).toList();
        steps.value = (details.value.itenaryDetails ?? []).asMap().entries.map((entry) {
          int index = entry.key;
          var e = entry.value;

          // Check if it's the last item
          bool isLast = index == (details.value.itenaryDetails!.length - 1);

          return StepData(
            time: "${details.value.startTime} to ${details.value.endTime}",
            name: e.name,
            placeId:e.placeId,
            destination: e.vicinity,
            isLast: isLast,
          );
        }).toList();
      }
    });
  }
}

class StepData {
  final String ?time;
  final String ? name;
  final String ? placeId;
  final String ?destination;
  final bool ? isLast;

  StepData({
     this.time,
    this.name,
    this.placeId,
     this.destination,
     this.isLast,
  });
}
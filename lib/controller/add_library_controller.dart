import 'package:get/get.dart';

import '../backend/api_end_points.dart';
import '../backend/base_api.dart';
import '../modal/category_response.dart';
import '../modal/swipe_card_response.dart';

class AddLibraryController extends GetxController{
  RxList<Interest> interestList  =<Interest>[].obs;
  RxInt selectedIndex=0.obs;
  RxInt selectedFilterIndex=0.obs;
  RxString selectedFilterId=''.obs;
  RxList<Cards> activities=<Cards>[].obs;
  RxList<Cards> selectedEvents=<Cards>[].obs;

  Future<void> getCategory() async{
    activities.value=[];
    await BaseAPI().get(url: ApiEndPoints().availbleCategory).then((response){
      if(response!=null){
        CategoryResponse categoryResponse=CategoryResponse.fromJson(response.data);
        interestList.value=categoryResponse.data??[];
        if(interestList.isNotEmpty) {
          getCards();
        }
      }
    });
  }

  Future<void> getCards() async{
    activities.value=[];
    Map<String,dynamic> params={
      "type":selectedIndex.value==0?'star':'fav',
      "filter_category":interestList.isNotEmpty?interestList[selectedFilterIndex.value].id:null
    };
    await BaseAPI().get(url:ApiEndPoints().favStarList,queryParameters: params).then((response){
      if(response!=null){
        SwipeCardResponse cardsResponse=SwipeCardResponse.fromJson(response.data);
        activities.value=cardsResponse.data??[];
      }
    });
  }
}
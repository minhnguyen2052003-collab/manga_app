import 'package:flutter_riverpod/legacy.dart';

class StatusStarProvider extends StateNotifier<bool>{
  StatusStarProvider() : super(false);

  bool addedStatus() {
    state = true;
    return state;
  }

  bool removedStatus(){
    state = false;

    return state;
  }

  bool resetStatus(){
    if(state = true){
      return !state;
    }else {
      return state;
    }
  }
}

final statusStarProvider = StateNotifierProvider<StatusStarProvider,bool>((ref) => StatusStarProvider(),);
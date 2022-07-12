import 'package:mobx/mobx.dart';
part 'MainViewModel.g.dart';

class MainViewModel = _MainViewModel with _$MainViewModel;

abstract class _MainViewModel with Store {
  @observable
  var currentIndex = Observable(0);

  @action
  setCurrentIndex(int index){
    currentIndex.value = index;
  }
}
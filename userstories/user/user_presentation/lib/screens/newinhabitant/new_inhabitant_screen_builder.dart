import 'package:flutter/cupertino.dart';

import 'new_inhabitant_viewmodel.dart';

class NewInhabitantScreenBuilder {
  NewInhabitantScreenBuilder._();

  static NewInhabitantScreenViewModel buildAndRunVM(BuildContext context) {
    var vm = NewInhabitantScreenViewModel();
    vm.fetchData();
    return vm;
  }
}

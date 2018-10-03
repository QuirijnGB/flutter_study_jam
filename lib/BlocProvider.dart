import 'package:flutter/widgets.dart';
import 'package:flutter_study_jam_week_2/TodoBloc.dart';

class BlocProvider extends InheritedWidget {
  final TodoBloc bloc;

  BlocProvider({Key key, Widget child, this.bloc})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static BlocProvider of(BuildContext context) {
    BlocProvider provider = context.inheritFromWidgetOfExactType(BlocProvider);
    return provider;
  }
}

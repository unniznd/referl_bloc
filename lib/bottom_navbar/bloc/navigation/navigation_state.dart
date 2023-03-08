abstract class NavigationState {}

class NavigationScreen extends NavigationState {
  int index = 0;
  NavigationScreen(this.index);
}

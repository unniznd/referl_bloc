abstract class NavigationEvent {}

class NavigateToScreen extends NavigationEvent {
  final int index;
  NavigateToScreen(this.index);
}

enum NavigationRoute {
  mainRoute("/"),
  inputNameRoute("/inputName"),
  mainMenuRoute("/mainMenu"),
  detailRoute("/detail"),
  settingRoute("/setting"),
  searchRoute("/search");

  const NavigationRoute(this.name);
  final String name;
}

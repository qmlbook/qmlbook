App {
  onInitTheme: {
    Theme.na.backgroundColor = "#ff0000"
    Theme.colors.backgroundColor = "#cccccc"
    Theme.colors.secondaryBackgroundColor = "#cccccc"
    Theme.platform = (Theme.platform === "android") ? "ios" : "android"
   }
}

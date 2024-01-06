class ApiConstants{
  static const String url = "http://10.20.0.112:3151";

  static const String loginUrl = "$url/auth/login";
  static const String signupUrl = "$url/auth/signup";
  static const String refreshUrl = "$url/auth/refresh";
  static const String getItemsUrl = "$url/app/get_items";
  static const String getItemIdPageUrl = "$url/app/get_item_id_page";
  static const String getFavoritesUrl = "$url/app/get_favorites";
  static const String setFavoriteUrl = "$url/app/set_favorite";
}
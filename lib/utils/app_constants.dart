class AppConstants {
  static const String APP_NAME = 'FOOD';
  static const String APP_VERSION = '1';

  static const String BASE_URL = 'https://store.g-brain.uz/public';
  static const String IMAGE_URI = 'https://store.g-brain.uz/public/uploads/';
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URI = "/api/v1/products/recommended";

  static const String REGISTRATION_URI = '/api/v1/auth/register';
  static const String LOGIN_URI = '/api/v1/auth/login';
  static const String USER_INFO = '/api/v1/customer/info';

  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";

  static const String CART_LIST = "cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";

  //google maps
  static const String USER_ADDRESS = "cart-address";
  static const String ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI = "/api/v1/customer/address/list";
  static const String GEOCODE_URI = "/api/v1/config/geocode-api";
}

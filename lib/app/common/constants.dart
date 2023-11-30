abstract class Constants {
  static const String baseUrl = 'https://famooshed.com/admin/public/api/';
  static const String imgUrl = 'https://famooshed.com/admin/public/images/';

  static String getMapImage(String label, String lat, String lng) =>
      'https://maps.googleapis.com/maps/api/staticmap?markers=color:0x215034%7Clabel:$label%7C%7C$lat,$lng&zoom=15&size=400x225&key=AIzaSyBlPrKDHq4CtetPgQivrBqsH87JkvLGtQw&scale=4';
  // String.fromEnvironment('https://jsonplaceholder.typicode.com/posts');

  static const timeout = Duration(seconds: 6);
  static const String token = 'authToken';
  static const String userId = 'UserId';
  static const String rememberMe = 'rememberMe';
  static const String isLoggedIn = 'isLoggedIn';
  static const String cartList = 'cartList';
  static const String cartRestId = 'cartRestId';
  // static const String kGoogleMapKey = 'AIzaSyAyrWhY3ALKo6NORh9f_gcwGGdWPT3Phdk';
  static const String kGoogleMapKey = 'AIzaSyAyrWhY3ALKo6NORh9f_gcwGGdWPT3Phdk';

  static const String dummyImageUrl =
      'https://picsum.photos/id/1084/536/354.jpg'
      '?grayscale&hmac=Ux7nzg19e1q35mlUVZjhCLxqkR30cC-CarVg-nlIf60';
  static const String placeHolderBlurHash = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

  static const String baseUrlNew = 'https://www.famooshed.com/';
}

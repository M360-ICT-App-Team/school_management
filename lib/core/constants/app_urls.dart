// import 'package:flutter_dotenv/flutter_dotenv.dart';

// final bool isLive = false; // Set to true for production environment

// class AppUrls {
//   static String versionUrl = dotenv.env['VERSION_URL']!;
//   static String currentVersion = dotenv.env['CURRENT_VERSION']!;
//   static String fileUrl = dotenv.env['FILE_URL']!;
//   static String baseUrl =
//       isLive ? dotenv.env['BASE_URL']! : "http://10.10.220.25:1880/api/v1";

//   //Flag
//   static String flagImage({required String iso}) =>
//       'https://flagsapi.com/${iso.toUpperCase()}/flat/64.png';

//   //for common
//   static String airportList = "$baseUrl/common/airport?name=";
//   static String airlineListAll = "$baseUrl/common/airlines";
//   static String airlineList = "$baseUrl/btob/multi-api/flight/airlines";
//   static String country = '$baseUrl/common/country';

//   static String city({required int countryId}) =>
//       '$baseUrl/common/city?country_id=$countryId';

//   //for auth
//   static String loginUrl = '$baseUrl/auth/agent/login';
//   static String verifyOtp = '$baseUrl/auth/agent/verify-otp';
//   static String sendEmailOtp =
//       '$baseUrl/common/send-email-otp'; //type: reset_agent
//   static String reSendOtp = '$baseUrl/auth/agent/resend-otp';
//   static String matchEmailOtp = '$baseUrl/common/match-email-otp';
//   static String forgetPassword = '$baseUrl/auth/agent/forget-password';
//   static String registration = '$baseUrl/auth/agent/registration-request';

//   // for profile
//   static String profile = '$baseUrl/btob/profile';

//   //for booking
//   static String flightBookingList =
//       '$baseUrl/btob/multi-api/flight/booking'; //for details /416
//   static String issueTicket = "$baseUrl/btob/multi-api/flight/ticket-issue";

//   ///416

//   // for flight
//   static String flightSearchSSE = "$baseUrl/btob/multi-api/flight/search/sse";

//   static String flightRevalidate({
//     required String searchId,
//     required String flightId,
//   }) =>
//       "$baseUrl/btob/multi-api/flight/revalidate?search_id=$searchId&flight_id=$flightId";
//   static String bookFlight = "$baseUrl/btob/multi-api/flight/booking/v2";

//   //for ssl
//   static String sslUrl = dotenv.env['SSL_URL'] ?? "";
//   static String sslStoreId = isLive ? dotenv.env['SSL_STORE_ID']! : "testbox";
//   static String sslStorePassword =
//       isLive ? dotenv.env['SSL_STORE_PASSWORD']! : "qwerty";

//   //for payment
//   static String paymentSuccess = '$baseUrl/payment/success';

//   // for traveler
//   static String traveler({int? id}) =>
//       '$baseUrl/btob/travelers${id != null ? "/$id" : ""}';

//   //for booking support
//   static String bookingService = '$baseUrl/btob/booking-service';

//   //for airport assistance
//   static String airportAssistanceAirportList =
//       '$baseUrl/common/airport-assistance/airport-list';

//   static String airportAssistanceList({int? id}) =>
//       '$baseUrl/btob/airport-assistance${id != null ? "/$id" : ""}';

//   static String airportAssistanceBooking({required int id}) =>
//       '$baseUrl/btob/airport-assistance/booking/$id';

//   static String airportAssistanceTravelerInfo({
//     required String pnr,
//     required String type,
//   }) =>
//       '$baseUrl/btob/airport-assistance/booking/traveler-info?pnr=$pnr&type=$type';

//   static String airportAssistanceBookingList =
//       '$baseUrl/btob/airport-assistance/booking';
//   static String airportAssistanceBookingDetails =
//       '$baseUrl/btob/airport-assistance/booking';
//   //for visa
//   static String visaCountryList = '$baseUrl/common/visa-country';

//   static String visaSearchResultList({String? countryId}) =>
//       '$baseUrl/common/visa${countryId != null ? "/$countryId" : ""}';
//   static String visaApply = "$baseUrl/btob/visa-application";

//   //for accounts
//   static String deposit = '$baseUrl/btob/deposit-request';
//   static String generalLedger = '$baseUrl/btob/payment/transaction';

//   //for invoice
//   static String invoiceList = '$baseUrl/btob/payment/invoice';

//   //for partial pay booking
//   static String partialPayBookingList =
//       '$baseUrl/btob/payment/partial-payment-history';

//   //for my bank
//   static String myBankList({int? id}) =>
//       '$baseUrl/btob/bank/bank-account${id != null ? "/$id" : ""}';

//   //for deposit details
//   static String depositDetails = '$baseUrl/btob/deposit-request';

//   // for invoice pdf
//   static String invoicePdf = '$baseUrl/btob/payment/invoice';

//   //!for hotel
//   static String baseUrlHotel = dotenv.env['HOTEL_BASE_URL'] ?? ''; //!Server url
//   // static const String baseUrlHotel = "http://10.10.220.22:1800/api/v1"; //!Local url
//   static String grnBaseUrl = dotenv.env['GRN_BASE_URL'] ?? '';
//   static String hotelSearch = "$baseUrlHotel/btoc/hotel/search";
//   static String hotelAvailability({
//     required String searchId,
//     required String hotelCode,
//     required int nights,
//   }) => "$baseUrlHotel/btoc/hotel/rooms/$searchId?hcode=$hotelCode&uc=BDT";
//   static String hotelRecheck = "$baseUrlHotel/btoc/hotel/recheck";
//   static String locationList({required String searchKey}) =>
//       "$baseUrlHotel/common/location/search${searchKey.isNotEmpty ? "?search_key=$searchKey" : ""}";
//   // >>>>>>> 2d1dcaf41a5b40eb2eca9f01b16ffbbb3875d215
//   static String countryList = "$baseUrlHotel/common/country";
//   static String currencyList = "$baseUrlHotel/common/dscv-hotel-currency";

//   // for user

//   static String userGetList = '$baseUrl/btob/administration/admin';
//   static String roleGetList = '$baseUrl/btob/administration/role';
//   static String userPost = '$baseUrl/btob/administration/admin';

//   static String permissionGetList = '$baseUrl/btob/administration/permission';

//   static String addRole = '$baseUrl/btob/administration/permission';

  
// }

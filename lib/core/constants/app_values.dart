

// import '../utilities/app_string_modify.dart';

// class AppValues {
//   static const String appName = "Let's Fly BD";
//   static const String ticketSupportNumber = "+8801754817463";
//   static const String customerSupportNumber = "+8801754817463";
//   static const String address = "Banani, Dhaka, Bangladesh";
//   static const String currentAccount = "Current Account";

//   static const List<String> mfsProviders = ["Bkash", "Nagad", "Rocket", "Upay"];
//   static const List<String> status = ['Active', 'Inactive'];

//   static const String oneWay = "One Way";
//   static const String roundTrip = "Round Trip";
//   static const String multiCity = "Multi City";
//   static const String departure = "Departure";
//   static const String arrival = "Arrival";
//   static const String departureDate = "Departure Date";
//   static const String returnDate = "Return Date";
//   static const String searchFlight = "Search Flight";
//   static const String cheapest = "Cheapest";
//   static const String earliest = "Earliest";
//   static const String fastest = "Fastest";

//   static const String ordinary = "Ordinary";
//   static const String diplomatic = "Diplomatic";
//   static const String official = "Official";

//   static const List<String> passportTypes = [ordinary, diplomatic, official];

//   static const String male = "Male";
//   static const String female = "Female";
//   static const String adult = "Adult";
//   static const String child = "Child";
//   static const String infant = "Infant";
//   static const String mr = "Mr";
//   static const String ms = "Ms";
//   static const String mrs = "Mrs";
//   static const String miss = "Miss";
//   static const String master = "Master";

//   static const List journeyType = [
//     JourneyTypeModel(name: AppValues.oneWay, code: "1"),
//     JourneyTypeModel(name: AppValues.roundTrip, code: "2"),
//     JourneyTypeModel(name: AppValues.multiCity, code: "3"),
//   ];
//   static List<TravelerTypeModel> travelerContainList({String? childType}) => [
//     TravelerTypeModel(
//       title: adult,
//       subTitle: "(12 years and above)",
//       code: "ADT",
//     ),
//     TravelerTypeModel(
//       title: child,
//       subTitle:
//           childType?.startsWith("C") ?? false
//               ? travelerType(childType).split(child).last
//               : "(2-11 years at travel time)",
//       code: childType?.startsWith("C") ?? false ? childType ?? "" : "C11",
//     ),
//     TravelerTypeModel(
//       title: infant,
//       subTitle: "(0-23 months at travel time)",
//       code: "INF",
//     ),
//   ];

//   static List<FlightClassModel> flightClassList = [
//     FlightClassModel(name: "Economy", code: "1"),
//     FlightClassModel(name: "Premium", code: "2"),
//     FlightClassModel(name: "Business", code: "3"),
//     FlightClassModel(name: "First", code: "4"),
//   ];
//   static List<FlightClassModel> flightClassListForAirportAssistance = [
//     FlightClassModel(name: "Economy", code: "1"),
//     FlightClassModel(name: "Premium", code: "2"),
//     // FlightClassModel(name: "Business", code: "3"),
//     FlightClassModel(name: "First", code: "4"),
//   ];

//   static final daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
//   static final months = [
//     'Jan',
//     'Feb',
//     'Mar',
//     'Apr',
//     'May',
//     'Jun',
//     'Jul',
//     'Aug',
//     'Sep',
//     'Oct',
//     'Nov',
//     'Dec',
//   ];

//   static List<String> referenceType = [
//     // "Mr", "Ms", "Mrs", "Miss", "Master",
//     mr, ms, mrs, miss, master,
//   ];
//   static List<String> genderType = [
//     // "Male", "Female",
//     male, female,
//   ];

//   static final flightBookingStatus = [
//     "issued",
//     "ticket-in-process",
//     "booking-cancelled",
//     "pending",
//     "voided",
//     "ticket-hold",
//     "refunded",
//   ];

//   static final List<Map<String, String>> importantReminders = [
//     {
//       "title": "Flight Status",
//       "sub_title":
//           "Before your flight, please check your updated flight status on the airline website or by calling the airline customer support.",
//     },
//     {
//       "title": "Online Check-In",
//       "sub_title":
//           "Airline website usually have online check-in available which can be availed to.",
//     },
//     {
//       "title": "Bag Drop Counter",
//       "sub_title":
//           "Please be at the check-in bag Drop counter before closure for document verification & acceptance of check-in baggage.",
//     },
//     {
//       "title": "Government Issued ID card",
//       "sub_title":
//           "Please carry a government issued ID card along with your e-ticket while travelling.",
//     },
//     {
//       "title": "Emergency Exit Row",
//       "sub_title":
//           "Passengers seated on the emergency exit row must comply with safety regulations & requirements.",
//     },
//   ];

//   static const List<String> supportTypes = [
//     "Date Change",
//     "Refund",
//     "VOID",
//     "Add Wheel Chair",
//     "Add VIP/CIP/MASS",
//     "Add Frequent Flyer",
//     "Seat Assign Request",
//     "Air Ticket Copy",
//     "Split PNR",
//     "Extra Baggage",
//     "Other",
//   ];

//   static FlightBookingConfirmedMessage
//   bookingConfirmedMessage = FlightBookingConfirmedMessage(
//     image: AppImages.bookingConfirmed,
//     title: "🎉 Booking Confirmed 🎉 ",
//     subTitle: "Confirmation Email Has Been Sent to the Provided Email Address.",
//     priceAlert:
//         "Ticket prices are subject to change and are only guaranteed at the time of ticketing.",
//     pnrAlert:
//         "Please ensure the PNR is issued or canceled before the airline automatically cancels the booking to avoid penalties or ADM charges.",
//   );

//   static AirportAssistanceBookingConfirmedMessage
//   airportAssistanceBookingConfirmedMessage = AirportAssistanceBookingConfirmedMessage(
//     image: AppImages.airportAssistance,
//     title: "🎉 Booking Confirmed 🎉 ",
//     subTitle:
//         "Thank you for choosing our VIP Airport Assistance service! Your booking has been confirmed and our team is ready to provide you with a seamless airport experience.",
//     description:
//         "You'll receive a confirmation email shortly with your booking reference number. Our representative will meet you at the airport with a personalized name board to assist you throughout your journey.",
//     bookingDetails: BookingDetails(
//       title: "Premium Airport Assistance",
//       subTitle: "Fast-track immigration, baggage handling",
//     ),
//     phone: "+1 (800) 123-4567",
//     email: "support@bimanholidays.com",
//   );
//   static AirportAssistanceBookingConfirmedMessage
//   visaAppliedConfirmedMessage = AirportAssistanceBookingConfirmedMessage(
//     image: AppImages.visaApplied,
//     title: "🎉 Applied Successfully 🎉 ",
//     subTitle:
//         "Thank you for choosing our Visa Application Services! Our team is ready to provide you with a seamless airport experience.",
//     description:
//         "You'll receive a confirmation email shortly with your application details",
//     phone: "+1 (800) 123-4567",
//     email: "support@bimanholidays.com",
//   );

//   static const List hotelImages = [
//     {
//       "image": AppImages.hotelImage1,
//       "title": "Stay in Style",
//       "description":
//           "Find handpicked hotels that blend comfort, style, and convenience for every traveler.",
//     },
//     {
//       "image": AppImages.hotelImage2,
//       "title": "Relax & Unwind",
//       "description":
//           "Book stays that offer more than just rooms — experience service that stands out.",
//     },
//     {
//       "image": AppImages.hotelImage3,
//       "title": "Search & Book",
//       "description":
//           "Easily compare and choose from a wide range of hotels to suit your budget and needs.",
//     },
//     {
//       "image": AppImages.hotelImage4,
//       "title": "Rest Well",
//       "description":
//           "Enjoy smooth hotel bookings, real guest reviews, and locations close to where you want to be.",
//     },
//   ];
// }

// class FlightBookingConfirmedMessage {
//   String? image;
//   String? title;
//   String? subTitle;
//   String? priceAlert;
//   String? pnrAlert;

//   FlightBookingConfirmedMessage({
//     this.image,
//     this.title,
//     this.subTitle,
//     this.priceAlert,
//     this.pnrAlert,
//   });
// }

// class AirportAssistanceBookingConfirmedMessage {
//   String? image;
//   String? title;
//   String? subTitle;
//   String? description;
//   String? email;
//   String? phone;
//   BookingDetails? bookingDetails;

//   AirportAssistanceBookingConfirmedMessage({
//     this.image,
//     this.title,
//     this.subTitle,
//     this.description,
//     this.bookingDetails,
//     this.email,
//     this.phone,
//   });
// }

// class BookingDetails {
//   final String title;
//   final String subTitle;

//   BookingDetails({required this.title, required this.subTitle});
// }

// enum PermissionType {
//   read('read'),
//   write('write'),
//   update('update'),
//   delete('delete');

//   final String value;
//   const PermissionType(this.value);
// }

// class AppPermissionValues {
//   static const String flightSearch = "Flight Search";
//   static const String flightBooking = "Flight Booking";

//   static const String banks = "Accounts - Banks";
//   static const String deposit = "Payment - Deposit";
//   static const String ledger =
//       "Payment - Transaction History"; // there is spelling error
//   static const String partialBooking = "Payment - Partial Booking";
//   static const String invoice = "Invoice - Lists";

//   static const String visa = "Visa Search - Visa Search";

//   static const String airportAisstance = "Airport Service";

//   static const String bookingSupport = "Booking Support";
//   static const String traveler = "Travels";
//   static const String booking = "Booking";
//   static const String visaSearch = "Visa Search";
//   static const String visaApply = "Visa Search - Application List";
//   static const String payment = "Payment"; 

//   static const String myBank = "Accounts - Banks";
// }

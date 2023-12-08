class GetRestaurantByCatNewResponse {
  List<Resturneartous>? resturneartous;
  Map<String, Vendordetailbycat>? vendordetailbycat;

  GetRestaurantByCatNewResponse({
    this.resturneartous,
    this.vendordetailbycat,
  });
  factory GetRestaurantByCatNewResponse.fromJson(Map<String, dynamic> json) {
    List<Resturneartous>? resturneartousList;
    if (json['resturneartous'] != null) {
      resturneartousList = List<Resturneartous>.from(
        json['resturneartous'].map((x) => Resturneartous.fromJson(x)),
      );
    }
    // Map<String, Vendordetailbycat>? vendordetailbycatMap;
    // if (json['vendordetailbycat'] != null) {
    //   vendordetailbycatMap = Map<String, Vendordetailbycat>.fromEntries(
    //       json['vendordetailbycat'].map((e) =>
    //           MapEntry<String, Vendordetailbycat>(
    //               e.key, Vendordetailbycat.fromJson(e.value))));
    // }
    Map<String, Vendordetailbycat>? vendordetailbycatMap;
    if (json['vendordetailbycat'] != null &&
        json['vendordetailbycat'] is Map<String, dynamic>) {
      vendordetailbycatMap = Map<String, Vendordetailbycat>.fromEntries(
        (json['vendordetailbycat'] as Map<String, dynamic>).entries.map(
              (e) => MapEntry<String, Vendordetailbycat>(
                e.key,
                Vendordetailbycat.fromJson(e.value),
              ),
            ),
      );
    } else {
      // Handle the case when vendordetailbycat is empty or not present
      vendordetailbycatMap = {};
    }

    return GetRestaurantByCatNewResponse(
      resturneartous: resturneartousList,
      vendordetailbycat: vendordetailbycatMap,
    );
  }

  // Check if resturneartous data exists
  bool hasResturneartous() {
    return resturneartous != null && resturneartous!.isNotEmpty;
  }

  // Check if vendordetailbycat data exists
  bool hasVendordetailbycat() {
    return vendordetailbycat != null && vendordetailbycat!.isNotEmpty;
  }
}

class Resturneartous {
  int id;
  int area;
  String name;
  String slug;
  String address;
  String openTimeMonday;
  String closeTimeMonday;
  String filename;
  double distance;
  String favStatus;
  String btnClass;

  Resturneartous({
    required this.id,
    required this.area,
    required this.name,
    required this.slug,
    required this.address,
    required this.openTimeMonday,
    required this.closeTimeMonday,
    required this.filename,
    required this.distance,
    required this.favStatus,
    required this.btnClass,
  });

  factory Resturneartous.fromJson(Map<String, dynamic> json) {
    return Resturneartous(
      id: json['id'],
      area: json['area'],
      name: json['name'],
      slug: json['slug'],
      address: json['address'],
      openTimeMonday: json['openTimeMonday'],
      closeTimeMonday: json['closeTimeMonday'],
      filename: json['filename'],
      distance: json['distance'].toDouble(),
      favStatus: json['favStatus'],
      btnClass: json['btnClass'],
    );
  }
}

class Vendordetailbycat {
  int id;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String slug;
  String businessName;
  String businessAddress;
  String bcity;
  String bzipcode;
  String country;
  String businesstype;
  dynamic cuisineName;
  String numOfLocation;
  String delivertype;
  int published;
  int delivered;
  String phone;
  String mobilephone;
  String address;
  String lat;
  String lng;
  String flatHouseNo;
  String nearByLandmark;
  int imageid;
  int logoId;
  String desc;
  String fee;
  String nextDayFee;
  String homeDeliFee;
  double merchantCommission;
  int percent;
  int homeDeliPercent;
  String bestSeller;
  String facebook;
  String instagram;
  String twitter;
  dynamic accountnumber;
  dynamic holderName;
  dynamic bankcode;
  String bRoutingNumber;
  String bankType;
  String cardName;
  String cardNumber;
  String cardCvc;
  String cardMm;
  String cardYy;
  dynamic stripeId;
  String openTimeMonday;
  String closeTimeMonday;
  String openTimeTuesday;
  String closeTimeTuesday;
  String openTimeWednesday;
  String closeTimeWednesday;
  String openTimeThursday;
  String closeTimeThursday;
  String openTimeFriday;
  String closeTimeFriday;
  String openTimeSaturday;
  String closeTimeSaturday;
  String openTimeSunday;
  String closeTimeSunday;
  int area;
  dynamic cardId;
  dynamic bankId;
  String minAmount;
  int perkm;
  int homeDeliPerkm;
  dynamic crn;
  int onlyfamooshed;
  int pickUp;
  int homeDeli;
  int nextDay;
  int user;
  String email;
  String image;

  Vendordetailbycat({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.slug,
    required this.businessName,
    required this.businessAddress,
    required this.bcity,
    required this.bzipcode,
    required this.country,
    required this.businesstype,
    required this.cuisineName,
    required this.numOfLocation,
    required this.delivertype,
    required this.published,
    required this.delivered,
    required this.phone,
    required this.mobilephone,
    required this.address,
    required this.lat,
    required this.lng,
    required this.flatHouseNo,
    required this.nearByLandmark,
    required this.imageid,
    required this.logoId,
    required this.desc,
    required this.fee,
    required this.nextDayFee,
    required this.homeDeliFee,
    required this.merchantCommission,
    required this.percent,
    required this.homeDeliPercent,
    required this.bestSeller,
    required this.facebook,
    required this.instagram,
    required this.twitter,
    required this.accountnumber,
    required this.holderName,
    required this.bankcode,
    required this.bRoutingNumber,
    required this.bankType,
    required this.cardName,
    required this.cardNumber,
    required this.cardCvc,
    required this.cardMm,
    required this.cardYy,
    required this.stripeId,
    required this.openTimeMonday,
    required this.closeTimeMonday,
    required this.openTimeTuesday,
    required this.closeTimeTuesday,
    required this.openTimeWednesday,
    required this.closeTimeWednesday,
    required this.openTimeThursday,
    required this.closeTimeThursday,
    required this.openTimeFriday,
    required this.closeTimeFriday,
    required this.openTimeSaturday,
    required this.closeTimeSaturday,
    required this.openTimeSunday,
    required this.closeTimeSunday,
    required this.area,
    required this.cardId,
    required this.bankId,
    required this.minAmount,
    required this.perkm,
    required this.homeDeliPerkm,
    required this.crn,
    required this.onlyfamooshed,
    required this.pickUp,
    required this.homeDeli,
    required this.nextDay,
    required this.user,
    required this.email,
    required this.image,
  });
  factory Vendordetailbycat.fromJson(Map<String, dynamic> json) {
    return Vendordetailbycat(
      id: json['id'],
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      name: json['name'],
      slug: json['slug'],
      businessName: json['businessName'],
      businessAddress: json['businessAddress'],
      bcity: json['bcity'],
      bzipcode: json['bzipcode'],
      country: json['country'],
      businesstype: json['businesstype'],
      cuisineName: json['cuisineName'],
      numOfLocation: json['numOfLocation'],
      delivertype: json['delivertype'],
      published: json['published'],
      delivered: json['delivered'],
      phone: json['phone'],
      mobilephone: json['mobilephone'],
      address: json['address'],
      lat: json['lat'],
      lng: json['lng'],
      flatHouseNo: json['flatHouseNo'],
      nearByLandmark: json['nearByLandmark'],
      imageid: json['imageid'],
      logoId: json['logoId'],
      desc: json['desc'],
      fee: json['fee'],
      nextDayFee: json['nextDayFee'],
      homeDeliFee: json['homeDeliFee'],
      merchantCommission: json['merchantCommission'],
      percent: json['percent'],
      homeDeliPercent: json['homeDeliPercent'],
      bestSeller: json['bestSeller'],
      facebook: json['facebook'],
      instagram: json['instagram'],
      twitter: json['twitter'],
      accountnumber: json['accountnumber'],
      holderName: json['holderName'],
      bankcode: json['bankcode'],
      bRoutingNumber: json['bRoutingNumber'],
      bankType: json['bankType'],
      cardName: json['cardName'],
      cardNumber: json['cardNumber'],
      cardCvc: json['cardCvc'],
      cardMm: json['cardMm'],
      cardYy: json['cardYy'],
      stripeId: json['stripeId'],
      openTimeMonday: json['openTimeMonday'],
      closeTimeMonday: json['closeTimeMonday'],
      openTimeTuesday: json['openTimeTuesday'],
      closeTimeTuesday: json['closeTimeTuesday'],
      openTimeWednesday: json['openTimeWednesday'],
      closeTimeWednesday: json['closeTimeWednesday'],
      openTimeThursday: json['openTimeThursday'],
      closeTimeThursday: json['closeTimeThursday'],
      openTimeFriday: json['openTimeFriday'],
      closeTimeFriday: json['closeTimeFriday'],
      openTimeSaturday: json['openTimeSaturday'],
      closeTimeSaturday: json['closeTimeSaturday'],
      openTimeSunday: json['openTimeSunday'],
      closeTimeSunday: json['closeTimeSunday'],
      area: json['area'],
      cardId: json['cardId'],
      bankId: json['bankId'],
      minAmount: json['minAmount'],
      perkm: json['perkm'],
      homeDeliPerkm: json['homeDeliPerkm'],
      crn: json['crn'],
      onlyfamooshed: json['onlyfamooshed'],
      pickUp: json['pickUp'],
      homeDeli: json['homeDeli'],
      nextDay: json['nextDay'],
      user: json['user'],
      email: json['email'],
      image: json['image'],

      // ... Map other JSON fields to class properties
    );
  }
}

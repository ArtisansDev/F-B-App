/// error : false
/// statusCode : 200
/// statusMessage : "Data Retrieved Successfully"
/// data : [{"IsPOSEnable":true,"IsAndroidEnable":true,"IsIOSEnable":false,"AndroidAppVersion":"21","IOSAppVersion":"15","CompulsoryUpdateIn":1,"TermsAndCondition":"<h2>Terms and Conditions</h2><p>Welcome to <strong>Apple Cinema</strong>. We are delighted to have you as our guest. By using our services, including reservations, ticket purchases, and dining, you agree to the following terms and conditions. Please read them carefully.</p><h3>1. Reservations</h3><p>All reservations for cinema screenings and dining experiences must be made in advance through our official website or mobile application. We recommend booking early to secure your preferred time. You may cancel or modify your reservation up to 24 hours prior to your scheduled time. Cancellations made within 24 hours will incur a fee.</p><h3>2. Payment Policy</h3><p>We accept a variety of payment methods, including credit/debit cards, mobile wallets, and Apple Pay. All payments must be settled in full at the time of booking or before entering the premises. A receipt will be provided for all transactions.</p><h3>3. Code of Conduct</h3><p>To maintain a pleasant and safe environment, we kindly ask all guests to treat our staff and fellow patrons with respect. Any behavior deemed disruptive, abusive, or harmful will result in immediate removal from the premises without refund. Our team is available to assist with any issues to ensure a positive experience.</p><h3>4. Food and Beverage</h3><p>In compliance with our health and safety guidelines, guests are required to consume only food and beverages purchased at <strong>Apple Cinema</strong>. We offer an extensive menu, including vegetarian, vegan, and gluten-free options to suit all dietary preferences. Kindly refrain from bringing outside food and drinks into the cinema.</p><h3>5. Privacy and Data Protection</h3><p>Your privacy is important to us. We collect and process personal information, such as your name, contact details, and payment information, solely for the purpose of fulfilling reservations and providing a personalized experience. Your data is stored securely and will not be shared with third parties without your consent. For more details, please refer to our Privacy Policy.</p><h3>6. Liability</h3><p><strong>Apple Cinema</strong> is not responsible for any personal injury, loss, or damage to property that occurs on the premises. Guests are responsible for their personal belongings. In the event of an incident, please notify our staff immediately, and we will address it promptly.</p>","AboutUs":"<h2>About Apple Cinema</h2><p><strong>Apple Cinema</strong> is a unique fusion of cinema and dining, offering a one-of-a-kind experience where movie lovers can enjoy delicious meals in a luxurious theater setting. Founded in 2024, we strive to provide the highest quality of entertainment, food, and service.</p><h3>Our Mission</h3><p>At Apple Cinema, our mission is to create a memorable and immersive experience for all our guests. Whether you're here for a blockbuster movie, a romantic dinner, or a family-friendly outing, we aim to provide a comfortable and enjoyable environment with exceptional food and entertainment.</p><h3>Our Vision</h3><p>We envision a future where movie theaters are not just about watching films but offer a complete experience for all the senses. Apple Cinema aims to be the go-to destination for movie buffs and foodies alike, where guests can indulge in gourmet meals while enjoying their favorite movies on the big screen.</p><h3>What We Offer</h3><ul><li>Luxury theater seating with recliners and blankets for comfort.</li><li>Gourmet food and beverages, from handcrafted burgers to signature cocktails.</li><li>A wide selection of movie genres and special screenings, including 3D and IMAX films.</li><li>Private event hosting and group bookings for corporate outings, parties, and celebrations.</li></ul><h3>Our Core Values</h3><ul><li><strong>Quality:</strong> We never compromise on the quality of our food, beverages, or entertainment.</li><li><strong>Customer Satisfaction:</strong> Your experience is our top priority. We strive to exceed your expectations every time.</li><li><strong>Innovation:</strong> We're always looking for new ways to enhance your experience, from the latest technology to innovative culinary creations.</li><li><strong>Sustainability:</strong> We are committed to reducing our environmental footprint through eco-friendly practices and sustainable sourcing of ingredients.</li></ul>","RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","PaymentResponses":[{"RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","PaymentGatewayIDP":"4edd3f4b-0115-4706-8244-452612462b83","PaymentGatewaySettingIDP":"a31ea642-eae3-4361-b097-c4bf2d998c01","PaymentGatewayName":"Senang Pay","Description":"Senang Pay","PaymentGatewayLogo":"http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638678132549611074.png","PaymentGatewayNo":"1","MerchantID":"761173165749545","SecretKey":"43106-268","APIKey":"","URL":"","Configurations":""},{"RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","PaymentGatewayIDP":"6e9934ce-fe33-4c2d-9628-fae5475f3a25","PaymentGatewaySettingIDP":"3224d722-48f4-4c99-915b-81b19740b7c3","PaymentGatewayName":"Cash","Description":"Cash payment option","PaymentGatewayLogo":"http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638678102710393181.png","PaymentGatewayNo":"0","MerchantID":"","SecretKey":"","APIKey":"","URL":"","Configurations":""}]}]

class GetGeneralSettingResponse {
  GetGeneralSettingResponse({
    this.error,
    this.statusCode,
    this.statusMessage,
    this.data,});

  GetGeneralSettingResponse.fromJson(dynamic json) {
    error = json['error'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(GetGeneralSettingData.fromJson(v));
      });
    }
  }
  bool? error;
  int? statusCode;
  String? statusMessage;
  List<GetGeneralSettingData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['statusCode'] = statusCode;
    map['statusMessage'] = statusMessage;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// IsPOSEnable : true
/// IsAndroidEnable : true
/// IsIOSEnable : false
/// AndroidAppVersion : "21"
/// IOSAppVersion : "15"
/// CompulsoryUpdateIn : 1
/// TermsAndCondition : "<h2>Terms and Conditions</h2><p>Welcome to <strong>Apple Cinema</strong>. We are delighted to have you as our guest. By using our services, including reservations, ticket purchases, and dining, you agree to the following terms and conditions. Please read them carefully.</p><h3>1. Reservations</h3><p>All reservations for cinema screenings and dining experiences must be made in advance through our official website or mobile application. We recommend booking early to secure your preferred time. You may cancel or modify your reservation up to 24 hours prior to your scheduled time. Cancellations made within 24 hours will incur a fee.</p><h3>2. Payment Policy</h3><p>We accept a variety of payment methods, including credit/debit cards, mobile wallets, and Apple Pay. All payments must be settled in full at the time of booking or before entering the premises. A receipt will be provided for all transactions.</p><h3>3. Code of Conduct</h3><p>To maintain a pleasant and safe environment, we kindly ask all guests to treat our staff and fellow patrons with respect. Any behavior deemed disruptive, abusive, or harmful will result in immediate removal from the premises without refund. Our team is available to assist with any issues to ensure a positive experience.</p><h3>4. Food and Beverage</h3><p>In compliance with our health and safety guidelines, guests are required to consume only food and beverages purchased at <strong>Apple Cinema</strong>. We offer an extensive menu, including vegetarian, vegan, and gluten-free options to suit all dietary preferences. Kindly refrain from bringing outside food and drinks into the cinema.</p><h3>5. Privacy and Data Protection</h3><p>Your privacy is important to us. We collect and process personal information, such as your name, contact details, and payment information, solely for the purpose of fulfilling reservations and providing a personalized experience. Your data is stored securely and will not be shared with third parties without your consent. For more details, please refer to our Privacy Policy.</p><h3>6. Liability</h3><p><strong>Apple Cinema</strong> is not responsible for any personal injury, loss, or damage to property that occurs on the premises. Guests are responsible for their personal belongings. In the event of an incident, please notify our staff immediately, and we will address it promptly.</p>"
/// AboutUs : "<h2>About Apple Cinema</h2><p><strong>Apple Cinema</strong> is a unique fusion of cinema and dining, offering a one-of-a-kind experience where movie lovers can enjoy delicious meals in a luxurious theater setting. Founded in 2024, we strive to provide the highest quality of entertainment, food, and service.</p><h3>Our Mission</h3><p>At Apple Cinema, our mission is to create a memorable and immersive experience for all our guests. Whether you're here for a blockbuster movie, a romantic dinner, or a family-friendly outing, we aim to provide a comfortable and enjoyable environment with exceptional food and entertainment.</p><h3>Our Vision</h3><p>We envision a future where movie theaters are not just about watching films but offer a complete experience for all the senses. Apple Cinema aims to be the go-to destination for movie buffs and foodies alike, where guests can indulge in gourmet meals while enjoying their favorite movies on the big screen.</p><h3>What We Offer</h3><ul><li>Luxury theater seating with recliners and blankets for comfort.</li><li>Gourmet food and beverages, from handcrafted burgers to signature cocktails.</li><li>A wide selection of movie genres and special screenings, including 3D and IMAX films.</li><li>Private event hosting and group bookings for corporate outings, parties, and celebrations.</li></ul><h3>Our Core Values</h3><ul><li><strong>Quality:</strong> We never compromise on the quality of our food, beverages, or entertainment.</li><li><strong>Customer Satisfaction:</strong> Your experience is our top priority. We strive to exceed your expectations every time.</li><li><strong>Innovation:</strong> We're always looking for new ways to enhance your experience, from the latest technology to innovative culinary creations.</li><li><strong>Sustainability:</strong> We are committed to reducing our environmental footprint through eco-friendly practices and sustainable sourcing of ingredients.</li></ul>"
/// RestaurantIDF : "0d74bfa1-af7d-4182-835b-b815c2972591"
/// PaymentResponses : [{"RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","PaymentGatewayIDP":"4edd3f4b-0115-4706-8244-452612462b83","PaymentGatewaySettingIDP":"a31ea642-eae3-4361-b097-c4bf2d998c01","PaymentGatewayName":"Senang Pay","Description":"Senang Pay","PaymentGatewayLogo":"http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638678132549611074.png","PaymentGatewayNo":"1","MerchantID":"761173165749545","SecretKey":"43106-268","APIKey":"","URL":"","Configurations":""},{"RestaurantIDF":"0d74bfa1-af7d-4182-835b-b815c2972591","PaymentGatewayIDP":"6e9934ce-fe33-4c2d-9628-fae5475f3a25","PaymentGatewaySettingIDP":"3224d722-48f4-4c99-915b-81b19740b7c3","PaymentGatewayName":"Cash","Description":"Cash payment option","PaymentGatewayLogo":"http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638678102710393181.png","PaymentGatewayNo":"0","MerchantID":"","SecretKey":"","APIKey":"","URL":"","Configurations":""}]

class GetGeneralSettingData {
  GetGeneralSettingData({
    this.isPOSEnable,
    this.isAndroidEnable,
    this.isIOSEnable,
    this.androidAppVersion,
    this.iOSAppVersion,
    this.compulsoryUpdateIn,
    this.termsAndCondition,
    this.aboutUs,
    this.restaurantIDF,
    this.paymentResponses,});

  GetGeneralSettingData.fromJson(dynamic json) {
    isPOSEnable = json['IsPOSEnable'];
    isAndroidEnable = json['IsAndroidEnable'];
    isIOSEnable = json['IsIOSEnable'];
    androidAppVersion = json['AndroidAppVersion'];
    iOSAppVersion = json['IOSAppVersion'];
    compulsoryUpdateIn = json['CompulsoryUpdateIn'];
    termsAndCondition = json['TermsAndCondition'];
    aboutUs = json['AboutUs'];
    restaurantIDF = json['RestaurantIDF'];
    if (json['PaymentResponses'] != null) {
      paymentResponses = [];
      json['PaymentResponses'].forEach((v) {
        paymentResponses?.add(GeneralSettingPaymentResponses.fromJson(v));
      });
    }
  }
  bool? isPOSEnable;
  bool? isAndroidEnable;
  bool? isIOSEnable;
  String? androidAppVersion;
  String? iOSAppVersion;
  int? compulsoryUpdateIn;
  String? termsAndCondition;
  String? aboutUs;
  String? restaurantIDF;
  List<GeneralSettingPaymentResponses>? paymentResponses;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['IsPOSEnable'] = isPOSEnable;
    map['IsAndroidEnable'] = isAndroidEnable;
    map['IsIOSEnable'] = isIOSEnable;
    map['AndroidAppVersion'] = androidAppVersion;
    map['IOSAppVersion'] = iOSAppVersion;
    map['CompulsoryUpdateIn'] = compulsoryUpdateIn;
    map['TermsAndCondition'] = termsAndCondition;
    map['AboutUs'] = aboutUs;
    map['RestaurantIDF'] = restaurantIDF;
    if (paymentResponses != null) {
      map['PaymentResponses'] = paymentResponses?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// RestaurantIDF : "0d74bfa1-af7d-4182-835b-b815c2972591"
/// PaymentGatewayIDP : "4edd3f4b-0115-4706-8244-452612462b83"
/// PaymentGatewaySettingIDP : "a31ea642-eae3-4361-b097-c4bf2d998c01"
/// PaymentGatewayName : "Senang Pay"
/// Description : "Senang Pay"
/// PaymentGatewayLogo : "http://13.53.89.14:801/admin/Content/Images/Payment/PGM_638678132549611074.png"
/// PaymentGatewayNo : "1"
/// MerchantID : "761173165749545"
/// SecretKey : "43106-268"
/// APIKey : ""
/// URL : ""
/// Configurations : ""

class GeneralSettingPaymentResponses {
  GeneralSettingPaymentResponses({
    this.restaurantIDF,
    this.paymentGatewayIDP,
    this.paymentGatewaySettingIDP,
    this.paymentGatewayName,
    this.description,
    this.paymentGatewayLogo,
    this.paymentGatewayNo,
    this.merchantID,
    this.secretKey,
    this.aPIKey,
    this.url,
    this.configurations,});

  GeneralSettingPaymentResponses.fromJson(dynamic json) {
    restaurantIDF = json['RestaurantIDF'];
    paymentGatewayIDP = json['PaymentGatewayIDP'];
    paymentGatewaySettingIDP = json['PaymentGatewaySettingIDP'];
    paymentGatewayName = json['PaymentGatewayName'];
    description = json['Description'];
    paymentGatewayLogo = json['PaymentGatewayLogo'];
    paymentGatewayNo = json['PaymentGatewayNo'];
    merchantID = json['MerchantID'];
    secretKey = json['SecretKey'];
    aPIKey = json['APIKey'];
    url = json['URL'];
    configurations = json['Configurations'];
  }
  String? restaurantIDF;
  String? paymentGatewayIDP;
  String? paymentGatewaySettingIDP;
  String? paymentGatewayName;
  String? description;
  String? paymentGatewayLogo;
  String? paymentGatewayNo;
  String? merchantID;
  String? secretKey;
  String? aPIKey;
  String? url;
  String? configurations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['RestaurantIDF'] = restaurantIDF;
    map['PaymentGatewayIDP'] = paymentGatewayIDP;
    map['PaymentGatewaySettingIDP'] = paymentGatewaySettingIDP;
    map['PaymentGatewayName'] = paymentGatewayName;
    map['Description'] = description;
    map['PaymentGatewayLogo'] = paymentGatewayLogo;
    map['PaymentGatewayNo'] = paymentGatewayNo;
    map['MerchantID'] = merchantID;
    map['SecretKey'] = secretKey;
    map['APIKey'] = aPIKey;
    map['URL'] = url;
    map['Configurations'] = configurations;
    return map;
  }

}
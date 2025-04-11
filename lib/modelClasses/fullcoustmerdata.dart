class fullcoustmerdata {
  String? jsonrpc;
  Null? id;
  Result? result;

  fullcoustmerdata({this.jsonrpc, this.id, this.result});

  fullcoustmerdata.fromJson(Map<String, dynamic> json) {
    jsonrpc = json['jsonrpc'];
    id = json['id'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jsonrpc'] = this.jsonrpc;
    data['id'] = this.id;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  List<Records>? records;
  int? count;
  String? code;

  Result({this.records, this.count, this.code});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
    count = json['count'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['code'] = this.code;
    return data;
  }
}

class Records {
  int? id;
  String? agentName;
  String? agentLogin;
  String? unitName;
  String? date;
  String? time;
  String? familyHeadName;
  String? fatherName;
  String? motherName;
  String? spouseName;
  String? houseNumber;
  String? streetNumber;
  String? city;
  String? pinCode;
  String? address;
  String? mobileNumber;
  bool? eenaduNewspaper;
  String? feedbackToImproveEenaduPaper;
  bool? readNewspaper;
  String? currentNewspaper;
  String? reasonForNotTakingEenaduNewsPaper;
  String? reasonNotReading;
  bool? freeOffer15Days;
  String? reasonNotTakingOffer;
  bool? employed;
  String? jobType;
  bool? jobTypeOne;
  String? jobProfession;
  String? jobDesignation;
  String? companyName;
  String? profession;
  bool? jobWorkingState;
  bool? jobWorkingLocation;
  String? jobDesignationOne;
  String? latitude;
  String? longitude;
  bool? locationAddress;

  Records(
      {this.id,
      this.agentName,
      this.agentLogin,
      this.unitName,
      this.date,
      this.time,
      this.familyHeadName,
      this.fatherName,
      this.motherName,
      this.spouseName,
      this.houseNumber,
      this.streetNumber,
      this.city,
      this.pinCode,
      this.address,
      this.mobileNumber,
      this.eenaduNewspaper,
      this.feedbackToImproveEenaduPaper,
      this.readNewspaper,
      this.currentNewspaper,
      this.reasonForNotTakingEenaduNewsPaper,
      this.reasonNotReading,
      this.freeOffer15Days,
      this.reasonNotTakingOffer,
      this.employed,
      this.jobType,
      this.jobTypeOne,
      this.jobProfession,
      this.jobDesignation,
      this.companyName,
      this.profession,
      this.jobWorkingState,
      this.jobWorkingLocation,
      this.jobDesignationOne,
      this.latitude,
      this.longitude,
      this.locationAddress});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agentName = json['agent_name'];
    agentLogin = json['agent_login'];
    unitName = json['unit_name'];
    date = json['date'];
    time = json['time'];
    familyHeadName = json['family_head_name'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    spouseName = json['spouse_name'];
    houseNumber = json['house_number'];
    streetNumber = json['street_number'];
    city = json['city'];
    pinCode = json['pin_code'];
    address = json['address'];
    mobileNumber = json['mobile_number'];
    eenaduNewspaper = json['eenadu_newspaper'];
    feedbackToImproveEenaduPaper = json['feedback_to_improve_eenadu_paper'];
    readNewspaper = json['read_newspaper'];
    currentNewspaper = json['current_newspaper'];
    reasonForNotTakingEenaduNewsPaper =
        json['reason_for_not_taking_eenadu_newsPaper'];
    reasonNotReading = json['reason_not_reading'];
    freeOffer15Days = json['free_offer_15_days'];
    reasonNotTakingOffer = json['reason_not_taking_offer'];
    employed = json['employed'];
    jobType = json['job_type'];
    jobTypeOne = json['job_type_one'];
    jobProfession = json['job_profession'];
    jobDesignation = json['job_designation'];
    companyName = json['company_name'];
    profession = json['profession'];
    jobWorkingState = json['job_working_state'];
    jobWorkingLocation = json['job_working_location'];
    jobDesignationOne = json['job_designation_one'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    locationAddress = json['location_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agent_name'] = this.agentName;
    data['agent_login'] = this.agentLogin;
    data['unit_name'] = this.unitName;
    data['date'] = this.date;
    data['time'] = this.time;
    data['family_head_name'] = this.familyHeadName;
    data['father_name'] = this.fatherName;
    data['mother_name'] = this.motherName;
    data['spouse_name'] = this.spouseName;
    data['house_number'] = this.houseNumber;
    data['street_number'] = this.streetNumber;
    data['city'] = this.city;
    data['pin_code'] = this.pinCode;
    data['address'] = this.address;
    data['mobile_number'] = this.mobileNumber;
    data['eenadu_newspaper'] = this.eenaduNewspaper;
    data['feedback_to_improve_eenadu_paper'] =
        this.feedbackToImproveEenaduPaper;
    data['read_newspaper'] = this.readNewspaper;
    data['current_newspaper'] = this.currentNewspaper;
    data['reason_for_not_taking_eenadu_newsPaper'] =
        this.reasonForNotTakingEenaduNewsPaper;
    data['reason_not_reading'] = this.reasonNotReading;
    data['free_offer_15_days'] = this.freeOffer15Days;
    data['reason_not_taking_offer'] = this.reasonNotTakingOffer;
    data['employed'] = this.employed;
    data['job_type'] = this.jobType;
    data['job_type_one'] = this.jobTypeOne;
    data['job_profession'] = this.jobProfession;
    data['job_designation'] = this.jobDesignation;
    data['company_name'] = this.companyName;
    data['profession'] = this.profession;
    data['job_working_state'] = this.jobWorkingState;
    data['job_working_location'] = this.jobWorkingLocation;
    data['job_designation_one'] = this.jobDesignationOne;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location_address'] = this.locationAddress;
    return data;
  }
}
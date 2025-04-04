class Historymodel {
  final String jsonrpc;
  final dynamic id;
  final Result? result;

  Historymodel({
    required this.jsonrpc,
    required this.id,
    required this.result,
  });

  factory Historymodel.fromJson(Map<String, dynamic> json) {
    return Historymodel(
      jsonrpc: json['jsonrpc'] ?? '',
      id: json['id'],
      result:
          json['result'] != null ? Result.fromJson(json['result']) : null,
    );
  }
}

class Result {
  final List<SurveyRecord> records;
  final String code;

  Result({
    required this.records,
    required this.code,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      records: (json['records'] as List<dynamic>)
          .map((e) => SurveyRecord.fromJson(e))
          .toList(),
      code: json['code'] ?? '',
    );
  }
}

class SurveyRecord {
  final int id;
  final String agentName;
  final String agentLogin;
  final String unitName;
  final String date;
  final String time;
  final String familyHeadName;
  final String fatherName;
  final String motherName;
  final String spouseName;
  final String houseNumber;
  final String streetNumber;
  final String city;
  final String pinCode;
  final String address;
  final String mobileNumber;
  final bool eenaduNewspaper;
  final String feedbackToImproveEenaduPaper;
  final bool readNewspaper;
  final String currentNewspaper;
  final String reasonForNotTakingEenaduNewsPaper;
  final String reasonNotReading;
  final bool freeOffer15Days;
  final String reasonNotTakingOffer;
  final bool employed;
  final dynamic jobType;
  final dynamic jobTypeOne;
  final String jobProfession;
  final String jobDesignation;
  final String companyName;
  final String profession;
  final String jobDesignationOne;
  final String latitude;
  final String longitude;

  SurveyRecord({
    required this.id,
    required this.agentName,
    required this.agentLogin,
    required this.unitName,
    required this.date,
    required this.time,
    required this.familyHeadName,
    required this.fatherName,
    required this.motherName,
    required this.spouseName,
    required this.houseNumber,
    required this.streetNumber,
    required this.city,
    required this.pinCode,
    required this.address,
    required this.mobileNumber,
    required this.eenaduNewspaper,
    required this.feedbackToImproveEenaduPaper,
    required this.readNewspaper,
    required this.currentNewspaper,
    required this.reasonForNotTakingEenaduNewsPaper,
    required this.reasonNotReading,
    required this.freeOffer15Days,
    required this.reasonNotTakingOffer,
    required this.employed,
    this.jobType,
    this.jobTypeOne,
    required this.jobProfession,
    required this.jobDesignation,
    required this.companyName,
    required this.profession,
    required this.jobDesignationOne,
    required this.latitude,
    required this.longitude,
  });

  factory SurveyRecord.fromJson(Map<String, dynamic> json) {
    return SurveyRecord(
      id: json['id'],
      agentName: json['agent_name'] ?? '',
      agentLogin: json['agent_login'] ?? '',
      unitName: json['unit_name'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      familyHeadName: json['family_head_name'] ?? '',
      fatherName: json['father_name'] ?? '',
      motherName: json['mother_name'] ?? '',
      spouseName: json['spouse_name'] ?? '',
      houseNumber: json['house_number'] ?? '',
      streetNumber: json['street_number'] ?? '',
      city: json['city'] ?? '',
      pinCode: json['pin_code'] ?? '',
      address: json['address'] ?? '',
      mobileNumber: json['mobile_number'] ?? '',
      eenaduNewspaper: json['eenadu_newspaper'] ?? false,
      feedbackToImproveEenaduPaper:
          json['feedback_to_improve_eenadu_paper'] ?? '',
      readNewspaper: json['read_newspaper'] ?? false,
      currentNewspaper: json['current_newspaper'] ?? '',
      reasonForNotTakingEenaduNewsPaper:
          json['reason_for_not_taking_eenadu_newsPaper'] ?? '',
      reasonNotReading: json['reason_not_reading'] ?? '',
      freeOffer15Days: json['free_offer_15_days'] ?? false,
      reasonNotTakingOffer: json['reason_not_taking_offer'] ?? '',
      employed: json['employed'] ?? false,
      jobType: json['job_type'],
      jobTypeOne: json['job_type_one'],
      jobProfession: json['job_profession'] ?? '',
      jobDesignation: json['job_designation'] ?? '',
      companyName: json['company_name'] ?? '',
      profession: json['profession'] ?? '',
      jobDesignationOne: json['job_designation_one'] ?? '',
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
    );
  }
}
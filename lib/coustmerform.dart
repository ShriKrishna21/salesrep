import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salesrep/agent_dash_board_screen.dart';
import 'package:salesrep/coustmermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Coustmer extends StatefulWidget {
  const Coustmer({super.key});

  @override
  State<Coustmer> createState() => _CoustmerState();
}

class _CoustmerState extends State<Coustmer> {
  bool _isYes = false;
  bool _isAnotherToggle = false;
  bool _isofferTogle = false;
  bool _isemployed = false;
  int offerintresetedpeople = 0;
  int offernotintresetedpeople = 0;
  int offerintresetedpeoplecount = 0;
  int offernotintresetedpeoplecount = 0;
  int count = 0;
  int addcount = 0;

  final _formKey = GlobalKey<FormState>();

  TextEditingController agency = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();
  TextEditingController familyhead = TextEditingController();
  TextEditingController fathersname = TextEditingController();
  TextEditingController mothername = TextEditingController();
  TextEditingController spousename = TextEditingController();
  TextEditingController hno = TextEditingController();
  TextEditingController streetnumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController adddress = TextEditingController();

  TextEditingController mobile = TextEditingController();
  TextEditingController feedback_to_improve = TextEditingController();
  TextEditingController reason_for_not_reading = TextEditingController();
  TextEditingController current_newspaper = TextEditingController();
  TextEditingController reason_for_not_taking_eenadu = TextEditingController();
  TextEditingController reason_for_not_taking_offer = TextEditingController();

  // TextEditingController central_designation = TextEditingController();
  // TextEditingController central_department = TextEditingController();
  // TextEditingController psu_designation = TextEditingController();
  // TextEditingController psu_department = TextEditingController();
  // TextEditingController statejob_role = TextEditingController();
  // TextEditingController statejob_department = TextEditingController();

  TextEditingController job_designation_gov = TextEditingController();
  TextEditingController job_department_gov = TextEditingController();

  // Employment Dropdown Variables
  String? _selectedJobType;
  String? _selectedGovDepartment;
  TextEditingController privateCompanyController = TextEditingController();
  TextEditingController privatePositionController = TextEditingController();

  String agents = '';
  List<String> jobTypes = ["Government", "Private job"];
  List<String> govDepartments = [
    "Central job",
    "PSU",
    "State job",
  ];
  String? _selectedproffesion;
  List<String> proffesion = ["farmer", "doctor", "teacher", "lawyer", "Artist"];
  cousmerform? data ;

  @override
  void initState() {
    super.initState();
    // final SharedPreferences prefs = await SharedPreferences.getInstance();

    datecontroller.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    timecontroller.text = DateFormat('hh:mm a').format(DateTime.now());
    _loadSavedData();
  }

  void _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      agents = prefs.getString('unit') ?? '';
      agency.text = agents; // Set it in the controller too
    });
  }

  Future<void> uploaddata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? action = await prefs.getString('apikey');

    print("Rrddddddddddddddddddddd$action");

    try {
      const url = 'http://10.100.13.138:8099/api/customer_form';
      final responsee = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json', // Required for JSON-RPC requests
        },
        body: jsonEncode({
          'params': {
            "token": action.toString(),
            "agent_name": agents,
            // "agent_login": "johndoe",
            // "unit_name": "Sales Unit 1",
            "date": datecontroller.text,
            "time": timecontroller.text,
            "family_head_name": familyhead.text,
            "father_name": fathersname.text,
            "mother_name": mothername.text,
            "spouse_name": spousename.text,
            "house_number": hno.text,
            "street_number": streetnumber.text,
            "city": city.text,
            "pin_code": pincode.text,
            "address": adddress.text,
            "mobile_number": mobile.text,
            "eenadu_newspaper": _isYes,
            "feedback_to_improve_eenadu_paper": feedback_to_improve.text,
            "read_newspaper": _isAnotherToggle,
            "current_newspaper": current_newspaper.text,
            "reason_for_not_taking_eenadu_newsPaper":
                reason_for_not_taking_eenadu.text,
            "reason_not_reading": reason_for_not_reading.text,
            "free_offer_15_days": _isofferTogle,
            "reason_not_taking_offer": reason_for_not_taking_offer.text,
            "employed": _isemployed,
            "job_type": _selectedJobType,
            "job_type_one": _selectedGovDepartment,
            "job_profession": job_designation_gov.text,
            "job_designation": job_department_gov.text,
            "company_name": privateCompanyController.text,
            "profession": privatePositionController.text,
            // "job_designation_one": "Lead Developer",
            "latitude": "40.7128",
            "longitude": "-74.0060"
          }
        }),
      );
      if (responsee.statusCode == 200) {
        print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwww${responsee.statusCode}");
           final jsonResponse = jsonDecode(responsee.body) as Map<String, dynamic>;
           setState(() {
             data=cousmerform.fromJson(jsonResponse);
             print("ttttttttttttttttttttttttttttttttttt${data?.toJson().toString()}");
           });

        if (data?.result?.code == "200") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data added succesfully")),
          );
// Load current values from SharedPreferences
          int houseVisited = prefs.getInt("house_visited") ?? 0;
          int targetLeft = prefs.getInt("target_left") ?? 40;
          int alreadySubscribed = prefs.getInt("already_Subscribed") ?? 0;
          int offerAccepted = prefs.getInt("offer_Accepted") ?? 0;
          int offerRejected = prefs.getInt("offer_Rejected") ?? 0;
// Update values
          houseVisited += 1; //Increment House Visited
          targetLeft -= 1; //Decrease TargetLeft
// Update Report Fields Based On Form Input
          if (_isYes) {
            alreadySubscribed += 1; // Customer already subscribed to Eenadu
          } else if (_isofferTogle) {
            offerAccepted += 1; // Customer accepted 15-day offer
          } else {
            offerRejected += 1; // Customer rejected 15-day offer
          }
// Save updated values to SharedPreferences

          await prefs.setInt("house_visited", houseVisited);
          await prefs.setInt("target_left", targetLeft);
          await prefs.setInt("already_subscribed", alreadySubscribed);
          await prefs.setInt("offer_accepted", offerAccepted);
          await prefs.setInt("offer_rejected", offerRejected);
// Navigate back to AgentDashBoardScreen to reflect changes

          // print("${jsonResponse.toString()}");

          // print("2");
          // await prefs.setString('apikey', _loginData!.result!.apiKey.toString());
          // print("3");

          // final String? action = prefs.getString('apikey');
          // print(" API KEY => $action");
          // print("4444444444444444444444444444444$_loginData");
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Homescreen()),
          // );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Data  Not added ")),
          );
        }
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        title: const Text(
          "Customer Form",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textformfeild(
                    controller: agency, label: "Agency Name", need: true),
                const SizedBox(height: 20),

                // Date & Time Fields
                Row(
                  children: [
                    Expanded(
                        child: date(
                            needed: true,
                            Dcontroller: datecontroller,
                            date: "Date",
                            inputType: TextInputType.datetime)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: date(
                            needed: true,
                            Dcontroller: timecontroller,
                            date: "Time",
                            inputType: TextInputType.datetime)),
                  ],
                ),

                const SizedBox(height: 15),
                const Text("Family Details",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                textformfeild(
                    controller: familyhead, label: "Family Head Name"),
                const SizedBox(height: 10),
                textformfeild(controller: fathersname, label: "Father's Name"),
                const SizedBox(height: 10),
                textformfeild(controller: mothername, label: "Mother's Name"),
                const SizedBox(height: 10),
                textformfeild(controller: spousename, label: "Spouse Name"),
                const SizedBox(height: 10),

                const SizedBox(height: 15),
                const Text("Address Details",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: textformfeild(
                            controller: hno,
                            label: "House number",
                            keyboardType: TextInputType.text)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: textformfeild(
                            controller: streetnumber,
                            label: "street number",
                            keyboardType: TextInputType.number)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: textformfeild(
                            controller: city,
                            label: "city",
                            keyboardType: TextInputType.text)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: textformfeild(
                            maxvalue: 6,
                            controller: pincode,
                            textForCounter: "",
                            label: "pincode",
                            keyboardType: TextInputType.number)),
                  ],
                ),
                const SizedBox(height: 10),
                textformfeild(controller: adddress, label: "Address"),
                const SizedBox(height: 10),
                textformfeild(
                    controller: mobile,
                    maxvalue: 10,
                    label: "mobile number",
                    keyboardType: TextInputType.phone),

                const SizedBox(height: 15),
                const Text("Newspaper Details",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),

                // Eenadu Newspaper Toggle
                Row(
                  children: [
                    const Expanded(
                      child: Text("Eenadu Newspaper:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Text(_isYes ? "Yes" : "No",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _isYes ? Colors.green : Colors.red,
                        )),
                    Switch(
                      inactiveThumbColor: Colors.white,
                      activeTrackColor: Colors.green,
                      inactiveTrackColor: Colors.red,
                      value: _isYes,
                      onChanged: (value) {
                        setState(() {
                          _isYes = value;
                          // if (value) {
                          //   // _isAnotherToggle = false;
                          // }
                        });
                      },
                    ),
                  ],
                ),
                if (_isYes)
                  textformfeild(
                      controller: feedback_to_improve,
                      label: "Feedback to improve Eenadu"),

                if (!_isYes) ...[
                  Row(
                    children: [
                      const Expanded(
                        child: Text("Reads Newspaper:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      Text(_isAnotherToggle ? "Yes" : "No",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _isAnotherToggle ? Colors.green : Colors.red,
                          )),
                      Switch(
                        inactiveThumbColor: Colors.white,
                        activeTrackColor: Colors.green,
                        inactiveTrackColor: Colors.red,
                        value: _isAnotherToggle,
                        onChanged: (value) {
                          setState(() {
                            _isAnotherToggle = value;
                          });
                        },
                      ),
                    ],
                  ),
                  if (_isAnotherToggle)
                    textformfeild(
                        controller: current_newspaper,
                        label: "Current Newspaper"),
                  if (_isAnotherToggle)
                    textformfeild(
                        controller: reason_for_not_taking_eenadu,
                        label: "reason for not talking eenadu Newspaper"),
                  if (!_isAnotherToggle)
                    textformfeild(
                        controller: reason_for_not_reading,
                        label: "Reason for not Reading Newspaper"),
                  Row(
                    children: [
                      const Expanded(
                        child: Text("15 days  free Eenadu   offer:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      Text(_isofferTogle ? "Yes" : "No",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _isofferTogle ? Colors.green : Colors.red,
                          )),
                      Switch(
                        inactiveThumbColor: Colors.white,
                        activeTrackColor: Colors.green,
                        inactiveTrackColor: Colors.red,
                        value: _isofferTogle,
                        onChanged: (value) {
                          setState(() {
                            _isofferTogle = value;
                          });
                        },
                      ),
                    ],
                  ),
                  if (!_isofferTogle)
                    textformfeild(
                        controller: reason_for_not_taking_offer,
                        label: "reason for not taking offer"),
                  const SizedBox(
                    height: 15,
                  ),
                ],
                const SizedBox(
                  height: 15,
                ),

                // Employment Status Toggle
                Row(
                  children: [
                    const Expanded(
                      child: Text("Employed:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Text(_isemployed ? "Yes" : "No",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _isemployed ? Colors.green : Colors.red,
                        )),
                    Switch(
                      inactiveThumbColor: Colors.white,
                      activeTrackColor: Colors.green,
                      inactiveTrackColor: Colors.red,
                      value: _isemployed,
                      onChanged: (value) {
                        setState(() {
                          _isemployed = value;
                          _selectedJobType = null;
                          _selectedGovDepartment = null;
                          privateCompanyController.clear();
                          privatePositionController.clear();
                          _selectedproffesion = null;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),

                if (_isemployed)
                  DropdownButtonFormField<String>(
                    value: _selectedJobType,
                    hint: const Text("Select Job Type"),
                    isExpanded: true,
                    items: jobTypes.map((String job) {
                      return DropdownMenuItem<String>(
                        value: job,
                        child: Text(job),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedJobType = newValue;
                        _selectedGovDepartment = null;
                        privateCompanyController.clear();
                        privatePositionController.clear();
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Job Type",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),

                if (_selectedJobType == "Government") ...[
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: _selectedGovDepartment,
                    hint: const Text("Select Department"),
                    isExpanded: true,
                    items: govDepartments.map((String dept) {
                      return DropdownMenuItem<String>(
                        value: dept,
                        child: Text(dept),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedGovDepartment = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Government Department",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),

                  // Show additional fields based on selection
                  if (_selectedGovDepartment == "Central job") ...[
                    const SizedBox(
                      height: 10,
                    ),
                    textformfeild(
                        controller: job_designation_gov,
                        label: "Central Job Designation"),
                    const SizedBox(
                      height: 10,
                    ),
                    textformfeild(
                        controller: job_department_gov,
                        label: "Central Job Department"),
                  ],

                  if (_selectedGovDepartment == "PSU") ...[
                    const SizedBox(
                      height: 10,
                    ),
                    textformfeild(
                        controller: job_designation_gov,
                        label: "PSU Organization Name"),
                    const SizedBox(
                      height: 10,
                    ),
                    textformfeild(
                        controller: job_department_gov, label: "PSU Role"),
                  ],

                  if (_selectedGovDepartment == "State job") ...[
                    const SizedBox(
                      height: 10,
                    ),
                    textformfeild(
                        controller: job_designation_gov,
                        label: "State Job Role"),
                    const SizedBox(
                      height: 10,
                    ),
                    textformfeild(
                        controller: job_department_gov,
                        label: "State Job Department"),
                  ],
                ],

// Private job details

                if (_selectedJobType == "Private job") ...[
                  const SizedBox(
                    height: 10,
                  ),
                  textformfeild(
                      controller: privateCompanyController,
                      label: "Company Name"),
                  const SizedBox(height: 10),
                  textformfeild(
                      controller: privatePositionController, label: "Position"),
                ],

// If NOT employed, show Profession Dropdown
                if (!_isemployed)
                  DropdownButtonFormField<String>(
                    value: _selectedproffesion,
                    hint: const Text("Select Profession"),
                    isExpanded: true,
                    items: proffesion.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedproffesion = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: "Profession",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                Center(
                  child: GestureDetector(
              onTap: () async => {
                 if (_formKey.currentState?.validate() ?? false) {
                        await uploaddata(),
                      }
                
                
              },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                    
                        borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                      
                      height: MediaQuery.of(context).size.height/18,
                      width:MediaQuery.of(context).size.height/5,
                      child: Center(child: Text("Submit Form",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.height/45),)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
    //  ElevatedButton(
    //                 onPressed: () async {
                     
    //                 },
    //                 child: const Center(
    //                     child: Text(
    //                   "submit Form",
    //                   style:
    //                       TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    //                 )))

SizedBox date(
    {required TextEditingController Dcontroller,
    required String date,
    needed = false,
    required TextInputType inputType}) {
  return SizedBox(
    height: 50,
    width: 180,
    child: TextFormField(
      keyboardType: inputType,
      controller: Dcontroller,
      readOnly: needed,
      decoration: InputDecoration(
          labelText: date,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black, width: 4))),
    ),
  );
}

SizedBox address({
  required TextEditingController address,
  String? add,
  required TextInputType keyboardType,
}) {
  return SizedBox(
    height: 50,
    // width: 180,
    child: TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Username cannot be empty";
        }
        return null;
      },
      controller: address,
      // readOnly: true,
      decoration: InputDecoration(
          labelText: add,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black, width: 4))),
    ),
  );
}

SizedBox textformfeild(
    {required TextEditingController controller,
    required String label,
    String? textForCounter,
    int? maxvalue,
    need = false,
    keyboardType = TextInputType.text}) {
  return SizedBox(
    height: label == "mobile number" ? 85 : 70,
    width: double.infinity,
    child: TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Username cannot be empty";
        }
        return null;
      },
      readOnly: need,
      keyboardType: keyboardType,
      controller: controller,
      maxLength: maxvalue,
      decoration: InputDecoration(
          counterText: textForCounter,
          labelText: label,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.black, width: 4))),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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


     TextEditingController central_designation = TextEditingController();
        TextEditingController central_department = TextEditingController();
         TextEditingController psu_designation = TextEditingController();
        TextEditingController psu_department = TextEditingController();
        TextEditingController statejob_role = TextEditingController();
        TextEditingController statejob_department = TextEditingController();
        
  
  

  // Employment Dropdown Variables
  String? _selectedJobType;
  String? _selectedGovDepartment;
  TextEditingController privateCompanyController = TextEditingController();
  TextEditingController privatePositionController = TextEditingController();

  List<String> jobTypes = ["Government", "Private job"];
  List<String> govDepartments = [
    "Central job",
    "PSU",
    "State job",
  ];
  String? _selectedproffesion;
  List<String> proffesion = ["farmer", "doctor", "teacher", "lawyer", "Artist"];

  @override
  void initState() {
    super.initState();
    datecontroller.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    timecontroller.text = DateFormat('HH:mm:ss').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Customer Form",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
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
                textformfeild(controller: agency, label: "Agency Name"),
                const SizedBox(height: 20),

                // Date & Time Fields
                Row(
                  children: [
                    Expanded(
                        child: date(
                            Dcontroller: datecontroller,
                            date: "Date",
                            inputType: TextInputType.datetime)),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: date(
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
                            controller: streetnumber,
                            label: "pincode",
                            keyboardType: TextInputType.number)),
                  ],
                ),
                const SizedBox(height: 10),
                textformfeild(controller: adddress, label: "Address"),
                const SizedBox(height: 10),
                textformfeild(
                    controller: mobile,
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
                            
                    Expanded(
                      child: Text(_isYes ? "Yes" : "No",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                             color: _isYes ? Colors.green : Colors.red,)),
                    ),
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
                      Expanded(
                        child: Text(_isAnotherToggle ? "Yes" : "No",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                             color:  _isAnotherToggle ? Colors.green : Colors.red,)),
                      ),
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
                        controller: current_newspaper, label: "Current Newspaper"),
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
                        style:TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _isofferTogle ? Colors.green : Colors.red,)),
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
                if(!_isofferTogle)
                textformfeild(controller:reason_for_not_taking_offer , label: "reason for not taking offer"),
                 const SizedBox(height: 15,),
                ],
                const SizedBox(height: 15,),
              

                // Employment Status Toggle
                Row(
                  children: [
                    const Expanded(
                      child: Text("Employed:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: Text(_isemployed ? "Yes" : "No",
                          style:  TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                             color: _isemployed ? Colors.green : Colors.red,)),
                    ),
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
                 const SizedBox(height: 15,),


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
                  const SizedBox(height: 20,),
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
                     const SizedBox(height: 10,),
                    textformfeild(
                        controller: central_designation,
                        label: "Central Job Designation"),
                        const SizedBox(height: 10,),
                    textformfeild(
                        controller: central_designation,
                        label: "Central Job Department"),
                  ],

                  if (_selectedGovDepartment == "PSU") ...[
                     const SizedBox(height: 10,),
                    textformfeild(
                        controller: psu_department,
                        label: "PSU Organization Name"),
                        const SizedBox(height: 10,),
                    textformfeild(
                        controller: psu_designation, label: "PSU Role"),
                  ],

                  if (_selectedGovDepartment == "State job") ...[
                     const SizedBox(height: 10,),
                    textformfeild(
                        controller: statejob_role,
                        label: "State Job Role"),
                         const SizedBox(height: 10,),
                    textformfeild(
                        controller: statejob_department,
                        label: "State Job Department"),
                  ],
                ],

// Private job details

                if (_selectedJobType == "Private job") ...[
                  const SizedBox(height: 10,),
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

                  TextButton(onPressed: (){

                  }, child: const Center(child: Text("submit Form",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

SizedBox date(
    {required TextEditingController Dcontroller,
    required String date,
    required TextInputType inputType}) {
  return SizedBox(
    height: 50,
    width: 180,
    child: TextFormField(
      keyboardType: inputType,

      controller: Dcontroller,
      // readOnly: true,
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
    keyboardType = TextInputType.text}) {
  return SizedBox(
    height: 50,
    width: double.infinity,
    child: TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
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

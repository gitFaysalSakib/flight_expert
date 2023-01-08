import 'package:flight_expart/service/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator_platform_interface/geolocator_platform_interface.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/cupertino.dart';
import 'package:flight_expart/service/location_dialog.dart';
import 'package:faker/faker.dart';




import '../service/location_name.dart';
import '../service/location_dialog.dart';

class FlightExpert extends StatefulWidget {
  const FlightExpert({Key? key}) : super(key: key);

  @override
  State<FlightExpert> createState() => _FlightExpertState();
}

class _FlightExpertState extends State<FlightExpert>
    with TickerProviderStateMixin {
   late GoogleMapController _mapController;
  //late LocationController _locationController;


  late final TextEditingController _controller;
  final LocationController _locationController = Get.put(LocationController());


  late String? ddd =  _locationController.pickPlaceMark.name ;

  //final fakeUserList = List.generate(10, (index) => User(name: Faker().person.name() ),);


  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();


    // _locationController = LocationController();
    // _controller = ddd as TextEditingController;
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    final maxLines = 3;

    return Scaffold(

      appBar: AppBar(
        title: Text(
          'flight expert',
          style: TextStyle(color: Colors.red, fontSize: 30),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          ElevatedButton(
            child: Text(
              "Sign In",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              // padding: const EdgeInsets.only(right: 5.0, top: 10),
            ),
            onPressed: () {
              // Navigator.of(context)
              //     .pushReplacementNamed(SignupScreen.routeName);
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body:
      Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
                  child: Text(
                    "it's more then just a trip",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Nunito',
                      fontSize: 30.0,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Card(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      controller: tabController,
                      isScrollable: true,
                      labelPadding: EdgeInsets.symmetric(horizontal: 30),
                      tabs: [
                        Tab(
                          child: Text(
                            "Flight",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 30),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Hotel",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 30),
                          ),
                        ),
                        // SizedBox(width: 5,),

                        Tab(
                          child: Text(
                            "Visa",
                            style:
                                TextStyle(color: Colors.black45, fontSize: 25),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                RowOfRadioButton(),
                SizedBox(
                  height: 30,
                ),

                Container(
                 padding: EdgeInsets.symmetric(horizontal: 15),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  child: SizedBox(
                    child: TypeAheadField<LocationName?>(
                      suggestionsCallback: LocationNameApi.getLocationSuggestions,
                      itemBuilder:(context, LocationName? suggestion){

                        final location = suggestion!;
                         print(location.location);
                        return ListTile(
                          title: Text(location.location),
                        );


                      } ,
                      onSuggestionSelected:(LocationName? suggestion){
                        // final location = suggestion!;
                        // ScaffoldMessenger.of(context)
                        // ..removeCurrentSnackBar()
                        // ..showSnackBar(SnackBar(content: Text("select Location: ${location.location}"),
                        // ));

                      } ,
                    ),
                  ),


                ),





                // Container(
                //  padding: EdgeInsets.symmetric(horizontal: 15),
                //
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height,
                //   //alignment: Alignment.center,
                //
                //   child: SizedBox(
                //     child: TypeAheadField(
                //
                //       textFieldConfiguration: TextFieldConfiguration(
                //         controller: _controller,
                //         textInputAction: TextInputAction.search,
                //         autofocus: true,
                //         textCapitalization: TextCapitalization.words,
                //         keyboardType: TextInputType.streetAddress,
                //         decoration: InputDecoration(
                //           hintText: 'search_location',
                //           border: OutlineInputBorder(
                //             borderRadius: BorderRadius.circular(10),
                //             borderSide: BorderSide(style: BorderStyle.none, width: 0),
                //
                //           ),
                //            hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                //              fontSize: 16, color: Theme.of(context).disabledColor,
                //            ),
                //           filled: true, fillColor: Theme.of(context).cardColor,
                //         ),
                //         style: Theme.of(context).textTheme.headline2?.copyWith(
                //           color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 20,
                //         ),
                //       ),
                //       suggestionsCallback: ( pattern)async {
                //         return await Get.find<LocationController>().searchLocation(context, pattern);
                //
                //       },
                //       itemBuilder:(context, Prediction suggestion){
                //         return Padding(
                //           padding: EdgeInsets.all(10),
                //           child: Row(children: [
                //             Icon(Icons.location_on),
                //             Expanded(
                //               child: Text(suggestion.description!, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headline2?.copyWith(
                //                 color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 20,
                //               )),
                //             ),
                //           ]),
                //         );
                //
                //       },
                //       onSuggestionSelected: (Predition suggestion) {
                //         Get.back();
                //
                //       },
                //
                //     ),

                //     // child: TextField(
                //     //   controller: _controller,
                //     //
                //     //   maxLines: maxLines,
                //     //
                //     //   onTap: () async {
                //     //     // placeholder for our places search later
                //     //   },
                //     //   decoration: InputDecoration(
                //     //     labelText: "From",
                //     //     labelStyle: TextStyle(fontSize: 30),
                //     //     floatingLabelBehavior: FloatingLabelBehavior.always,
                //     //     isDense: true,                      // Added this
                //     //     border: OutlineInputBorder(
                //     //       borderRadius: BorderRadius.circular(10),
                //     //
                //     //
                //     //     ),
                //     //     // icon: Container(
                //     //     //   margin: EdgeInsets.only(left: 20),
                //     //     //   width: 10,
                //     //     //   height: 10,
                //     //     //   // child: Icon(
                //     //     //   //   Icons.home,
                //     //     //   //   color: Colors.black,
                //     //     //   // ),
                //     //     // ),
                //     //    // hintText: "From",
                //     //    //  border: InputBorder.none,
                //     //    //  contentPadding: EdgeInsets.only(left: 8.0, top: 16.0),
                //     //   ),
                //     //
                //     //
                //     // ),
                //   ),
                // )

                // Positioned(
                //     top: 200,
                //     // left: 10,
                //     // right: 20,
                //     child: GestureDetector(
                //       onTap: () => Get.dialog(LocationSearchDialog(mapController: _mapController)
                //       ),
                //       child: Container(
                //         height: 50,
                //         decoration: BoxDecoration(color: Theme.of(context).cardColor,
                //             borderRadius: BorderRadius.circular(10)),
                //         child: Row(children: [
                //           SizedBox(width: 10,),
                //
                //           Icon(Icons.location_on, size: 25, color: Theme.of(context).primaryColor),
                //           SizedBox(width: 10,),
                //           Expanded(child: Text('${locationController.pickPlaceMark.name ?? ''}',
                //             style: TextStyle(fontSize: 20),
                //             maxLines: 1, overflow: TextOverflow.ellipsis,
                //           ),
                //           ),
                //           // SizedBox(width: 10),
                //           // Icon(Icons.search, size: 25, color: Theme.of(context).textTheme.bodyText1!.color),
                //
                //
                //         ],
                //         ),
                //       ),
                //      )
                //  ),




                //..............
                // Container(
                //   //top: 200,
                //     child: GestureDetector(
                //       onTap: () {
                //         print('fdfgggg');
                //       },
                //       child: Container(
                //
                //         // child: Row(children: [
                //         //   Icon(Icons.location_on, size: 25, color: Theme.of(context).primaryColor),
                //         //   SizedBox(width: 15),
                //         //
                //         //   Expanded(child: Text('${_locationController.pickPlaceMark.name}',
                //         //     style: TextStyle(fontSize: 20),
                //         //     maxLines: 1, overflow: TextOverflow.ellipsis,
                //         //
                //         //   ),
                //         //   ),
                //         //
                //         // ],),
                //       ),
                //     )
                // )
                //.........



              ],


            ),

          ),



          //SizedBox(height: 10,),

          // Expanded(child: Text("hi"),
          // //     child: TabBarView(
          // //   controller: tabController,
          // //   children: [
          // //     ListView.builder(
          // //         itemCount: 5,
          // //         physics: BouncingScrollPhysics(),
          // //         shrinkWrap: true,
          // //         itemBuilder: (context, index) {
          // //           return Card(
          // //             margin:
          // //                 EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          // //             // child: ListTile(
          // //             //   // leading: Icon(
          // //             //   //   Icons.call,
          // //             //   //   color: Colors.red,
          // //             //   // ),
          // //             //   // title: Text("Person${index + 1}"),
          // //             //   // subtitle: Text("miss cal ${index + 1}"),
          // //             //   // trailing: Icon(
          // //             //   //   Icons.phone,
          // //             //   //   color: Colors.green,
          // //             //   // ),
          // //             // ),
          // //           );
          // //         }),
          // //     ListView.builder(
          // //         itemCount: 5,
          // //         physics: BouncingScrollPhysics(),
          // //         shrinkWrap: true,
          // //         itemBuilder: (context, index) {
          // //           return Card(
          // //             margin:
          // //                 EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          // //             // child: ListTile(
          // //             //   leading: Icon(
          // //             //     Icons.call,
          // //             //     color: Colors.red,
          // //             //   ),
          // //             //   title: Text("Person${index + 1}"),
          // //             //   subtitle: Text("miss cal ${index + 1}"),
          // //             //   trailing: Icon(
          // //             //     Icons.phone,
          // //             //     color: Colors.green,
          // //             //   ),
          // //             // ),
          // //           );
          // //         }),
          // //     ListView.builder(
          // //         itemCount: 5,
          // //         physics: BouncingScrollPhysics(),
          // //         shrinkWrap: true,
          // //         itemBuilder: (context, index) {
          // //           return Card(
          // //             margin:
          // //                 EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          // //             // child: ListTile(
          // //             //   leading: Icon(
          // //             //     Icons.call,
          // //             //     color: Colors.red,
          // //             //   ),
          // //             //   title: Text("Person${index + 1}"),
          // //             //   subtitle: Text("miss cal ${index + 1}"),
          // //             //   trailing: Icon(
          // //             //     Icons.phone,
          // //             //     color: Colors.green,
          // //             //   ),
          // //             // ),
          // //           );
          // //         })
          // //   ],
          // // )
          // ),

          // Padding(
          //   padding: const EdgeInsets.all(1),
          //   child: TabberCustom(),
          //   // child: Row(
          //   //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   //   children: <Widget>[
          //   //     Container(
          //   //
          //   //     )
          //   //
          //   //     // Container(
          //   //     //   decoration: BoxDecoration(
          //   //     //     color: Colors.orange[50],
          //   //     //     borderRadius: BorderRadius.circular(10.0),
          //   //     //   ),
          //   //     //   child: Padding(
          //   //     //     padding: const EdgeInsets.all(25),
          //   //     //     child: Text("Flight", style: TextStyle(
          //   //     //       color: Colors.redAccent,
          //   //     //       fontWeight: FontWeight.bold,
          //   //     //       fontFamily: 'Nunito',
          //   //     //       fontSize: 18.0,
          //   //     //     ),
          //   //     //
          //   //     //     ),
          //   //     //
          //   //     //   ),
          //   //     // ),
          //   //     // Spacer(),
          //   //
          //   //     // Container(
          //   //     //   decoration: BoxDecoration(
          //   //     //     color: Colors.orange[50],
          //   //     //     borderRadius: BorderRadius.circular(10.0),
          //   //     //   ),
          //   //     //   child: Padding(
          //   //     //     padding: const EdgeInsets.all(25),
          //   //     //     child: Text("Flight", style: TextStyle(
          //   //     //       color: Colors.redAccent,
          //   //     //       fontWeight: FontWeight.bold,
          //   //     //       fontFamily: 'Nunito',
          //   //     //       fontSize: 18.0,
          //   //     //     ),
          //   //     //     ),
          //   //     //   ),
          //   //     // ),
          //   //     // Spacer(),
          //   //
          //   //     // Container(
          //   //     //   decoration: BoxDecoration(
          //   //     //     color: Colors.orange[50],
          //   //     //     borderRadius: BorderRadius.circular(10.0),
          //   //     //   ),
          //   //     //   child: Padding(
          //   //     //     padding: const EdgeInsets.all(25),
          //   //     //     child: Text("Flight", style: TextStyle(
          //   //     //       color: Colors.redAccent,
          //   //     //       fontWeight: FontWeight.bold,
          //   //     //       fontFamily: 'Nunito',
          //   //     //       fontSize: 18.0,
          //   //     //     ),
          //   //     //     ),
          //   //     //   ),
          //   //     // ),
          //   //     // Spacer(),
          //   //
          //   //     // Container(
          //   //     //   decoration: BoxDecoration(
          //   //     //     color: Colors.orange[50],
          //   //     //     borderRadius: BorderRadius.circular(20.0),
          //   //     //   ),
          //   //     //   child: Padding(
          //   //     //     padding: const EdgeInsets.only(left: 10.0, right: 60.0, top: 25.0, bottom: 25.0),
          //   //     //     child: Text("Hotel", style: TextStyle(
          //   //     //       color: Colors.redAccent,
          //   //     //       fontWeight: FontWeight.bold,
          //   //     //       fontFamily: 'Nunito',
          //   //     //       fontSize: 18.0,
          //   //     //     ),
          //   //     //     ),
          //   //     //   ),
          //   //     // ),
          //   //    // Spacer(),
          //   //     // Container(
          //   //     //   decoration: BoxDecoration(
          //   //     //     color: Colors.orange[50],
          //   //     //    // border: Border.all(color: Colors.grey),
          //   //     //       borderRadius: BorderRadius.circular(20.0),
          //   //     //   ),
          //   //     //   child: Padding(
          //   //     //     padding: const EdgeInsets.only(left: 60.0, right: 60.0, top: 25.0, bottom: 25.0),
          //   //     //     child: Text("Flights", style: TextStyle(
          //   //     //       color: Colors.black,
          //   //     //       fontWeight: FontWeight.bold,
          //   //     //       fontFamily: 'Nunito',
          //   //     //       fontSize: 18.0,
          //   //     //     ),
          //   //     //     ),
          //   //     //   ),
          //   //     // ),
          //   //   ],
          //   // ),
          // ),
//.....................
//           Padding(
//             padding: const EdgeInsets.only(top: 30.0, left: 25.0, right: 25.0),
//             child: Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Container(
//                         decoration : BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0),
//                           color: Colors.lightBlue.withOpacity(0.3),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: Icon(Icons.location_on, color: Colors.lightBlue,),
//                         ),
//                       ),
//                       SizedBox(width: 20.0,),
//                       Text("Where", style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 20.0,
//                       ),)
//                     ],
//                   ),
//
//                   SizedBox(height: 10.0,),
//                   Divider(
//                     thickness: 1.0,
//                   ),
//                   SizedBox(height: 10.0,),
//
//                   Row(
//                     children: <Widget>[
//                       Container(
//                         decoration : BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0),
//                           color: Colors.lightBlue.withOpacity(0.3),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: Icon(Icons.date_range, color: Colors.lightBlue,),
//                         ),
//                       ),
//                       SizedBox(width: 20.0,),
//                       Text("Check in - Check out", style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 20.0,
//                       ),)
//                     ],
//                   ),
//
//                   SizedBox(height: 10.0,),
//                   Divider(
//                     thickness: 1.0,
//                   ),
//                   SizedBox(height: 10.0,),
//
//                   Row(
//                     children: <Widget>[
//                       Container(
//                         decoration : BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0),
//                           color: Colors.lightBlue.withOpacity(0.3),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: Icon(Icons.person, color: Colors.lightBlue,),
//                         ),
//                       ),
//                       SizedBox(width: 20.0,),
//                       Text("1 Adult, 0 Children, 1 Room", style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 20.0,
//                       ),)
//                     ],
//                   ),
//
//                   SizedBox(height: 10.0,),
//                   Divider(
//                     thickness: 1.0,
//                   ),
//                   SizedBox(height: 10.0,),
//
//                   Container(
//                     width: 360.0,
//                     decoration: BoxDecoration(
//                         color: Colors.lightBlue,
//                         borderRadius: BorderRadius.circular(20.0)
//                     ),
//                     child: Center(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
//                         child: Text("Search", style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20.0,
//                             fontWeight: FontWeight.bold
//                         ),
//                         ),
//                       ),
//                     ),
//                   )
//
//                 ],
//               ),
//             ),
//           ),

          // SizedBox(height: 25.0,),

          // Padding(
          //   padding: const EdgeInsets.only(left:25.0, right: 25.0),
          //   child: Text("Popular places", style: TextStyle(
          //       fontWeight: FontWeight.bold,
          //       color: Colors.black,
          //       fontFamily: 'Nunito',
          //       letterSpacing: 0.5,
          //       fontSize: 24.0
          //   ),),
          // ),

          // SizedBox(height: 20.0,),

          // Padding(
          //   padding: const EdgeInsets.only(left:25.0, right: 25.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Image.asset("assets/amsterdam.png", height: 100.0, width: 100.0,),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Text("Amsterdam", style: TextStyle(
          //               color: Colors.black,
          //               fontWeight: FontWeight.bold,
          //               fontFamily: 'Nunito'
          //           ),
          //           ),
          //           SizedBox(height: 5.0,),
          //           Text("12,203 properties", style: TextStyle(
          //               color: Colors.grey,
          //               fontWeight: FontWeight.bold
          //           ),)
          //         ],
          //       ),
          //       Container(
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(20.0),
          //           color: Colors.grey.withOpacity(0.4),
          //         ),
          //         child: Padding(
          //           padding: const EdgeInsets.all(15.0),
          //           child: Icon(Icons.arrow_forward, color: Colors.black,),
          //         ),
          //       )
          //
          //     ],
          //   ),
          // ),

          // SizedBox(height: 20.0,),

          // Padding(
          //   padding: const EdgeInsets.only(left:25.0, right: 25.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Image.asset("assets/paris.png", height: 100.0, width: 100.0,),
          //       Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: <Widget>[
          //           Text("Eiffel Tower, Paris", style: TextStyle(
          //               color: Colors.black,
          //               fontWeight: FontWeight.bold,
          //               fontFamily: 'Nunito'
          //           ),
          //           ),
          //           SizedBox(height: 5.0,),
          //           Text("15, 475 properties", style: TextStyle(
          //               color: Colors.grey,
          //               fontWeight: FontWeight.bold
          //           ),)
          //         ],
          //       ),
          //       InkWell(
          //         onTap: (){
          //           // Navigator.push(
          //           //   context,
          //           //   MaterialPageRoute(builder: (context) => Second()),
          //           // );
          //         },
          //         child: Container(
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(20.0),
          //             color: Colors.grey.withOpacity(0.4),
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.all(15.0),
          //             child: Icon(Icons.arrow_forward, color: Colors.black,),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // SizedBox(height: 20.0,),
        ],
      ),
    );
  }

  String groupValue1 = '';

  Widget RowOfRadioButton() {
    return Row(
      children: <Widget>[
        Radio(
            value: 'One Way',
            groupValue: groupValue1,
            activeColor: Colors.red,
            onChanged: (value) {
              setState(() {
                groupValue1 = value.toString();
                print(groupValue1);
                // storeBookedData2.duration =groupValue1;
                // print(storeBookedData2.duration);
              });
            }),
        Text(
          'One Way',
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10,
        ),

        Radio(
            value: 'Round Trip',
            activeColor: Colors.red,
            groupValue: groupValue1,
            onChanged: (value) {
              setState(() {
                groupValue1 = value.toString();
                print(groupValue1);
                // storeBookedData2.duration =groupValue1;
                // print(storeBookedData2.duration);
              });
            }),
        Text(
          'Round Trip',
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),

        SizedBox(
          width: 10,
        ),

        //
        Radio(
            value: 'Multi City',
            activeColor: Colors.red,
            groupValue: groupValue1,
            onChanged: (value) {
              setState(() {
                groupValue1 = value.toString();
                print(groupValue1);
              });
            }),
        Text(
          'Multi City',
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}

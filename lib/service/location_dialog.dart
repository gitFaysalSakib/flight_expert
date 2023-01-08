import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import 'location_controller.dart';

class LocationSearchDialog extends StatelessWidget {
  final GoogleMapController? mapController;
  const LocationSearchDialog({required this.mapController});
  
  void n( String e){
    print(e);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    // return Container(
    //   margin: EdgeInsets.only(top : 150),
    //   padding: EdgeInsets.all(5),
    //   alignment: Alignment.topCenter,
    //   child: Material(
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(5)),
    //     child: SizedBox(
    //       width: 100,child:
    //     TypeAheadField(
    //       textFieldConfiguration: TextFieldConfiguration(
    //         controller: _controller,
    //         textInputAction: TextInputAction.search,
    //         autofocus: true,
    //         textCapitalization: TextCapitalization.words,
    //         keyboardType: TextInputType.streetAddress,
    //         decoration: InputDecoration(
    //           hintText: 'search_location',
    //
    //
    //         )
    //
    //
    //       ),
    //       suggestionsCallback: (String pattern) async{
    //         return await Get.find<LocationController>().searchLocation(context, pattern);
    //
    //       },
    //       itemBuilder: (context, Prediction suggestion) {
    //         return Padding(padding: EdgeInsets.all(10),
    //           child: Row(
    //             children: [
    //               Icon(Icons.location_on),
    //               Expanded( child: Text(suggestion.description!, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headline2?.copyWith(
    //                 color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 20,
    //               )
    //               )
    //               )
    //
    //             ],
    //           ),
    //
    //         );
    //
    //       },
    //       onSuggestionSelected: (Prediction suggestion) {
    //         print("My location is "+suggestion.description!);
    //         Get.back();
    //
    //
    //       },
    //     ),),
    //
    //   ),
    // );

    return Container(
      child: Material(
        child: SizedBox(
          width: 350,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                hintText: 'search_location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(style: BorderStyle.none, width: 0),
                ),

              )



            ),
            suggestionsCallback: (String pattern) async {
              return await Get.find<LocationController>().searchLocation(context, pattern);


              pattern = "dfff";
              print('hhhhh');
            },
            itemBuilder: (context, Prediction suggestion) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: Row(children: [
                  Icon(Icons.location_on),
                  Expanded(
                    child: Text(suggestion.description!, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 20,
                    )),
                  ),
                ]),
              );
            },
            onSuggestionSelected: (Object? suggestion) {  },

          ),

        ),

      ),

    );

  }
}

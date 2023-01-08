import 'package:http/http.dart' as http;
import 'dart:convert';
class LocationName{
  late String location;

  LocationName({
    required this.location,
}
);

  static LocationName fromJeson(Map<String, dynamic> json ) => LocationName(
    location: json['name'],
  );

}

class LocationNameApi{
  static Future<List<LocationName>> getLocationSuggestions(String query) async{
    final url = Uri.parse("https://jsonplaceholder.typicode.com/users");
    final response = await http.get(url);

    if(response.statusCode==200){
      final List locations = json.decode(response.body);
      // print(locations);
      return locations.map((json)=> LocationName.fromJeson(json)).where((location){
        final locationLower = location.location.toLowerCase();
       // print(locationLower);

        final queryLower = query.toLowerCase();
     // print(queryLower);


        return locationLower.contains(queryLower);


      }
      )
          .toList();

    }else{
      throw Exception();
    }


  }
}
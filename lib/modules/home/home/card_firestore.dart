import 'package:excursion/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:excursion/utils/services/firestore.dart';
import 'package:excursion/modules/home/home/screens/detail_place.dart';

class CardFirestore extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: firestoreService.getAllCollection(nameCollection: 'places_cololmbia'),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Center(child: Text('Something went wrong: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Loading data...');
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('No data found');
          return Center(child: Text('No data found'));
        }

        final data = snapshot.data!;
        print('Data received: ${data.length} items');

        return

           Container(
            child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
            var place = data[index];
            print('Building item $index: ${place['name']}');
            
              return
              GestureDetector(
               onTap: () {
                Navigator.push(
                context,
              MaterialPageRoute(
                builder: (context) => PlaceDetailsScreen(place: place),
                    ),
                  );
              },

              
                child :Card(
                  
                child: Column(
                  children: [
                    place['img'] != null
                        ? Image.network(
                      place['img'],
                      width: double.infinity, // Use double.infinity to make the image as wide as the Card
                      height: 200, // Adjust the height as needed
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                    )
                        : Icon(Icons.image_not_supported),
                    ListTile(
                      title: Text(place['name'] ?? 'Unknown'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${AppText.department}: ${place['Department'] ?? 'N/A'}'),
                          Text('${AppText.description}: ${place['Description'] ?? 'N/A'}'),
                          place['Location'] != null && place['Location'].latitude != null && place['Location'].longitude != null
                              ? Text('${AppText.location}: ${place['Location'].latitude}, ${place['Location'].longitude}')
                              : Text('${AppText.location}: N/A'),
                          Text('${AppText.rating}: ${place['Rating'] ?? 'N/A'}'),
                          Text('${AppText.weather}: ${place['Weather'] ?? 'N/A'}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              );
            },
                    ),
          );
      },
    );
  }
}

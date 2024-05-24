import 'package:excursion/utils/constants/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> place;

  PlaceDetailsScreen({required this.place});

  @override
  Widget build(BuildContext context) {
    return

      Container(
        child: Scaffold(
        appBar: AppBar(
          title: Text(place['name'] ?? 'Unknown'),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              place['img'] != null
                  ? Image.network(
                place['img'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
              )
                  : Icon(Icons.image_not_supported),
              SizedBox(height: 16.0),
              Text('${AppText.name}: ${place['name'] ?? 'Unknown'}'),
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
            ),
      );
  }
}
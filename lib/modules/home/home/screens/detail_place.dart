import 'package:excursion/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> place;

  PlaceDetailsScreen({required this.place});

  @override
  _PlaceDetailsScreenState createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  double _userRating = 0.0;
  double _averageRating = 0.0;
  int _totalRatings = 0;

  @override
  void initState() {
    super.initState();
    _fetchRatings();
  }

  Future<void> _fetchRatings() async {
    DocumentSnapshot placeDoc = await FirebaseFirestore.instance.collection('places_colombia').doc(widget.place['name']).get();
    if (placeDoc.exists) {
      Map<String, dynamic> data = placeDoc.data() as Map<String, dynamic>;
      setState(() {
        _averageRating = (data['averageRating']?.toDouble() ?? 0.0);
        _totalRatings = (data['totalRatings'] ?? 0);
      });
    } else {
      // Crear el documento si no existe
      await FirebaseFirestore.instance.collection('places_colombia').doc(widget.place['name']).set({
        'averageRating': 0.0,
        'totalRatings': 0,
      });
      setState(() {
        _averageRating = 0.0;
        _totalRatings = 0;
      });
    }
  }

  Future<void> _submitRating(double rating) async {
    DocumentReference placeRef = FirebaseFirestore.instance.collection('places_colombia').doc(widget.place['name']);
    DocumentSnapshot placeDoc = await placeRef.get();

    if (placeDoc.exists) {
      Map<String, dynamic> data = placeDoc.data() as Map<String, dynamic>;
      int totalRatings = data['totalRatings'] ?? 0;
      double averageRating = data['averageRating']?.toDouble() ?? 0.0;

      // Calcular la nueva calificación promedio
      averageRating = ((averageRating * totalRatings) + rating) / (totalRatings + 1);
      totalRatings += 1;

      // Actualizar el documento del lugar con la nueva calificación promedio y el total de calificaciones
      await placeRef.update({
        'averageRating': averageRating,
        'totalRatings': totalRatings,
      });

      setState(() {
        _averageRating = averageRating;
        _totalRatings = totalRatings;
      });
    } else {
      // Crear el documento del lugar si no existe, con la calificación inicial
      await placeRef.set({
        'averageRating': rating,
        'totalRatings': 1,
      });

      setState(() {
        _averageRating = rating;
        _totalRatings = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place['name'] ?? 'Unknown'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.place['img'] != null
                ? Image.network(
                    widget.place['img'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
            )
                : Icon(Icons.image_not_supported),
            SizedBox(height: 16.0),
            Text('Name: ${widget.place['name'] ?? 'Unknown'}'),
            Text('Department: ${widget.place['Department'] ?? 'N/A'}'),
            Text('Description: ${widget.place['Description'] ?? 'N/A'}'),
            widget.place['Location'] != null
                ? Text('Location: ${widget.place['Location'].latitude}, ${widget.place['Location'].longitude}')
                : Text('Location: N/A'),
            Text('Weather: ${widget.place['Weather'] ?? 'N/A'}'),
            SizedBox(height: 16.0),
            Text('${AppText.average}: ${_averageRating.toStringAsFixed(1)} ($_totalRatings ${AppText.total})'),
            RatingBar.builder(
              initialRating: _userRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _userRating = rating;
                });
              },
            ),
            ElevatedButton(
              onPressed: () => _submitRating(_userRating),
              child: Text('${AppText.submit}'),
            ),
          ],
        ),
      ),
    );
  }
}

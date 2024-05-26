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
  final TextEditingController _commentController = TextEditingController();
  List<Map<String, dynamic>> _comments = [];

  @override
  void initState() {
    super.initState();
    _fetchRatings();
    _fetchComments();
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

  Future<void> _fetchComments() async {
    QuerySnapshot commentsSnapshot = await FirebaseFirestore.instance
        .collection('places_colombia')
        .doc(widget.place['name'])
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .get();
    setState(() {
      _comments = commentsSnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  Future<void> _submitRating(double rating) async {
    DocumentReference placeRef = FirebaseFirestore.instance.collection('places_colombia').doc(widget.place['name']);
    DocumentSnapshot placeDoc = await placeRef.get();

    if (placeDoc.exists) {
      Map<String, dynamic> data = placeDoc.data() as Map<String, dynamic>;
      int totalRatings = data['totalRatings'] ?? 0;
      double averageRating = data['averageRating']?.toDouble() ?? 0.0;

      averageRating = ((averageRating * totalRatings) + rating) / (totalRatings + 1);
      totalRatings += 1;

      await placeRef.update({
        'averageRating': averageRating,
        'totalRatings': totalRatings,
      });

      setState(() {
        _averageRating = averageRating;
        _totalRatings = totalRatings;
      });
    } else {
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

  Future<void> _submitComment(String comment) async {
    if (comment.isNotEmpty) {
      DocumentReference placeRef = FirebaseFirestore.instance.collection('places_colombia').doc(widget.place['name']);
      await placeRef.collection('comments').add({
        'text': comment,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _commentController.clear();
      _fetchComments();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place['name'] ?? 'Unknown'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
              Text('${AppText.name}: ${widget.place['name'] ?? 'Unknown'}'),
              Text('${AppText.department}: ${widget.place['Department'] ?? 'N/A'}'),
              Text('${AppText.description}: ${widget.place['Description'] ?? 'N/A'}'),
              widget.place['Location'] != null
                  ? Text('${AppText.location}: ${widget.place['Location'].latitude}, ${widget.place['Location'].longitude}')
                  : Text('${AppText.location}: N/A'),
              Text('${AppText.weather}: ${widget.place['Weather'] ?? 'N/A'}'),
              SizedBox(height: 16.0),
              Text('${AppText.average}: ${_averageRating.toStringAsFixed(1)} ($_totalRatings ${AppText.totalRatings})'),
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
              SizedBox(height: 16.0),
              TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: '${AppText.addComment}',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () => _submitComment(_commentController.text),
                child: Text('${AppText.submitComment}'),
              ),
              SizedBox(height: 16.0),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  final comment = _comments[index];
                  return ListTile(
                    title: Text(comment['text'] ?? ''),
                    subtitle: Text(comment['timestamp'] != null
                        ? (comment['timestamp'] as Timestamp).toDate().toString()
                        : 'Time not available'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../home/screens/detail_place.dart';

class SearchPlacesView extends StatefulWidget {
  SearchPlacesView({super.key});

  @override
  State<SearchPlacesView> createState() => _SearchPlacesViewState();
}

class _SearchPlacesViewState extends State<SearchPlacesView> {
  var searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: SizedBox(
          height: 40,
          child: TextField(
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search by name or department',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
              .collection('places_cololmbia')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            var places = snapshot.data!.docs.where((doc) {
              var data = doc.data() as Map<String, dynamic>;
              var name = data['name'].toString().toLowerCase();
              var department = data['Department'].toString().toLowerCase();
              return name.contains(searchQuery.toLowerCase()) ||
                  department.contains(searchQuery.toLowerCase());
            }).toList();



          if (places.isEmpty) {
            return Center(child: Text("No places found"));
          }

          return ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              var data = places[index].data() as Map<String, dynamic>;
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailsScreen(place: data),
                    ),
                  );
                },
                leading: CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(data['img']),
                ),
                title: Text(data['name']),
                subtitle: Text(data['Department']),

              );
            },
          );
        },
      ),
    );
  }
}

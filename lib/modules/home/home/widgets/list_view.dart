import 'package:excursion/common/styles/spacing_styles.dart';
import 'package:excursion/utils/constants/colors.dart';
import 'package:excursion/utils/services/firestore.dart';
import 'package:flutter/material.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: TSpacingStyles.paddingWithAppBarHeight,
        child: RefreshIndicator(
          onRefresh: () async {
            await firestoreService.getAllCollection(nameCollection: 'places_cololmbia');
            setState(() {});
          },
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: firestoreService.getAllCollection(nameCollection: 'places_cololmbia'),
            builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data found.'));
              }

              final data = snapshot.data!;

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 21.0,
                  crossAxisSpacing: 15.0,
                ),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final place = data[index];

                  return Card(
                    elevation: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: Image.network(
                              place['img'] ?? '',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place['name'] ?? 'Unknown',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text('Departmento: ${place['Department'] ?? 'N/A'}'),
                              Text('Description: ${place['Description'] ?? 'N/A'}'),
                              Text('Location: ${place['Location'] != null ? '${place['Location']['latitude']}, ${place['Location']['longitude']}' : 'N/A'}'),
                              Text('Rating: ${place['Rating'] ?? 'N/A'}'),
                              Text('Weather: ${place['Weather'] ?? 'N/A'}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

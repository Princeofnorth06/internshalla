import 'package:flutter/material.dart';
import 'package:internshalla/main.dart';
import 'package:internshalla/models/appbar.dart';
import 'package:internshalla/models/appbar2.dart';
import 'package:internshalla/models/internshipmodel.dart';
import 'package:internshalla/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key,
      this.selectedProfile,
      this.selectedDuration,
      this.selectedCity});

  final String? selectedProfile;
  final String? selectedDuration;
  final String? selectedCity;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Map<String, dynamic>>? _data;

  @override
  void initState() {
    super.initState();
    _data = ApiServices.fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            const AppBars(),
            SizedBox(
                height: mq.height * 0.113,
                child: const AppBar2(
                  profile: [
                    'Data Science',
                    'Administration',
                    'Android App Development',
                    "Product Management",
                    "Business Analytics",
                    'Brand Management'
                  ],
                  location: [
                    'Tarn Taran',
                    'Delhi',
                    'Munnar',
                    'Lucknow',
                    'Banga (Philippines)',
                    'Work from Home'
                  ],
                  duration: ['1 Months', '2 Months', '3 Months'],
                )),
            Container(
              height: mq.height * 0.004,
              color: Colors.grey.shade300,
            ),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: _data,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData ||
                      snapshot.data!['internships_meta'] == null) {
                    return const Center(child: Text('No data available'));
                  } else {
                    final internshipsMeta = snapshot.data!['internships_meta']
                        as Map<String, dynamic>;
                    final internshipIds =
                        snapshot.data!['internship_ids'] as List<dynamic>;

                    final filteredInternships = internshipIds.where((id) {
                      final internship = internshipsMeta[id.toString()];
                      return (widget.selectedProfile == null ||
                              internship['profile_name']
                                  .contains(widget.selectedProfile)) &&
                          (widget.selectedDuration == null ||
                              internship['duration'].toString().contains(
                                  widget.selectedDuration.toString())) &&
                          (widget.selectedCity == null ||
                              internship['location_names']
                                  .toString()
                                  .contains(widget.selectedCity.toString()));
                    }).toList();

                    if (filteredInternships.isEmpty) {
                      return const Center(
                        child: Text("No Internship Found"),
                      );
                    }

                    return ListView.builder(
                      itemCount: filteredInternships.length,
                      itemBuilder: (context, index) {
                        final internshipId =
                            filteredInternships[index].toString();
                        final internship = internshipsMeta[internshipId];

                        return Model(
                          title: internship['title'] ?? 'No title',
                          location: List<String>.from(
                              internship['location_names'] ?? []),
                          companyname:
                              internship['company_name'] ?? 'No company name',
                          companylogo: internship['company_logo'] ?? "",
                          iswfh: internship['work_from_home'] ?? false,
                          stipend:
                              internship['stipend']['salary'] ?? 'No stipend',
                          duration: internship['duration'] ?? 'No duration',
                          employementtype:
                              internship['labels_app'] ?? 'No employment type',
                          lasttoapply: internship['expires_at'] != null
                              ? DateTime.parse(internship['expires_at'])
                              : DateTime.now(),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: true,
        currentIndex: 1,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/home.png',
              height: 35,
              width: 35,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Image.asset(
              'assets/plane.png',
              color: Colors.blue,
              height: 35,
              width: 35,
            ),
            label: 'Internships',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Image.asset(
              'assets/job.png',
              color: Colors.black,
              height: 35,
              width: 35,
            ),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Image.asset(
              'assets/user.png',
              color: Colors.black,
              height: 35,
              width: 35,
            ),
            label: 'Clubs',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Image.asset(
              'assets/tv.png',
              color: Colors.black,
              height: 35,
              width: 35,
            ),
            label: 'Courses',
          ),
        ],
      ),
    );
  }
}

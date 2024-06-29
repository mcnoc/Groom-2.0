import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data_models/provider_service_model.dart';
import '../../data_models/user_model.dart';
import '../../firebase/provider_service_firebase.dart';
import '../../firebase/user_firebase.dart';
import '../../utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ProviderServiceFirebase providerServiceFirebase = ProviderServiceFirebase();
  final UserFirebase userFirebase = UserFirebase();

  String _selectedFilter = "All";
  String _selectedSort = "Rating";
  String _searchQuery = "";
  List<ProviderServiceModel> _services = [];

  final List<String> filters = ["All", "Hair Style", "Nails", "Coloring", "Wax", "Spa", "Massage", "Polish"];
  final List<String> sortOptions = ["Rating", "Price"];

  @override
  void initState() {
    super.initState();
    _fetchServices();
  }

  void _fetchServices() async {
    var services = await providerServiceFirebase.getAllServices();
    setState(() {
      _services = services;
    });
  }

  List<ProviderServiceModel> _getFilteredServices() {
    List<ProviderServiceModel> filteredServices = _services;

    if (_selectedFilter != "All") {
      filteredServices = filteredServices.where((service) => service.serviceType == _selectedFilter).toList();
    }

    if (_searchQuery.isNotEmpty) {
    }

    if (_selectedSort == "Rating") {
    } else if (_selectedSort == "Price") {
    }

    return filteredServices;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedFilter,
                  items: filters.map((String filter) {
                    return DropdownMenuItem<String>(
                      value: filter,
                      child: Text(filter),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFilter = newValue!;
                    });
                  },
                ),
                SizedBox(width: 8),
                DropdownButton<String>(
                  value: _selectedSort,
                  items: sortOptions.map((String sortOption) {
                    return DropdownMenuItem<String>(
                      value: sortOption,
                      child: Text(sortOption),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSort = newValue!;
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                future: providerServiceFirebase.getAllServices(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    var services = _getFilteredServices();
                    return ListView.builder(
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        var service = services[index];
                        return FutureBuilder<UserModel>(
                          future: userFirebase.getUser(service.userId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else if (snapshot.hasData) {
                              var userModelService = snapshot.data;
                              return Container(
                                width: 150,
                                height: 150,
                                child: ListTile(
                                  leading: CachedNetworkImage(
                                    imageUrl: service.serviceImages!.first,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(service.serviceType),
                                  subtitle: Text(userModelService?.providerUserModel?.salonTitle ?? userModelService?.fullName ?? 'Unknown'),
                                  trailing: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text('\$${service.servicePrice.toString()}'),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Text("No data found.");
                            }
                          },
                        );
                      },
                    );
                  } else {
                    return Text("No data found.");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../repositories/weather_repository.dart';
import '../services/weather_api_service.dart';
import 'search_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _city;
  late WeatherRepository weatherRepository;

  @override
  void initState() {
    weatherRepository = WeatherRepository(
      weatherApiService: WeatherApiService(httpClient: http.Client()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Openweather Bloc'),
        toolbarHeight: 60,
        elevation: 6,
        actions: [
          Material(
            borderRadius: BorderRadius.circular(50),
            child: IconButton(
              onPressed: () {
                // _city = await Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => SearchPage(),
                //   ),
                // );
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ),
                )
                    .then((value) async {
                  setState(() {
                    _city = value;
                  });
                  await weatherRepository.fetchWeather(_city!);
                });
              },
              icon: Icon(CupertinoIcons.search),
            ),
          ),
          SizedBox(width: 10),
          Material(
            borderRadius: BorderRadius.circular(50),
            child: IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SettingsPage(),
                ),
              ),
              icon: Icon(CupertinoIcons.settings),
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: Center(
        child: Text(
          _city == null ? 'Select a city' : _city.toString(),
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

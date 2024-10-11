import 'package:flutter/material.dart';
import 'package:weather_pack/weather_pack.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String location = 'Press the button to get location';
  String weather = 'Press the button to get weather';

  // API key for Openweathermap
  final String api =
      'b9330f6f7d5a9679b342375165ae96bb'; // TODO: Ganti dengan API key kamu

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello, world!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(location),
            const SizedBox(height: 10),
            Text(weather),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                final gService = GeocodingService(api);
                final wService = WeatherService(api);

                // Mengambil data lokasi berdasarkan koordinat
                final List<PlaceGeocode> places =
                    await gService.getLocationByCoordinates(
                        latitude: -7.88461, longitude: 110.33411);

                // Mengambil cuaca saat ini berdasarkan koordinat
                final WeatherCurrent currently =
                    await wService.currentWeatherByLocation(
                        latitude: -7.88461, longitude: 110.33411);
                print(currently);
                print(places);
                // Memperbarui UI dengan data yang diambil
                setState(() {
                  location = places.isNotEmpty
                      ? 'Location: ${places.first.name}'
                      : 'Location not found';

                  weather = 'Temperature: ${currently.temp}°C, '
                      'Condition: ${currently.weatherDescription}';
                });
              },
              child: const Text('Get Weather'),
            ),
          ],
        ),
      ),
    );
  }
}

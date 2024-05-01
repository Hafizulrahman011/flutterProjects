import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weatherapp/const.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key); // Fixed the key parameter

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory wf = WeatherFactory(apiKey); 
  Weather? weather;

   @override
  void initState() {
    super.initState();
    wf.currentWeatherByCityName("Sepang").then((w) {
      setState(() {
        weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          locationHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.08,
          ),
          dateTimeInfo(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          weatherIcon(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          currentTemp(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
          ),
          extraInfo(),
        ],
      ),
    );
  }

  //function for returning place name
  Widget locationHeader() {
    return Text(
      weather?.areaName ?? "",
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  //function for returning date
  Widget dateTimeInfo() {
    DateTime now = weather!.date!;
    //att for time
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(
            fontSize: 35,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        //att for days
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            //att for date
            Text(
              "  ${DateFormat("d.M.y").format(now)}",
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        )
      ],
    );
  }

  //function for icons
  Widget weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.20,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        )
      ],
    );
  }

  //function for returning temp
  Widget currentTemp() {
    return Text(
      "${weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 50,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  //function for displaying extrainfo
  Widget extraInfo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.80,
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(8.0),

      //extra info

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //code for min and max temp
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Max : ${weather?.tempMax?.celsius?.toStringAsFixed(0)}°C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
               Text(
                "Min : ${weather?.tempMin?.celsius?.toStringAsFixed(0)}°C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
            //code for wind speed and humidity
            Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Wind : ${weather?.windSpeed?.toStringAsFixed(0)}m/s",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
               Text(
                "Humidity : ${weather?.tempMin?.celsius?.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

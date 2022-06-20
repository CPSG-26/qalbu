import 'package:equatable/equatable.dart';
import 'package:qalbu/domain/entities/timings.dart';

class TimingsModel extends Equatable {
  const TimingsModel({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
  });

  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;

  factory TimingsModel.fromJson(Map<String, dynamic> json) => TimingsModel(
        fajr: json["Fajr"],
        sunrise: json["Sunrise"],
        dhuhr: json["Dhuhr"],
        asr: json["Asr"],
        sunset: json["Sunset"],
        maghrib: json["Maghrib"],
        isha: json["Isha"],
        imsak: json["Imsak"],
        midnight: json["Midnight"],
      );

  Map<String, dynamic> toJson() => {
        "Fajr": fajr,
        "Sunrise": sunrise,
        "Dhuhr": dhuhr,
        "Asr": asr,
        "Sunset": sunset,
        "Maghrib": maghrib,
        "Isha": isha,
        "Imsak": imsak,
        "Midnight": midnight,
      };

  Timings toEntity() {
    return Timings(
      fajr: fajr,
      sunrise: sunrise,
      dhuhr: dhuhr,
      asr: asr,
      sunset: sunset,
      maghrib: maghrib,
      isha: isha,
      imsak: imsak,
      midnight: midnight,
    );
  }

  @override
  List<Object?> get props => [
        fajr,
        sunrise,
        dhuhr,
        asr,
        sunset,
        maghrib,
        isha,
        imsak,
        midnight,
      ];
}

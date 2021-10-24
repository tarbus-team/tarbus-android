import 'package:xml/xml.dart';

class RemoteDeparture {
  // nr
  final String lineNumber;

  // dir
  final String direction;

  // vt
  final String vehicleType;

  // uw
  final String vehicleUw;

  ///////////////

  // th
  final String hour;

  // tm
  final String minutes;

  //tm
  final String time;
  final String m;
  final String s;

  // id
  final String trackId;
  final String nb;
  final String veh;
  final String uw;
  final String kuw;

  RemoteDeparture({
    required this.lineNumber,
    required this.direction,
    required this.vehicleType,
    required this.vehicleUw,
    required this.hour,
    required this.minutes,
    required this.time,
    required this.m,
    required this.s,
    required this.trackId,
    required this.nb,
    required this.veh,
    required this.uw,
    required this.kuw,
  });

  factory RemoteDeparture.fromElement(XmlElement element) {
    XmlElement sElement = element.findElements('S').first;
    return RemoteDeparture(
      lineNumber: element.getAttribute('nr') ?? '',
      direction: element.getAttribute('dir') ?? '',
      vehicleType: element.getAttribute('vt') ?? '',
      vehicleUw: element.getAttribute('uw') ?? '',
      hour: sElement.getAttribute('th') ?? '',
      minutes: sElement.getAttribute('tm') ?? '',
      time: sElement.getAttribute('t') ?? '',
      m: sElement.getAttribute('m') ?? '',
      s: sElement.getAttribute('s') ?? '',
      trackId: sElement.getAttribute('id') ?? '',
      nb: sElement.getAttribute('nb') ?? '',
      veh: sElement.getAttribute('veh') ?? '',
      uw: sElement.getAttribute('uw') ?? '',
      kuw: sElement.getAttribute('kuw') ?? '',
    );
  }

  @override
  String toString() {
    return 'RemoteDeparture{lineNumber: $lineNumber, direction: $direction, vehicleType: $vehicleType, vehicleUw: $vehicleUw, hour: $hour, minutes: $minutes, time: $time, m: $m, s: $s, trackId: $trackId, nb: $nb, veh: $veh, uw: $uw, kuw: $kuw}';
  }
}

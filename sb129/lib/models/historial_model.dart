
import 'dart:convert';

class HistTemp {
    List<double> temperatura;
    List<String> time;

    HistTemp({
        required this.temperatura,
        required this.time,
    });

    factory HistTemp.fromJson(String str) => HistTemp.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory HistTemp.fromMap(Map<String, dynamic> json) => HistTemp(
        temperatura: List<double>.from(json["temperatura"].map((x) => x)),
        time: List<String>.from(json["time"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "temperatura": List<dynamic>.from(temperatura.map((x) => x)),
        "time": List<dynamic>.from(time.map((x) => x)),
    };
}

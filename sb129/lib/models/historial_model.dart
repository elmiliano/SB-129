
import 'dart:convert';

class HistTemp {
    List<int> temperatura;
    List<int> time;

    HistTemp({
        required this.temperatura,
        required this.time,
    });

    factory HistTemp.fromJson(String str) => HistTemp.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory HistTemp.fromMap(Map<String, dynamic> json) => HistTemp(
        temperatura: List<int>.from(json["Temperatura"].map((x) => x)),
        time: List<int>.from(json["Time"].map((x) => x)),
    );

    Map<String, dynamic> toMap() => {
        "Temperatura": List<dynamic>.from(temperatura.map((x) => x)),
        "Time": List<dynamic>.from(time.map((x) => x)),
    };
}

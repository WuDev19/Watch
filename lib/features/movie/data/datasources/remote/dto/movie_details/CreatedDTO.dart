class CreatedDTO {
  String time;

  CreatedDTO({required this.time});

  factory CreatedDTO.fromJson(Map<String, dynamic> json) =>
      CreatedDTO(time: json["time"]);

  Map<String, dynamic> toJson() => {"time": time};
}

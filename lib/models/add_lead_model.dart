

class AddFields {
  AddFields({required this.field, required this.value});

  AddFields.fromJson(Map<String, Object?> json)
      : this(
          field: json['field']! as String,
          value: json['value']! as String,
        );

  final String field;
  final String value;

  Map<String, Object?> toJson() {
    return {
      'field': field,
      'value': value,
    };
  }
}
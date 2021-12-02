import 'dart:convert';

import 'package:uuid/uuid.dart';

class CharacteristicItem {
  /// Семантичное название свойства
  final String name;

  /// [type] Тип может быть bool, int, String
  final Type type;

  /// [writable] Можно ли внешним устройствам записывать значение характеристики
  final bool writable;

  /// [notifiable] Можно ли подписываться на изменение значения характеристики
  final bool notifiable;
  late String uuid;
  CharacteristicItem(this.name, this.type,
      {this.writable = false, this.notifiable = false, String? inuuid}) {
    uuid = inuuid ?? Uuid().v4();
  }

  String get _uuidConstName => name.toUpperCase() + "_UUID";
  String get _propertyPointerName => "${name}Prop";

  String get _propertyCallbackClassName => "C${_propertyPointerName}Callbacks";

  String getUUIDConstantDefinition() {
    return '#define $_uuidConstName "$uuid"';
  }

  String getBLECharacteristicPointerDefinition() {
    return "BLECharacteristic *$_propertyPointerName;";
  }

  bool get hasCallback => writable;

  String getCallbacksClassDefinition() {
    if (!hasCallback) {
      return "";
    }
    return '''class $_propertyCallbackClassName : public BLECharacteristicCallbacks {
  void onWrite(BLECharacteristic *pCharacteristic) {
      std::string rawValue = pCharacteristic->getValue();
    ${type == int ? 'int value = atoi(rawValue.c_str());' : ""}${type == String ? 'const char* value = rawValue.c_str();' : ""}${type == bool ? 'bool value = atoi(rawValue.c_str())==1;' : ""}
    /// Здесь обработка изменения свойств

    /// Здесь обработка изменения свойств кончается 
    ${notifiable ? 'pCharacteristic->notify()' : null};
  }
};''';
  }

  String getCharacteristicAssignment() {
    return '''$_propertyPointerName = pService->createCharacteristic($_uuidConstName,BLECharacteristic::PROPERTY_READ${writable ? "| BLECharacteristic::PROPERTY_WRITE" : ""} ${notifiable ? "|BLECharacteristic::PROPERTY_NOTIFY" : ""});
    ${hasCallback ? "$_propertyPointerName->setCallbacks(new $_propertyCallbackClassName());" : ""}
    ''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CharacteristicItem &&
        other.name == name &&
        other.type == type &&
        other.writable == writable &&
        other.notifiable == notifiable &&
        other.uuid == uuid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        type.hashCode ^
        writable.hashCode ^
        notifiable.hashCode ^
        uuid.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type.toString(),
      'writable': writable,
      'notifiable': notifiable,
      'uuid': uuid,
    };
  }

  String toJson() => json.encode(toMap());

  factory CharacteristicItem.fromMap(Map<String, dynamic> map) {
    return CharacteristicItem(
      map['name'],
      map['type'] == 'int'
          ? int
          : map['type'] == "String"
              ? String
              : map['type'] == "bool"
                  ? bool
                  : int,
      writable: map['writable'],
      notifiable: map['notifiable'],
      inuuid: map['uuid'],
    );
  }

  factory CharacteristicItem.fromJson(String source) =>
      CharacteristicItem.fromMap(json.decode(source));
}

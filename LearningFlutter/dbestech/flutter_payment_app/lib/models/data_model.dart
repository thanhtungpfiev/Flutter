class DataModel {
  final String brandName;
  final String brandLogo;
  final int due;
  final bool status;
  final String dueInfo;
  final int brandId;

//<editor-fold desc="Data Methods">
  const DataModel({
    required this.brandName,
    required this.brandLogo,
    required this.due,
    required this.status,
    required this.dueInfo,
    required this.brandId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DataModel &&
          runtimeType == other.runtimeType &&
          brandName == other.brandName &&
          brandLogo == other.brandLogo &&
          due == other.due &&
          status == other.status &&
          dueInfo == other.dueInfo &&
          brandId == other.brandId);

  @override
  int get hashCode =>
      brandName.hashCode ^
      brandLogo.hashCode ^
      due.hashCode ^
      status.hashCode ^
      dueInfo.hashCode ^
      brandId.hashCode;

  @override
  String toString() {
    return 'DataModel{ brandName: $brandName, brandLogo: $brandLogo, due: $due, status: $status, dueInfo: $dueInfo, brandId: $brandId,}';
  }

  DataModel copyWith({
    String? brandName,
    String? brandLogo,
    int? due,
    bool? status,
    String? dueInfo,
    int? brandId,
  }) {
    return DataModel(
      brandName: brandName ?? this.brandName,
      brandLogo: brandLogo ?? this.brandLogo,
      due: due ?? this.due,
      status: status ?? this.status,
      dueInfo: dueInfo ?? this.dueInfo,
      brandId: brandId ?? this.brandId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'brandName': brandName,
      'brandLogo': brandLogo,
      'due': due,
      'status': status,
      'dueInfo': dueInfo,
      'brandId': brandId,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      brandName: map['brand_name'] ?? '',
      brandLogo: map['brand_logo'] ?? 'images/brand1.png',
      due: map['due'] ?? 0,
      status: map['status'] == 0 ? false : true,
      dueInfo: map['due_info'] ?? '',
      brandId: map['brand_id'] ?? 0,
    );
  }

//</editor-fold>
}

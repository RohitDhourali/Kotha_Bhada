class PropertyRequestModel {
  final String flatType;
  final String rent;
  final String address;
  final String description;
  final String ownername;
  final String ownercontact;

  PropertyRequestModel({
    required this.flatType,
    required this.rent,
    required this.address,
    required this.description,
    required this.ownername,
    required this.ownercontact,
  });

  Map<String, dynamic> toMap(String userId) {
    return {
      "flatType": flatType,
      "rent": rent,
      "address": address,
      "description": description,
      "ownername": ownername,
      "ownercontact": ownercontact,
      "userId": userId,   // injected at save time
    };
    // No id — Firebase generates it ✅
  }
}
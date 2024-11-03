// class SearchModel {
//   SearchModel({
//       this.predictions,
//       this.status,});
//
//   SearchModel.fromJson(dynamic json) {
//     if (json['predictions'] != null) {
//       predictions = [];
//       json['predictions'].forEach((v) {
//         predictions?.add(Predictions.fromJson(v));
//       });
//     }
//     status = json['status'];
//   }
//   List<Predictions>? predictions;
//   String? status;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (predictions != null) {
//       map['predictions'] = predictions?.map((v) => v.toJson()).toList();
//     }
//     map['status'] = status;
//     return map;
//   }
//
// }
//
// class Predictions {
//   Predictions({
//       this.description,
//       this.matchedSubstrings,
//       this.placeId,
//       this.reference,
//       this.structuredFormatting,
//       this.terms,
//       this.types,});
//
//   Predictions.fromJson(dynamic json) {
//     description = json['description'];
//     if (json['matched_substrings'] != null) {
//       matchedSubstrings = [];
//       json['matched_substrings'].forEach((v) {
//         matchedSubstrings?.add(MatchedSubstrings.fromJson(v));
//       });
//     }
//     placeId = json['place_id'];
//     reference = json['reference'];
//     structuredFormatting = json['structured_formatting'] != null ? StructuredFormatting.fromJson(json['structured_formatting']) : null;
//     if (json['terms'] != null) {
//       terms = [];
//       json['terms'].forEach((v) {
//         terms?.add(Terms.fromJson(v));
//       });
//     }
//     types = json['types'] != null ? json['types'].cast<String>() : [];
//   }
//   String? description;
//   List<MatchedSubstrings>? matchedSubstrings;
//   String? placeId;
//   String? reference;
//   StructuredFormatting? structuredFormatting;
//   List<Terms>? terms;
//   List<String>? types;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['description'] = description;
//     if (matchedSubstrings != null) {
//       map['matched_substrings'] = matchedSubstrings?.map((v) => v.toJson()).toList();
//     }
//     map['place_id'] = placeId;
//     map['reference'] = reference;
//     if (structuredFormatting != null) {
//       map['structured_formatting'] = structuredFormatting?.toJson();
//     }
//     if (terms != null) {
//       map['terms'] = terms?.map((v) => v.toJson()).toList();
//     }
//     map['types'] = types;
//     return map;
//   }
//
// }
//
// class Terms {
//   Terms({
//       this.offset,
//       this.value,});
//
//   Terms.fromJson(dynamic json) {
//     offset = json['offset'];
//     value = json['value'];
//   }
//   int? offset;
//   String? value;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['offset'] = offset;
//     map['value'] = value;
//     return map;
//   }
//
// }
//
// class StructuredFormatting {
//   StructuredFormatting({
//       this.mainText,
//       this.mainTextMatchedSubstrings,
//       this.secondaryText,});
//
//   StructuredFormatting.fromJson(dynamic json) {
//     mainText = json['main_text'];
//     if (json['main_text_matched_substrings'] != null) {
//       mainTextMatchedSubstrings = [];
//       json['main_text_matched_substrings'].forEach((v) {
//         mainTextMatchedSubstrings?.add(MainTextMatchedSubstrings.fromJson(v));
//       });
//     }
//     secondaryText = json['secondary_text'];
//   }
//   String? mainText;
//   List<MainTextMatchedSubstrings>? mainTextMatchedSubstrings;
//   String? secondaryText;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['main_text'] = mainText;
//     if (mainTextMatchedSubstrings != null) {
//       map['main_text_matched_substrings'] = mainTextMatchedSubstrings?.map((v) => v.toJson()).toList();
//     }
//     map['secondary_text'] = secondaryText;
//     return map;
//   }
//
// }
//
// class MainTextMatchedSubstrings {
//   MainTextMatchedSubstrings({
//       this.length,
//       this.offset,});
//
//   MainTextMatchedSubstrings.fromJson(dynamic json) {
//     length = json['length'];
//     offset = json['offset'];
//   }
//   int? length;
//   int? offset;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['length'] = length;
//     map['offset'] = offset;
//     return map;
//   }
//
// }
//
// class MatchedSubstrings {
//   MatchedSubstrings({
//       this.length,
//       this.offset,});
//
//   MatchedSubstrings.fromJson(dynamic json) {
//     length = json['length'];
//     offset = json['offset'];
//   }
//   int? length;
//   int? offset;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['length'] = length;
//     map['offset'] = offset;
//     return map;
//   }
//
// }
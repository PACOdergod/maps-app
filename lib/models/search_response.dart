// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromMap(jsonString);

import 'dart:convert';

class SearchResponse {
    SearchResponse({
        this.type,
        this.query,
        this.features,
        this.attribution,
    });

    String? type;
    List<String>? query;
    List<Feature>? features;
    String? attribution;

    factory SearchResponse.fromJson(String str) => SearchResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SearchResponse.fromMap(Map<String, dynamic> json) => SearchResponse(
        type: json["type"] == null ? null : json["type"],
        query: json["query"] == null ? null : List<String>.from(json["query"].map((x) => x)),
        features: json["features"] == null ? null : List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"] == null ? null : json["attribution"],
    );

    Map<String, dynamic> toMap() => {
        "type": type == null ? null : type,
        "query": query == null ? null : List<dynamic>.from(query!.map((x) => x)),
        "features": features == null ? null : List<dynamic>.from(features!.map((x) => x.toMap())),
        "attribution": attribution == null ? null : attribution,
    };
}

class Feature {
    Feature({
        this.id,
        this.type,
        this.placeType,
        this.relevance,
        this.properties,
        this.textEs,
        this.placeNameEs,
        this.text,
        this.placeName,
        this.center,
        this.geometry,
        this.context,
        this.languageEs,
        this.language,
        this.matchingText,
        this.matchingPlaceName,
    });

    String? id;
    String? type;
    List<String>? placeType;
    int? relevance;
    Properties? properties;
    String? textEs;
    String? placeNameEs;
    String? text;
    String? placeName;
    List<double>? center;
    Geometry? geometry;
    List<Context>? context;
    String? languageEs;
    String? language;
    String? matchingText;
    String? matchingPlaceName;

    factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        placeType: json["place_type"] == null ? null : List<String>.from(json["place_type"].map((x) => x)),
        relevance: json["relevance"] == null ? null : json["relevance"],
        properties: json["properties"] == null ? null : Properties.fromMap(json["properties"]),
        textEs: json["text_es"] == null ? null : json["text_es"],
        placeNameEs: json["place_name_es"] == null ? null : json["place_name_es"],
        text: json["text"] == null ? null : json["text"],
        placeName: json["place_name"] == null ? null : json["place_name"],
        center: json["center"] == null ? null : List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: json["geometry"] == null ? null : Geometry.fromMap(json["geometry"]),
        context: json["context"] == null ? null : List<Context>.from(json["context"].map((x) => Context.fromMap(x))),
        languageEs: json["language_es"] == null ? null : json["language_es"],
        language: json["language"] == null ? null : json["language"],
        matchingText: json["matching_text"] == null ? null : json["matching_text"],
        matchingPlaceName: json["matching_place_name"] == null ? null : json["matching_place_name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "place_type": placeType == null ? null : List<dynamic>.from(placeType!.map((x) => x)),
        "relevance": relevance == null ? null : relevance,
        "properties": properties == null ? null : properties?.toMap(),
        "text_es": textEs == null ? null : textEs,
        "place_name_es": placeNameEs == null ? null : placeNameEs,
        "text": text == null ? null : text,
        "place_name": placeName == null ? null : placeName,
        "center": center == null ? null : List<dynamic>.from(center!.map((x) => x)),
        "geometry": geometry == null ? null : geometry?.toMap(),
        "context": context == null ? null : List<dynamic>.from(context!.map((x) => x.toMap())),
        "language_es": languageEs == null ? null : languageEs,
        "language": language == null ? null : language,
        "matching_text": matchingText == null ? null : matchingText,
        "matching_place_name": matchingPlaceName == null ? null : matchingPlaceName,
    };
}

class Context {
    Context({
        this.id,
        this.textEs,
        this.text,
        this.wikidata,
        this.languageEs,
        this.language,
        this.shortCode,
    });

    String? id;
    String? textEs;
    String? text;
    String? wikidata;
    Language? languageEs;
    Language? language;
    String? shortCode;

    factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Context.fromMap(Map<String, dynamic> json) => Context(
        id: json["id"] == null ? null : json["id"],
        textEs: json["text_es"] == null ? null : json["text_es"],
        text: json["text"] == null ? null : json["text"],
        wikidata: json["wikidata"] == null ? null : json["wikidata"],
        languageEs: json["language_es"] == null ? null : languageValues.map?[json["language_es"]],
        language: json["language"] == null ? null : languageValues.map?[json["language"]],
        shortCode: json["short_code"] == null ? null : json["short_code"],
    );

    Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "text_es": textEs == null ? null : textEs,
        "text": text == null ? null : text,
        "wikidata": wikidata == null ? null : wikidata,
        "language_es": languageEs == null ? null : languageValues.reverse?[languageEs],
        "language": language == null ? null : languageValues.reverse?[language],
        "short_code": shortCode == null ? null : shortCode,
    };
}

enum Language { ES, NL }

final languageValues = EnumValues({
    "es": Language.ES,
    "nl": Language.NL
});

class Geometry {
    Geometry({
        this.coordinates,
        this.type,
    });

    List<double>? coordinates;
    String? type;

    factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        coordinates: json["coordinates"] == null ? null : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"] == null ? null : json["type"],
    );

    Map<String, dynamic> toMap() => {
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates!.map((x) => x)),
        "type": type == null ? null : type,
    };
}

class Properties {
    Properties({
        this.foursquare,
        this.landmark,
        this.address,
        this.category,
        this.wikidata,
    });

    String? foursquare;
    bool? landmark;
    String? address;
    String? category;
    String? wikidata;

    factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        foursquare: json["foursquare"] == null ? null : json["foursquare"],
        landmark: json["landmark"] == null ? null : json["landmark"],
        address: json["address"] == null ? null : json["address"],
        category: json["category"] == null ? null : json["category"],
        wikidata: json["wikidata"] == null ? null : json["wikidata"],
    );

    Map<String, dynamic> toMap() => {
        "foursquare": foursquare == null ? null : foursquare,
        "landmark": landmark == null ? null : landmark,
        "address": address == null ? null : address,
        "category": category == null ? null : category,
        "wikidata": wikidata == null ? null : wikidata,
    };
}

class EnumValues<T> {
    Map<String, T>? map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String>? get reverse {
        if (reverseMap == null) {
            reverseMap = map?.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}

import 'package:flutter/material.dart';

@immutable
class PartIDAirtableProduct {
  final String? airtableId;
  final String? partNumber;
  final String? partName;
  final String? make;
  final String? description;
  final String? fitsModel;
  final String? replaces;
  final String? positions;
  final String? otherNames;
  final String? aSideCapturedImage1;
  final String? aSideCapturedImage2;
  final String? aSideCapturedImage3;
  final String? bSideCapturedImage1;
  final String? bSideCapturedImage2;
  final String? bSideCapturedImage3;
  final String? sketch1;
  final String? sketch2;
  final String? sketch3;
  final String? partDetailLink;
  final String? msrp2021;
  final String? notes;

  const PartIDAirtableProduct({
    this.airtableId,
    this.partNumber,
    this.partName,
    this.aSideCapturedImage1,
    this.aSideCapturedImage2,
    this.aSideCapturedImage3,
    this.bSideCapturedImage1,
    this.bSideCapturedImage2,
    this.bSideCapturedImage3,
    this.make,
    this.description,
    this.replaces,
    this.positions,
    this.otherNames,
    this.sketch1,
    this.sketch2,
    this.sketch3,
    this.partDetailLink,
    this.msrp2021,
    this.notes,
    this.fitsModel,
  });

  static PartIDAirtableProduct fromMap(Map<String, dynamic> data) {
    return PartIDAirtableProduct(
      airtableId: data["info"]["Airtable ID"],
      partNumber: data["info"]["Part Number"],
      partName: data["info"]["Part Name"],
      description: data["info"]["Description"],
      fitsModel: data["info"]["Fits Model"],
      aSideCapturedImage1: data["info"]["A-side Captured Image 1"],
      aSideCapturedImage2: data["info"]["A-side Captured Image 2"],
      aSideCapturedImage3: data["info"]["A-side Captured Image 3"],
      bSideCapturedImage1: data["info"]["B-side Captured Image 1"],
      bSideCapturedImage2: data["info"]["B-side Captured Image 2"],
      bSideCapturedImage3: data["info"]["B-side Captured Image 3"],
    );
  }
}

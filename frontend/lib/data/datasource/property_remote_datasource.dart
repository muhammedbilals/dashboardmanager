import 'dart:convert';
import 'dart:developer';
import 'package:dashboard/core/error/failures.dart';
import 'package:dashboard/domain/entity/request/property_request.dart';
import 'package:dashboard/domain/entity/response/property_entity.dart';
import 'package:http/http.dart' as http;

abstract class PropertyApiRemoteDataSource {
  Future<Property> getPropertyById({required int id});
  Future<List<Property>> getProperties();
  Future<Property> createProperty({required PropertyRequest propertyRequest});
  Future<Property?> updateProperty({required int id, required PropertyRequest propertyRequest});
  Future<Property?> deleteProperty({required int id});
}

class PropertyApiRemoteDataSourceImpl implements PropertyApiRemoteDataSource {
  final http.Client httpClient;

  PropertyApiRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<Property> getPropertyById({required int id}) async {
    final url = Uri.parse('https://yourapi.com/properties/$id');
    final response = await httpClient.get(url);
    final decodedBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return Property.fromJson(decodedBody);
    } else {
      log(decodedBody['message']);
      throw ServerFailure(errorMessage: decodedBody['message']);
    }
  }

  @override
  Future<List<Property>> getProperties() async {
    final url = Uri.parse('https://yourapi.com/properties');
    final response = await httpClient.get(url);
    final decodedBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return (decodedBody as List).map((property) => Property.fromJson(property)).toList();
    } else {
      log(decodedBody['message']);
      throw ServerFailure(errorMessage: decodedBody['message']);
    }
  }

  @override
  Future<Property> createProperty({required PropertyRequest propertyRequest}) async {
    var headers = {
      "Content-Type": "application/json",
      "calling_entity": "WEB_UI"
    };
    final url = Uri.parse('https://yourapi.com/properties');
    final response = await httpClient.post(url, headers: headers, body: jsonEncode(propertyRequest.toJson()));
    final decodedBody = json.decode(response.body);

    if (response.statusCode == 201) {  // Assuming 201 for resource creation
      return Property.fromJson(decodedBody);
    } else {
      log(decodedBody['message']);
      throw ServerFailure(errorMessage: decodedBody['message']);
    }
  }

  @override
  Future<Property?> updateProperty({required int id, required PropertyRequest propertyRequest}) async {
    var headers = {
      "Content-Type": "application/json",
      "calling_entity": "WEB_UI"
    };
    final url = Uri.parse('https://yourapi.com/properties/$id');
    final response = await httpClient.put(url, headers: headers, body: jsonEncode(propertyRequest.toJson()));
    final decodedBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return Property.fromJson(decodedBody);
    } else {
      log(decodedBody['message']);
      throw ServerFailure(errorMessage: decodedBody['message']);
    }
  }

  @override
  Future<Property?> deleteProperty({required int id}) async {
    final url = Uri.parse('https://yourapi.com/properties/$id');
    final response = await httpClient.delete(url);
    final decodedBody = json.decode(response.body);

    if (response.statusCode == 200) {
      return Property.fromJson(decodedBody); // or null based on your API response
    } else {
      log(decodedBody['message']);
      throw ServerFailure(errorMessage: decodedBody['message']);
    }
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;


/// ### This method is for post request
/// * [body] map of data to send in the body of the post request
/// * [endPoint] API url end point
/// * [isToken] bool type to check token
/// * [token] token to authentication the API call
/// * [isFullUrl] bool type to check that the endpoint is full URL
Future<dynamic> callPostApi(Map<String, dynamic> body, String endPoint,
    {/*bool isToken = false,*/
      String token = '',
      bool isFullUrl = false,
      /*bool isString = false*/}) async {
  print('URL Request ------------------------------->\n $endPoint');
  print('API Request ------------------------------->\n ${jsonEncode(body)}');

  ///Create a map to send in the header
  final withToken = {
    "Content-Type": "application/json",
    "Authorization": token,
  };

  print(
      'API Request Header ------------------------------->\n ${jsonEncode(withToken)}');

  ///Merge the url
  // String url = isFullUrl ? endPoint : '$endPoint';
  try {
    ///Call the post API call
    final response = await http.post(
      Uri.parse(endPoint),
      headers: withToken,
      // body: body,
      body: jsonEncode(body),
    );
    print(
        'API response ------------------------------->\n ${response.statusCode}');
    print('API response ------------------------------->\n ${response.body}');
    String finalResponse = response.body;
    print(
        'API final response ------------------------------->\n ${finalResponse.toString()}');
    print(
        'API request Header ------------------------------->\n ${response.headers}');
    ///return the response data
    return jsonDecode(finalResponse);
  } catch (e) {
    print('$e');
  }
}
/// ### This method is for post request
/// * [body] map of data to send in the body of the post request
/// * [endPoint] API url end point
/// * [isToken] bool type to check token
/// * [token] token to authentication the API call
/// * [isFullUrl] bool type to check that the endpoint is full URL
Future<dynamic> callPatchApi(Map<String, dynamic> body, String endPoint,
    {/*bool isToken = false,*/
      String token = '',
      bool isFullUrl = false,
      /*bool isString = false*/}) async {
  print('URL Request ------------------------------->\n $endPoint');
  print('API Request ------------------------------->\n ${jsonEncode(body)}');

  ///Create a map to send in the header
  final withToken = {
    "Content-Type": "application/json",
    "Authorization": token,
  };

  print(
      'API Request Header ------------------------------->\n ${jsonEncode(withToken)}');

  ///Merge the url
  // String url = isFullUrl ? endPoint : '$baseURL/$endPoint';
  try {
    ///Call the post API call
    final response = await http.patch(
      Uri.parse(endPoint),
      headers: withToken,
      // body: body,
      body: jsonEncode(body),
    );
    print(
        'API response ------------------------------->\n ${response.statusCode}');
    print('API response ------------------------------->\n ${response.body}');
    String finalResponse = response.body;
    print(
        'API final response ------------------------------->\n ${finalResponse.toString()}');
    print(
        'API request Header ------------------------------->\n ${response.headers}');
    ///return the response data
    return jsonDecode(finalResponse);
  } catch (e) {
    print('$e');
  }
}

/// ### This method is for put request
/// * [body] map data to send in the API body
/// * [endPoint] API url end point
/// * [token] token to authenticate the API call
/// * [isFullUrl] to check endpoint is full url or not
Future<dynamic> callPutApi(Map<String, dynamic> body, String endPoint,
    {/*bool isToken = false,*/
      String token = '',
      bool isFullUrl = false,
      /*bool isString = false*/}) async {
  print('URL Request ------------------------------->\n $endPoint');
  print('API Request ------------------------------->\n ${jsonEncode(body)}');

  ///Create a map to send in the API header
  final withToken = {
    "Content-Type": "application/json",
    "Authorization": token,
  };

  print(
      'API Request Header ------------------------------->\n ${jsonEncode(withToken)}');

  ///Merge the URL if not full url
  // String url = isFullUrl ? endPoint : '$baseURL/$endPoint';
  try {
    ///Call the push API
    final response = await http.put(
      Uri.parse(endPoint),
      headers: withToken,
      // body: body,
      body: jsonEncode(body),
    );
    print(
        'API response ------------------------------->\n ${response.statusCode}');
    print('API response ------------------------------->\n ${response.body}');
    String finalResponse = response.body;
    print(
        'API final response ------------------------------->\n ${finalResponse.toString()}');
    print(
        'API request Header ------------------------------->\n ${response.headers}');
    ///return the API response data
    return jsonDecode(finalResponse);
  } catch (e) {
    print('$e');
  }
}

/// ### This method is for get API call
/// * [endPoint] API url end point
/// * [token] token to authenticate API call
Future<dynamic> callGetApi(String endPoint, {String token = ''}) async {
  try {
    print('token ------------------>\n $token');
    ///Call the post API
    final response = await http.get(
      Uri.parse('$endPoint'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": token,
      },
    );
    print('url ------------------>\n $endPoint');
    print('Auth Token ------------------>\n $token');
    String finalResponse = response.body;
    print(
        'endPoint API request header ------------------>\n ${jsonDecode(finalResponse)}');
    print('endPoint API response ------------------>\n $finalResponse');
    ///Return the API response data
    return jsonDecode(finalResponse);
  } catch (e) {
    print('$e');
  }
}

// Future<dynamic> callMultipartAPI(Map<String, String> body, String endPoint,
//     {bool isToken = false, String token = '', bool isFullUrl = false}) async {
//   print('Request Body ------------------>\n ${body.toString()}');
//   print('url ------------------>\n $baseURL/$endPoint');
//   var headers = {
//     // "Content-Type": "multipart/form-data",
//     // 'accept': 'text/plain',
//     'Authorization': token
//   };
//
//   print('Header ------------------>\n ${headers.toString()}');
//   var request = http.MultipartRequest('POST', Uri.parse('$baseURL/$endPoint'));
//   request.fields.addAll(body);
//
//   request.headers.addAll(headers);
//
//   http.StreamedResponse response = await request.send();
//   print(response.reasonPhrase);
//   if (response.statusCode == 200) {
//     String data = await response.stream.bytesToString();
//     print('Api Response data --> ${data.toString()}');
//     return jsonDecode(data);
//   } else {
//     print(response.reasonPhrase);
//   }
// }

/// ### This method is for multipart API call
/// * [endPoint] API url end point
/// * [imageFile] image file to send in the multipart
/// *[token] token to authentication the API call
Future<dynamic> callMultipartFileAPI(
    String endPoint,
    File imageFile, {
      /*bool isToken = false,*/
      String token = '',
      /*bool isFullUrl = false,*/
    }) async {
  print('url ------------------>\n $endPoint');
  ///Create the map to send in the API call header
  var headers = {
    "Content-Type": "multipart/form-data",
    'accept': 'text/plain',
    'Authorization': token
  };
  print('Header ------------------>\n ${headers.toString()}');
  ///Create the multipart request
  var request = http.MultipartRequest('POST', Uri.parse('$endPoint'));
  ///Add the file in the request
  request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));
  ///Add the header in the request
  request.headers.addAll(headers);

  ///Send the multipart request to the server
  http.StreamedResponse response = await request.send();
  print(response.reasonPhrase);
  if (response.statusCode == 200) {
    String data = await response.stream.bytesToString();
    print('Api Response data --> ${data.toString()}');
    ///Return the API response
    return jsonDecode(data);
  } else {
    print(response.reasonPhrase);
  }
}

// /// Delete Items
// Future<dynamic> callDeleteApi(Map<String, dynamic> body, String endPoint,
//     {bool isToken = false, String token = '', bool isFullUrl = false}) async {
//   final withToken = {
//     "Content-Type": "application/json",
//     "Authorization": token,
//   };
//
//   try {
//     final response = await http.post(
//       Uri.parse('$baseURL/$endPoint'),
//       headers: withToken,
//       // body: body,
//       body: jsonEncode(body),
//     );
//     print(
//         'API response ------------------------------->\n ${response.statusCode}');
//     print('API response ------------------------------->\n ${response.body}');
//     String finalResponse = response.body;
//     print(
//         'API final response ------------------------------->\n ${finalResponse.toString()}');
//     print(
//         'API request Header ------------------------------->\n ${response.headers}');
//     return jsonDecode(finalResponse);
//   } catch (e) {
//     print('$e');
//   }
// }
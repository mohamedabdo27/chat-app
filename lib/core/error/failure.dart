import 'package:dio/dio.dart';

abstract class Failure {
  final String error;

  Failure({required this.error});
}

class ServerFailure extends Failure {
  ServerFailure({required super.error});

  factory ServerFailure.fromDioException({
    required DioException dioExcepition,
  }) {
    switch (dioExcepition.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(error: "Connection time out");
      case DioExceptionType.sendTimeout:
        return ServerFailure(error: "Send time out");

      case DioExceptionType.receiveTimeout:
        return ServerFailure(error: "Receive time out");
      case DioExceptionType.badCertificate:
        return ServerFailure(
            error: "The certificate of the response is not approved.");

      case DioExceptionType.badResponse:
        return ServerFailure(error: dioExcepition.response!.data["message"]);
      // return ServerFailure.fromDioBadeResponse(
      //     statusCode: dioExcepition.response!.statusCode!,
      //     response: dioExcepition.response);
      case DioExceptionType.cancel:
        return ServerFailure(error: "Request to ApiServer was canceled");

      case DioExceptionType.connectionError:
        return ServerFailure(error: "No Internet Connection");

      case DioExceptionType.unknown:
        return ServerFailure(error: "Unexepected error, Please try later");

      default:
        return ServerFailure(error: "Opps there was an error");
    }
  }
  factory ServerFailure.fromDioBadeResponse(
      {required int statusCode, required dynamic response}) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(error: response["error"]["message"]);
    } else if (statusCode == 404) {
      return ServerFailure(error: "Your request not fount, Please try later!");
    } else if (statusCode == 500) {
      return ServerFailure(error: "Internal servere error, Please try later!");
    }
    return ServerFailure(error: "Opps there was an error");
  }
}

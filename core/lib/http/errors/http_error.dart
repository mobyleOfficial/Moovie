sealed class HttpError {
  final String message;

  const HttpError(this.message);
}

final class NetworkError extends HttpError {
  const NetworkError([super.message = 'No internet connection']);
}

final class TimeoutError extends HttpError {
  const TimeoutError([super.message = 'Request timed out']);
}

final class UnauthorizedError extends HttpError {
  const UnauthorizedError([super.message = 'Unauthorized']);
}

final class NotFoundError extends HttpError {
  const NotFoundError([super.message = 'Resource not found']);
}

final class ServerError extends HttpError {
  final int statusCode;

  const ServerError(this.statusCode, [super.message = 'Server error']);
}

final class UnknownError extends HttpError {
  const UnknownError([super.message = 'An unknown error occurred']);
}
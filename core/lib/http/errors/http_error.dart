enum AppError {
  network('No internet connection'),
  timeout('Request timed out'),
  unauthorized('Unauthorized'),
  notFound('Resource not found'),
  server('Server error'),
  unknown('An unknown error occurred');

  final String message;

  const AppError(this.message);
}

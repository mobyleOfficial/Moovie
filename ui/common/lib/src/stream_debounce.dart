import 'dart:async';

extension StreamDebounce<T> on Stream<T> {
  Stream<T> debounce(Duration duration) {
    Timer? timer;
    late StreamController<T> controller;

    controller = StreamController<T>(
      onListen: () {
        final subscription = listen(
          (event) {
            timer?.cancel();
            timer = Timer(duration, () => controller.add(event));
          },
          onError: controller.addError,
          onDone: () {
            timer?.cancel();
            controller.close();
          },
        );
        controller.onCancel = () {
          timer?.cancel();
          subscription.cancel();
        };
      },
    );

    return controller.stream;
  }
}

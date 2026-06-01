class FetchResult<T> {
  final T data;
  final int durationMs;

  const FetchResult({required this.data, required this.durationMs});
}

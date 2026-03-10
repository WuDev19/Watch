class NetworkHelper {
  NetworkHelper._();

  static Future<O> callApi<I, O>(
    Future<I> responseApi,
    O Function(I input) mapper,
  ) async {
    final result = await responseApi;
    return mapper(result);
  }

}

import 'package:chopper/chopper.dart';
import 'package:chopper_one_app/model/popular.dart';
import 'interceptor/header_interceptor.dart';
import 'converter/model_converter.dart';

part 'movie_service.chopper.dart';

@ChopperApi()
abstract class MovieService extends ChopperService {
  static MovieService create() {
    final client = ChopperClient(
      baseUrl: 'https://api.themoviedb.org/3',
      services: [
        _$MovieService(),
      ],
      interceptors: [
        //HeaderInterceptor(),
        HttpLoggingInterceptor(),
        (Request request) async {
          if (request.method == HttpMethod.Get) {
            chopperLogger.info('Performed a GET request');
          }
          return request;
        },
        (Response response) async {
          chopperLogger.info(response.statusCode.toString());
          return response;
        },
      ],
      /*converter: ModelConverter(),
      errorConverter: JsonConverter(),*/
    );
    return _$MovieService(client);
  }

  @Get(path: 'movie/popular?api_key=b161177d03774168afab88061eb8e2a2')
  Future<Response<Popular>> getPopularMovies();
}

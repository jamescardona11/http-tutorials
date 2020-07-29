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
      interceptors: [HeaderInterceptor(), HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: JsonConverter(),
    );
    return _$MovieService(client);
  }

  @Get(path: 'movie/popular')
  Future<Response<Popular>> getPopularMovies();
}

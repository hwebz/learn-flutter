part of 'init_dependencies.main.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnoKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());

  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => Hive.box(name: 'blogs'),
  );
}

void _initAuth() {
  serviceLocator
    // Data Source
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )
    // Use Cases
    ..registerFactory(
      () => UserSignUp(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogOut(
        authRepository: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
        userLogout: serviceLocator(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    // Data Source
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
        () => BlogLocalDataSourceImpl(box: serviceLocator()))
    // Repository
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
          blogRemoteDataSource: serviceLocator(),
          blogLocalDataSource: serviceLocator(),
          connectionChecker: serviceLocator(),
        ))
    // Use Cases
    ..registerFactory(
      () => UploadBlog(blogRepository: serviceLocator()),
    )
    ..registerFactory(
      () => GetAllBlogs(
        blogRepository: serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}

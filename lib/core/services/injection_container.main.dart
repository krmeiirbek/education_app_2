// ignore_for_file: lines_longer_than_80_chars
part of 'injection_container.dart';

/// This file sets up and initializes the dependency injection container (sl)
/// for your app. It configures various services and dependencies related to
/// different app features. By using dependency injection, you can efficiently
/// manage the creation and sharing of these services and dependencies throughout
/// your app, making it more modular and maintainable.

final sl = GetIt.instance;

/// Initializes the dependencies. This function is called at the start of the
/// app to set up all necessary dependencies.
Future<void> init() async {
  await _initOnBoarding();
  await _initAuth();
  await _initCourse();
  await _initVideo();
  await _initQuiz();
}

/// Initializes the onboarding-related dependencies.
Future<void> _initOnBoarding() async {
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )
    ..registerLazySingleton(() => CacheFirstTimer(sl()))
    ..registerLazySingleton(() => CheckIfUserIsFirstTimer(sl()))
    ..registerLazySingleton<OnBoardingRepo>(
      () => OnBoardingRepoImpl(sl()),
    )
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSrcImpl(sl()),
    )
    ..registerLazySingleton(() => prefs);
}

/// Initializes the authentication-related dependencies.
Future<void> _initAuth() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signIn: sl(),
        signUp: sl(),
        forgotPassword: sl(),
        updateUser: sl(),
      ),
    )
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => SignUp(sl()))
    ..registerLazySingleton(() => ForgotPassword(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

/// Initializes the course-related dependencies.
Future<void> _initCourse() async {
  sl
    ..registerFactory(
      () => CourseCubit(
        addCourse: sl(),
        getCourses: sl(),
      ),
    )
    ..registerLazySingleton(() => AddCourse(sl()))
    ..registerLazySingleton(() => GetCourses(sl()))
    ..registerLazySingleton<CourseRepo>(() => CourseRepoImpl(sl()))
    ..registerLazySingleton<CourseRemoteDataSrc>(
      () => CourseRemoteDataSrcImpl(
        firebaseFirestore: sl(),
        firebaseStorage: sl(),
        firebaseAuth: sl(),
      ),
    );
}

/// Initializes the video-related dependencies.
Future<void> _initVideo() async {
  sl
    ..registerFactory(() => VideoCubit(addVideo: sl(), getVideos: sl()))
    ..registerLazySingleton(() => AddVideo(sl()))
    ..registerLazySingleton(() => GetVideos(sl()))
    ..registerLazySingleton<VideoRepo>(() => VideoRepoImpl(sl()))
    ..registerLazySingleton<VideoRemoteDataSrc>(
      () => VideoRemoteDataSrcImpl(firestore: sl(), auth: sl(), storage: sl()),
    );
}

Future<void> _initQuiz() async {
  sl
    ..registerFactory(
      () => QuizCubit(
        addQuiz: sl(),
        getQuizzes: sl(),
        updateQuiz: sl(),
        deleteQuiz: sl(),
        addQuestion: sl(),
        getQuestions: sl(),
        updateQuestion: sl(),
        deleteQuestion: sl(),
        addAnswer: sl(),
        getAnswers: sl(),
        updateAnswer: sl(),
        deleteAnswer: sl(),
      ),
    )
    ..registerLazySingleton(() => AddQuiz(sl()))
    ..registerLazySingleton(() => GetQuizzes(sl()))
    ..registerLazySingleton(() => UpdateQuiz(sl()))
    ..registerLazySingleton(() => DeleteQuiz(sl()))
    ..registerLazySingleton(() => AddQuestion(sl()))
    ..registerLazySingleton(() => GetQuestions(sl()))
    ..registerLazySingleton(() => UpdateQuestion(sl()))
    ..registerLazySingleton(() => DeleteQuestion(sl()))
    ..registerLazySingleton(() => AddAnswer(sl()))
    ..registerLazySingleton(() => GetAnswers(sl()))
    ..registerLazySingleton(() => UpdateAnswer(sl()))
    ..registerLazySingleton(() => DeleteAnswer(sl()))
    ..registerLazySingleton<QuizRepo>(() => QuizRepoImpl(sl()))
    ..registerLazySingleton<QuizRemoteDataSrc>(
      () => QuizRemoteDataSrcImpl(
        firebaseFirestore: sl(),
        firebaseStorage: sl(),
        firebaseAuth: sl(),
      ),
    );
}

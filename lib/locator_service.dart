import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:furniture_company_bourgeois/feature/data/datasources/furniture_remote_data_source.dart';
import 'package:furniture_company_bourgeois/feature/data/repository/furniture_repository_impl.dart';
import 'package:furniture_company_bourgeois/feature/domain/repository/furniture_repository.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/cart/add_cart.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/cart/clear_cart.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/cart/get_cart.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/favorite/clear_favorite.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/favorite/favorite.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/favorite/get_favorite.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/get_all_furniture.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/shopping/add_shopping.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/shopping/get_shopping.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/create_user.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/get_current_uid.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/get_single_user.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/is_sign_in.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/sign_in_user.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/sign_out.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/sign_up_user.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/update_user.dart';
import 'package:furniture_company_bourgeois/feature/domain/usecases/user/upload_image_to_storage.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/auth_cubit/auth_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/cart_cubit/cart_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/credential_cubit/credential_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/favorite_cubit/favorite_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/furniture_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/get_single_user_cubit/get_single_user_cubit.dart';
import 'package:furniture_company_bourgeois/feature/presentation/bloc/shopping_cubit/shopping_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  
  sl.registerFactory(() => FurnitureCubit(getAllFurnitureUseCase: sl.call()));

  sl.registerFactory(() => AuthCubit(
      signOutUseCase: sl.call(),
      isSignInUseCase: sl.call(),
      getCurrentUidUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
        () => CredentialCubit(
      signUpUserUseCase: sl.call(),
      signInUserUseCase: sl.call(),
    ),
  );

  sl.registerFactory(
        () => GetSingleUserCubit(
        getSingleUserUseCase: sl.call(),
        updateUserUseCase: sl.call(),
    ),
  );

  sl.registerFactory(() => CartCubit(
      getCartUseCase: sl.call(),
      addCartUseCase: sl.call(),
      clearCartUseCase: sl.call(),
  ));

  sl.registerFactory(() => FavoriteCubit(
      favoriteUseCase: sl.call(),
      getFavoriteUseCase: sl.call(),
      clearFavoriteUseCase: sl.call(),
  ));

  sl.registerFactory(() => ShoppingCubit(
      addShoppingUseCase: sl.call(),
      getShoppingUseCase: sl.call(),
  ));



  //Furniture
  sl.registerLazySingleton(() => GetAllFurnitureUseCase(furnitureRepository: sl.call()));

  //User
  sl.registerLazySingleton(() => CreateUserUseCase(furnitureRepository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUseCase(furnitureRepository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUseCase(furnitureRepository: sl.call()));
  sl.registerLazySingleton(() => SignInUserUseCase(furnitureRepository: sl.call()));
  sl.registerLazySingleton(() => SignUpUserUseCase(furnitureRepository: sl.call()));
  sl.registerLazySingleton(() => SignOutUseCase(furnitureRepository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUseCase(furnitureRepository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUseCase(furnitureRepository: sl.call()));
  sl.registerLazySingleton(() => UploadImageToStorageUseCase(furnitureRepository: sl.call()));

  //Cart
  sl.registerLazySingleton(() => GetCartUseCase(furnitureRepository: sl.call()));
  sl.registerLazySingleton(() => AddCartUseCase(furnitureRepository: sl.call()));
  sl.registerLazySingleton(() => ClearCartUseCase(furnitureRepository: sl.call()));

  //Favorite
  sl.registerLazySingleton(() => FavoriteUseCase(furnitureRepository: sl.call()));
  sl.registerLazySingleton(() => GetFavoriteUseCase(furnitureRepository: sl.call()));
  sl.registerLazySingleton(() => ClearFavoriteUseCase(furnitureRepository: sl.call()));

  //Shopping
  sl.registerLazySingleton(() => AddShoppingUseCase(furnitureRepository: sl.call()));
  sl.registerLazySingleton(() => GetShoppingUseCase(furnitureRepository: sl.call()));

  
  sl.registerLazySingleton<FurnitureRepository>(() => FurnitureRepositoryImpl(remoteDataSource: sl.call()));
  
  sl.registerLazySingleton<FurnitureRemoteDataSource>(() => FurnitureRemoteDataSourceImpl(
      firebaseAuth: sl.call(),
      firebaseFirestore: sl.call(),
      firebaseStorage: sl.call(),
  ));

  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseStorage = FirebaseStorage.instance;
  final firebaseAuth = FirebaseAuth.instance;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseStorage);
  sl.registerLazySingleton(() => firebaseAuth);
}
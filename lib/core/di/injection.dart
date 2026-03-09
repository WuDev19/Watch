import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;
//cấu hình đầu tiên (giống như @HiltAndroidApp)
@InjectableInit(
  //chỉ định cách gọi ở bên dưới, nếu là setup thì bên dưới là getIt.setup()
  initializerName: 'init',
  // ưu tiên dùng import '../abc/def/ghi'; thay vì như này import 'package:get_it/get_it.dart';
  preferRelativeImports: true,
  asExtension: true, //cho phép gọi như extension function trong kotlin
)
Future<void> configurationDependencies(String env) async =>
    await getIt.init(environment: env); //nên có await vì khi về sau nếu có instance nào khởi tạo bất đồng bộ thì nó sẽ trả về Future<GetIt>

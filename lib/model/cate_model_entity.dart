import 'package:jdshop/generated/json/base/json_convert_content.dart';
import 'package:jdshop/generated/json/base/json_field.dart';

class CateModelEntity with JsonConvert<CateModelEntity> {
	List<CateModelResult> result;
}

class CateModelResult with JsonConvert<CateModelResult> {
	@JSONField(name: "_id")
	String sId;
	String title;
	String status;
	String pic;
	String pid;
	String sort;
}

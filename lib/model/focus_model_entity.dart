import 'package:jdshop/generated/json/base/json_convert_content.dart';
import 'package:jdshop/generated/json/base/json_field.dart';

class FocusModelEntity with JsonConvert<FocusModelEntity> {
	List<FocusModelResult> result;
}

class FocusModelResult with JsonConvert<FocusModelResult> {
	@JSONField(name: "_id")
	String sId;
	String title;
	String status;
	String pic;
	String url;
}

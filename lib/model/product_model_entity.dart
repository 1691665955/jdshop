import 'package:jdshop/generated/json/base/json_convert_content.dart';
import 'package:jdshop/generated/json/base/json_field.dart';

class ProductModelEntity with JsonConvert<ProductModelEntity> {
	List<ProductModelResult> result;
}

class ProductModelResult with JsonConvert<ProductModelResult> {
	@JSONField(name: "_id")
	String sId;
	String title;
	String cid;
	String price;
	@JSONField(name: "old_price")
	String oldPrice;
	String pic;
	@JSONField(name: "s_pic")
	String sPic;
}

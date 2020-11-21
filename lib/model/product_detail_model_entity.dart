import 'package:jdshop/generated/json/base/json_convert_content.dart';
import 'package:jdshop/generated/json/base/json_field.dart';

class ProductDetailModelEntity with JsonConvert<ProductDetailModelEntity> {
	ProductDetailModelResult result;
}

class ProductDetailModelResult with JsonConvert<ProductDetailModelResult> {
	@JSONField(name: "_id")
	String sId;
	String title;
	String cid;
	String price;
	@JSONField(name: "old_price")
	String oldPrice;
	@JSONField(name: "is_best")
	String isBest;
	@JSONField(name: "is_hot")
	String isHot;
	@JSONField(name: "is_new")
	String isNew;
	String status;
	String pic;
	String content;
	String cname;
	List<ProductDetailModelResultAttr> attr;
	@JSONField(name: "sub_title")
	String subTitle;
	int salecount;
}

class ProductDetailModelResultAttr with JsonConvert<ProductDetailModelResultAttr> {
	String cate;
	@JSONField(name: "list")
	List<String> xList;
	List<Map> attrList;
}

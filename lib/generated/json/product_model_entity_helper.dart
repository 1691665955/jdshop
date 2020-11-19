import 'package:jdshop/model/product_model_entity.dart';

productModelEntityFromJson(ProductModelEntity data, Map<String, dynamic> json) {
	if (json['result'] != null) {
		data.result = new List<ProductModelResult>();
		(json['result'] as List).forEach((v) {
			data.result.add(new ProductModelResult().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> productModelEntityToJson(ProductModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.result != null) {
		data['result'] =  entity.result.map((v) => v.toJson()).toList();
	}
	return data;
}

productModelResultFromJson(ProductModelResult data, Map<String, dynamic> json) {
	if (json['_id'] != null) {
		data.sId = json['_id']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['cid'] != null) {
		data.cid = json['cid']?.toString();
	}
	if (json['price'] != null) {
		data.price = json['price']?.toString();
	}
	if (json['old_price'] != null) {
		data.oldPrice = json['old_price']?.toString();
	}
	if (json['pic'] != null) {
		data.pic = json['pic']?.toString();
	}
	if (json['s_pic'] != null) {
		data.sPic = json['s_pic']?.toString();
	}
	return data;
}

Map<String, dynamic> productModelResultToJson(ProductModelResult entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['_id'] = entity.sId;
	data['title'] = entity.title;
	data['cid'] = entity.cid;
	data['price'] = entity.price;
	data['old_price'] = entity.oldPrice;
	data['pic'] = entity.pic;
	data['s_pic'] = entity.sPic;
	return data;
}
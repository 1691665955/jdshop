import 'package:jdshop/model/cate_model_entity.dart';

cateModelEntityFromJson(CateModelEntity data, Map<String, dynamic> json) {
	if (json['result'] != null) {
		data.result = new List<CateModelResult>();
		(json['result'] as List).forEach((v) {
			data.result.add(new CateModelResult().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> cateModelEntityToJson(CateModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.result != null) {
		data['result'] =  entity.result.map((v) => v.toJson()).toList();
	}
	return data;
}

cateModelResultFromJson(CateModelResult data, Map<String, dynamic> json) {
	if (json['_id'] != null) {
		data.sId = json['_id']?.toString();
	}
	if (json['title'] != null) {
		data.title = json['title']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toString();
	}
	if (json['pic'] != null) {
		data.pic = json['pic']?.toString();
	}
	if (json['pid'] != null) {
		data.pid = json['pid']?.toString();
	}
	if (json['sort'] != null) {
		data.sort = json['sort']?.toString();
	}
	return data;
}

Map<String, dynamic> cateModelResultToJson(CateModelResult entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['_id'] = entity.sId;
	data['title'] = entity.title;
	data['status'] = entity.status;
	data['pic'] = entity.pic;
	data['pid'] = entity.pid;
	data['sort'] = entity.sort;
	return data;
}
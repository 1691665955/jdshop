import 'package:jdshop/model/focus_model_entity.dart';

focusModelEntityFromJson(FocusModelEntity data, Map<String, dynamic> json) {
	if (json['result'] != null) {
		data.result = new List<FocusModelResult>();
		(json['result'] as List).forEach((v) {
			data.result.add(new FocusModelResult().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> focusModelEntityToJson(FocusModelEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.result != null) {
		data['result'] =  entity.result.map((v) => v.toJson()).toList();
	}
	return data;
}

focusModelResultFromJson(FocusModelResult data, Map<String, dynamic> json) {
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
	if (json['url'] != null) {
		data.url = json['url']?.toString();
	}
	return data;
}

Map<String, dynamic> focusModelResultToJson(FocusModelResult entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['_id'] = entity.sId;
	data['title'] = entity.title;
	data['status'] = entity.status;
	data['pic'] = entity.pic;
	data['url'] = entity.url;
	return data;
}
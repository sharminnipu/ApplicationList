class ApplicationModel {
 late int id;
 late String applicantName;
 late String weblink;
 late String linkType;
 late String linkTypeName;
 late String packageName;
 late String applicationType;
 late String applicationTypeName;
 late String paymentType;
 late String paymentTypeName;
 late String serveType;
 late String serviceTypeName;
 late String logoImg;
 late String introduction;
  late String createdBy;
 late String createdUserName;
 late String createdAt;

  ApplicationModel(
      this.id,
        this.applicantName,
        this.weblink,
        this.linkType,
        this.linkTypeName,
        this.packageName,
        this.applicationType,
        this.applicationTypeName,
        this.paymentType,
        this.paymentTypeName,
        this.serveType,
        this.serviceTypeName,
        this.logoImg,
        this.introduction,
        this.createdBy,
        this.createdUserName,
        this.createdAt);

  ApplicationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicantName = json['applicant_name'];
    weblink = json['weblink'];
    linkType = json['link_type'];
    linkTypeName = json['link_type_name'];
    packageName = json['package_name'];
    applicationType = json['application_type'];
    applicationTypeName = json['application_type_name'];
    paymentType = json['payment_type'];
    paymentTypeName = json['payment_type_name'];
    serveType = json['serve_type'];
    serviceTypeName = json['service_type_name'];
    logoImg = json['logo_img'];
    introduction = json['introduction'];
    createdBy = json['created_by'];
    createdUserName = json['created_user_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['applicant_name'] = this.applicantName;
    data['weblink'] = this.weblink;
    data['link_type'] = this.linkType;
    data['link_type_name'] = this.linkTypeName;
    data['package_name'] = this.packageName;
    data['application_type'] = this.applicationType;
    data['application_type_name'] = this.applicationTypeName;
    data['payment_type'] = this.paymentType;
    data['payment_type_name'] = this.paymentTypeName;
    data['serve_type'] = this.serveType;
    data['service_type_name'] = this.serviceTypeName;
    data['logo_img'] = this.logoImg;
    data['introduction'] = this.introduction;
    data['created_by'] = this.createdBy;
    data['created_user_name'] = this.createdUserName;
    data['created_at'] = this.createdAt;
    return data;
  }
}
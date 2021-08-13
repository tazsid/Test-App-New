class AllDataModel {
  int nProductUniqId;
  int nStateUniqId;
  String cStateName;
  String effectiveFrom;
  double productRate;
  String cAddedByAdminUserId;
  String addedTime;

  AllDataModel(
      {this.nProductUniqId,
      this.nStateUniqId,
      this.cStateName,
      this.effectiveFrom,
      this.productRate,
      this.cAddedByAdminUserId,
      this.addedTime});

  AllDataModel.fromJson(Map<String, dynamic> json) {
    nProductUniqId = json['n_product_uniq_id'];
    nStateUniqId = json['n_state_uniq_id'];
    cStateName = json['c_state_name'];
    effectiveFrom = json['effective_from'];
    productRate = double.parse(
        json['product_rate'] == null ? '0' : json['product_rate'].toString());
    cAddedByAdminUserId = json['c_added_by_admin_user_id'];
    addedTime = json['added_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['n_product_uniq_id'] = this.nProductUniqId;
    data['n_state_uniq_id'] = this.nStateUniqId;
    data['c_state_name'] = this.cStateName;
    data['effective_from'] = this.effectiveFrom;
    data['product_rate'] = this.productRate;
    data['c_added_by_admin_user_id'] = this.cAddedByAdminUserId;
    data['added_time'] = this.addedTime;
    return data;
  }
}

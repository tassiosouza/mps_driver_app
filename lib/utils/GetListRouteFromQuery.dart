import 'package:mps_driver_app/models/ModelProvider.dart';
import '../models/MpsRoute.dart';
import 'package:amplify_core/amplify_core.dart';
import '../models/RouteStatus.dart';

class GetListRouteFromQuery{
  List<MpsRoute> call(Map<String, dynamic>? routes) {
    final routesResult;
    if (routes != null) {
      routesResult = ListMpsRoutes.fromJson(routes);
      final ordersResult = [];
      routesResult.items!.forEach((r) {
        r.orders?.items2?.forEach((o) {
          ordersResult.add(MpOrder(
              status: MpsOrderStatus.values.firstWhere((e) =>
              e.toString() == 'MpsOrderStatus.' + o.status!),
              customer: Customer(name: o.customer!.name,
                  address: o.customer!.address, phone: ""),
              routeID: '',
              number: ''
          ));
        });
      });

      return routesResult.items!.map((r) {
        return MpsRoute(
            name: r.name ?? "",
            id: r.id,
            cost: r.cost?.toDouble(),
            startTime: TemporalTimestamp(
                DateTime.fromMicrosecondsSinceEpoch(r.startTime ?? 0)),
            endTime: TemporalTimestamp(
                DateTime.fromMicrosecondsSinceEpoch(r.endTime ?? 0)),
            status: RouteStatus.values.firstWhere((e) =>
            e.toString() == 'RouteStatus.${r.status ?? ""}'),
            orders: ordersResult as List<MpOrder>,
            distance: r.distance,
            duration: r.duration);
      }).toList();
    } else {
      return [];
    }
  }
}

class ListMpsRoutes {
  List<Items>? items;

  ListMpsRoutes({this.items});

  ListMpsRoutes.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  int? distance;
  String? id;
  String? status;
  int? endTime;
  int? duration;
  int? startTime;
  int? cost;
  Orders? orders;

  Items(
      {this.name,
        this.distance,
        this.id,
        this.status,
        this.endTime,
        this.duration,
        this.startTime,
        this.cost,
        this.orders});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    distance = json['distance'];
    id = json['id'];
    status = json['status'];
    endTime = json['endTime'];
    duration = json['duration'];
    startTime = json['startTime'];
    cost = json['cost'];
    orders =
    json['orders'] != null ? new Orders.fromJson(json['orders']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['distance'] = this.distance;
    data['id'] = this.id;
    data['status'] = this.status;
    data['endTime'] = this.endTime;
    data['duration'] = this.duration;
    data['startTime'] = this.startTime;
    data['cost'] = this.cost;
    if (this.orders != null) {
      data['orders'] = this.orders!.toJson();
    }
    return data;
  }
}

class Orders {
  List<Items2>? items2;

  Orders({this.items2});

  Orders.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items2 = <Items2>[];
      json['items'].forEach((v) {
        items2!.add(new Items2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items2 != null) {
      data['items'] = this.items2!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items2 {
  String? createdAt;
  Customer? customer;
  String? id;
  String? status;

  Items2({this.createdAt, this.customer, this.id, this.status});

  Items2.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['id'] = this.id;
    data['status'] = this.status;
    return data;
  }
}

class CustomerFromJson {
  String? address;
  String? name;

  CustomerFromJson({this.address, this.name});

  CustomerFromJson.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['name'] = this.name;
    return data;
  }
}
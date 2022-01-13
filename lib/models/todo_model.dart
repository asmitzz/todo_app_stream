class TodosModel {
  String id = "";
  String title = "";
  bool isComplete = false;

  TodosModel({
    required this.id,
    required this.title,
    required this.isComplete,
  });

  TodosModel.fromJson(json) {
    id = json.id;
    title = json['title'];
    isComplete = json['isComplete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['isComplete'] = isComplete;
    return data;
  }
}

final todosData = <TodosModel>[
   TodosModel(id:"1",title: "Learn Flutter", isComplete:false),
   TodosModel(id:"2",title: "Learn Dart", isComplete:true),
   TodosModel(id:"3",title: "Learn Js", isComplete:false),
];

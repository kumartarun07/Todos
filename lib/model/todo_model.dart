class TodoModel
{
  String title;
  String desc;
  int completed;
  String createAT;
  TodoModel({required this.createAT,required this.title,required this.desc,this.completed=0});

  factory TodoModel.fromMap(Map<String,dynamic>map)=>TodoModel(
      createAT: map['createAT'],
      title: map['title'],
      desc: map['desc'],
      completed: map['completed']);

  Map<String,dynamic>toMap()=>{
    'title':title,
    'createAT':createAT,
    'desc':desc,
    'completed':completed,
  };
}
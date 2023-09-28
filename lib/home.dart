import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //declaration de tout les variable
  double? poids;
  late bool genre=false;
  int? age=null;
  double taille=100.0;
  late int radioselection=0;
  Map mapActivity= {
    0:"faible",
    1:"moyenne",
    2:"forte",
  };
int? caloriebase;
int? CalorieActivity;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: new Scaffold(
          appBar: AppBar(
            backgroundColor: Setcolor(),
            title: Text(
              widget.title,
              style: new TextStyle(
                color: Colors.white
              ),
            ),
          ),
          body:new SingleChildScrollView(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                padding(),
                textAvecStyle(
                    "Rempliser le champs pour obtenir votre besoin journaler en calorie"),
                padding(),
                new Card(
                  elevation: 10.0,
                  child: new Column(
                    children: [
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          textAvecStyle("Femme",color: Colors.pink),
                          new Switch(
                              value: genre,
                              //activeColor: Setcolor(),
                              inactiveTrackColor: Setcolor(),
                              inactiveThumbColor: Colors.white,

                              activeTrackColor: Setcolor(),
                              //inactiveThumbColor: Setcolor(),
                              onChanged: (b){
                                setState(() {
                                  genre=b;
                                });
                              }
                          ),
                          textAvecStyle("Homme",color: Colors.blue)

                        ],
                      ),
                      padding(),
                      new ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Setcolor(),
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                        ),
                          onPressed: AfficherDatePicker,
                          child: textAvecStyle(age==null?"Choisir votre date de naissance":"Votre Age est:$age ans",color: Colors.white),
                      ),
                      padding(),
                      textAvecStyle("Votre taille est de : ${taille.toInt()} mm",color: Setcolor(),fontsize: 20.0),

                      new Slider(
                          activeColor: Setcolor(),
                          inactiveColor: Colors.white,
                          value: taille,
                          max: 215.0,
                          min:100.0,
                          onChanged: (double valeur){
                            setState(() {
                              taille=valeur;
                            });
                          }
                          ),
                      padding(),
                      new TextField(
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          labelText: "Entrer votre poid en Kilo  [kg]",
                          fillColor: Setcolor(),
                          hoverColor: Setcolor(),
                        ),
                        onChanged: (String string){
                          setState(() {
                            poids=double.tryParse(string);
                          });
                        },
                      ),
                      padding(),
                      textAvecStyle("Quelle est votre activiter Sportive",color: Setcolor()),
                      padding(),
                      rowradio(),
                      padding(),
                      new ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Setcolor(),
                          shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
                          padding: EdgeInsets.symmetric(horizontal: 100.0),
                        ),
                        onPressed: CalculerCal,
                        child: textAvecStyle("CALCULER",color: Colors.white,fontsize: 20.0),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
  //fontion divers
Text textAvecStyle(String data,{color=Colors.black,fontsize=15.0}){
    return Text(
      data,
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: color,
        fontSize: fontsize,
      ),
    );
}
Color Setcolor()=>genre==false?Colors.pink:Colors.blue;

  Future<Null> AfficherDatePicker() async{
    DateTime? choix =await  showDatePicker(
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: DateTime.now(),
        firstDate: DateTime(1930),
        lastDate: DateTime.now());
    if(choix!=null){
      print(choix);
      var difference=DateTime.now().difference(choix);
      var jours=difference.inDays;
      var ans=jours/365;
      print(ans);
      setState(() {
        age=ans.toInt();
      });
    }
  }
  Padding padding(){
    return Padding(padding: EdgeInsets.only(top: 20.0));
  }
  Row rowradio(){
      List<Widget> l=[];
      mapActivity.forEach((key, value) {
        Column colonne=new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Radio(
              activeColor: Setcolor(),
                value: key,
                groupValue: radioselection,
                onChanged: (i){
                  setState(() {
                    radioselection=i;
                  });
                }),
            textAvecStyle(value,color: Setcolor()),
          ],
        );
        l.add(colonne);
      });
      return new Row (
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: l,
      );
  }
  void CalculerCal(){
      print(genre);//pas de test
      print(age);
      print(taille);//pas de test
      print(poids);
      print(radioselection);//pas de test
    if(age==null && poids==null|| age ==null || poids==null){
      alert();
    }
    else{
      if(genre){
        caloriebase=(66.4730+(13.7516*poids!)+(5.0033*taille)-(6.7550*age!)).toInt();
      }
      else{
        caloriebase=(655.0955+(9.5634*poids!)+(1.8496*taille)-(6.6756*age!)).toInt();
      }
      switch (radioselection){
        case 0:
          CalorieActivity=(caloriebase!*1.2).toInt();
          break;
        case 1:
          CalorieActivity=(caloriebase!*1.3).toInt();
          break;
        case 2:
          CalorieActivity=(caloriebase!*1.4).toInt();
          break;
        default:
          CalorieActivity=caloriebase;
          break;
      }
      print(CalorieActivity);
      print(caloriebase);
      Dialogue();
    }
  }
  Future<Null> alert() async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: textAvecStyle("ERREUR",fontsize: 20.0,color: Setcolor()),
            content: textAvecStyle("Tout les champs ne sont pas remplie"),
            actions: <Widget>[
              new TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Setcolor(),
                ),
                  onPressed: (){
                    Navigator.pop(buildContext);
                  },
                  child: textAvecStyle("OK"))
            ],
          );
        });
  }
  Future<Null> Dialogue() async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return SimpleDialog(
            title: textAvecStyle("votre besoin de calorie",fontsize: 20.0,color: Setcolor()),
            contentPadding: EdgeInsets.all(15.0),
            children: <Widget>[
              padding(),
              textAvecStyle("Votre  besoin de base est de : $caloriebase"),
              padding(),
              textAvecStyle("votre besoin en activite sportive est : $CalorieActivity"),
              new TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Setcolor(),
                  ),
                  onPressed: (){
                    Navigator.pop(buildContext);
                  },
                  child: textAvecStyle("OK"))
            ],
          );
        });
  }
}//fin MyHomePageState

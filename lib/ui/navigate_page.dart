import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
class NavigatePage extends StatefulWidget {
  const NavigatePage({Key? key}) : super(key: key);

  @override
  _NavigatePageState createState() => _NavigatePageState();
}


class _NavigatePageState extends State<NavigatePage> {
  final myController=TextEditingController();
  final mytController=TextEditingController();

  StateMachineController? _controller;
  SMITrigger? a;
  SMITrigger? b;
  SMITrigger? c;
  SMITrigger? d;
  SMITrigger? e;
  SMITrigger? f;
  SMITrigger? g;
  SMITrigger? ab;
  SMITrigger? bc;
  SMITrigger? cd;
  SMITrigger? de;
  SMITrigger? ef;
  SMITrigger? af;
  SMITrigger? eg;
  SMITrigger? cg;
  SMINumber? numb;
  int flag=0;
  int source=0;

  @override
  void initState()
  {
    super.initState();
  }

  void temp()
  {
    if(flag==0)
    {
      source=value(_controller?.findInput("num").toString());
      flag=flag+1;
    }
    else
    {
      int destin=value(_controller?.findInput("num").toString());
      dijkstra(source, destin);
    }
  }

  void triger(int x)
  {
    if(x==0) a?.fire();
    if(x==1) b?.fire();
    if(x==2) c?.fire();
    if(x==3) d?.fire();
    if(x==4) e?.fire();
    if(x==5) f?.fire();
    if(x==6) g?.fire();
  }

  void trigerpath(int a,int b)
  {
    if((a==0 && b==1)||(a==1 && b==0)) ab?.fire();
    if((a==1 && b==2)||(a==2 && b==1)) bc?.fire();
    if((a==2&& b==3)||(a==3&& b==2)) cd?.fire();
    if((a==3&& b==4)||(a==4 && b==3)) de?.fire();
    if((a==4&&b==5)||(a==5 &&b==4)) ef?.fire();
    if((a==4&&b==6)||(a==6 &&b==4)) eg?.fire();
    if((a==2&&b==6)||(a==6&&b==2)) cg?.fire();
    if((a==0&&b==5)||(a==5 &&b==0)) af?.fire();
  }

  void dijkstra(int src ,int dest)
  {
    var l = List.generate(7, (i) => i);
    var graph=List.generate(7,(i)=>l);
    graph=[
      [0,1,0,0,0,3,0],
      [1,0,1,0,0,0,0],
      [0,1,0,1,0,0,1],
      [0,0,1,0,2,0,0],
      [0,0,0,2,0,2,1],
      [3,0,0,0,2,0,0],
      [0,0,1,0,1,0,0]
    ];
    var dist=List.generate(7,(i)=>i);
    var sptset=List.generate(7,(i)=>i);
    var posn=List.generate(7,(i)=>i);
    for(int i=0;i<7;i++)
    {
      dist[i]=9223372036;
      sptset[i]=0;
    }
    dist[src]=0;
    for(int count=0;count<6;count++)
    {
      int u=mindistance(dist,sptset);
      sptset[u]=1;
      for(int v=0;v<7;v++)
      {
        if(sptset[v]==0&&graph[u][v]!=0&&dist[u]!=9223372036
            && dist[u]+graph[u][v]<dist[v])
        {
          num d=dist[u]+graph[u][v];
          dist[v]=d.toInt();
          posn[v]=u;
        }
      }
    }
    printsol(dist,posn,src,dest);
  }

  int mindistance(var dist,var sptset)
  {
    num min=9223372036;
    int minindex=0;
    for(int v=0;v<7;v++)
    {
      if(sptset[v]==0 &&dist[v]<=min)
      {
        min=dist[v];
        minindex=v;
      }
    }
    return minindex;
  }

  void printsol(var dist,var posn,int src,int dest)
  {
    printpath(dest,posn,src);
    print(dest);
    triger(dest);
  }
  void printpath(int a,var posn,int src)
  {
    if(posn[a]==src) {
      print(posn[a]);
      triger(posn[a]);
      trigerpath(posn[a], a);
    }
    else
    {
      printpath(posn[a],posn,src);
      print(posn[a]);
      triger(posn[a]);
      trigerpath(posn[a], a);
    }
  }

  void change()=> dijkstra(value(myController.text.trim()),value(mytController.text.trim()));

  int value(String? s)
  {
    s?.trim();
    if(s=="1") return 0;
    if(s=="2") return 1;
    if(s=="3") return 2;
    if(s=="4") return 3;
    if(s=="5") return 4;
    if(s=="6") return 5;
    if(s=="7") return 6;
    return 0;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        body:SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children:<Widget>[
                SizedBox(height: 100,),
                Container(
                  child: Image.network('https://static.vecteezy.com/system/resources/thumbnails/001/265/747/small/blue-pin-in-showing-location-on-white-map.jpg'),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: myController,
                  decoration: const InputDecoration(
                      labelText: 'Source',
                      hintText: 'Enter your current place',
                      labelStyle:TextStyle(color: Colors.black,fontWeight: FontWeight.bold) ,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.black
                          )
                      )
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: mytController,
                  decoration: const InputDecoration(
                      labelText: 'Destination',
                      hintText: 'Enter your destination',
                      labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.grey,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                              width: 2.0,
                              color: Colors.black
                          )
                      )
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(vertical:10,horizontal: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:[
                        SizedBox(
                          width: 95,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    // Retrieve the text the that user has entered by using the
                                    // TextEditingController.
                                    content:
                                    SizedBox(
                                      width: 500,
                                      height: 300,
                                      child: GestureDetector(
                                        onTap: temp,
                                        child: RiveAnimation.asset('assets/map.riv',
                                          fit: BoxFit.fitWidth,
                                          stateMachines: ["State Machine 1"],
                                          onInit: (artboard){
                                            _controller=StateMachineController.fromArtboard(artboard,"State Machine 1");
                                            if(_controller==null) return;
                                            artboard.addController(_controller!);
                                            a=_controller?.findInput<bool>("entrance")as SMITrigger;
                                            b=_controller?.findInput<bool>("reception")as SMITrigger;
                                            c=_controller?.findInput<bool>("artifacts")as SMITrigger;
                                            d=_controller?.findInput<bool>("cafeteria")as SMITrigger;
                                            e=_controller?.findInput<bool>("theatre")as SMITrigger;
                                            f=_controller?.findInput<bool>("parking")as SMITrigger;
                                            g=_controller?.findInput<bool>("junction")as SMITrigger;
                                            ab=_controller?.findInput<bool>("12")as SMITrigger;
                                            bc=_controller?.findInput<bool>("23")as SMITrigger;
                                            cd=_controller?.findInput<bool>("34")as SMITrigger;
                                            de=_controller?.findInput<bool>("45")as SMITrigger;
                                            ef=_controller?.findInput<bool>("56")as SMITrigger;
                                            eg=_controller?.findInput<bool>("57")as SMITrigger;
                                            cg=_controller?.findInput<bool>("37")as SMITrigger;
                                            af=_controller?.findInput<bool>("16")as SMITrigger;
                                            numb=_controller?.findInput<num>("num")as SMINumber;
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            style:ButtonStyle(
                              textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 19.8)),
                              backgroundColor: MaterialStatePropertyAll(Colors.brown[200]),
                              // padding: MaterialStatePropertyAll(EdgeInsets.all(0)),
                            ) ,
                            child: Text(
                              'Start',
                              style: TextStyle(color: Colors.white,),
                            ),
                          ),
                        ),

                      ]
                  ),
                ),
                /*SizedBox(
                    height: 300,
                    width: 300,
                  )*/
              ],
            ),
          ),
        ),
      ),

    );
  }
}
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rive/rive.dart';

const List<String>list=<String>['entrance','reception','artifacts','restroom','illusions','auditorium','cafeteria'];

class NavigatePage extends StatefulWidget {
  const NavigatePage({Key? key}) : super(key: key);

  @override
  State<NavigatePage> createState() => _NavigatePageState();
}

class _NavigatePageState extends State<NavigatePage> {
  StateMachineController? _animcontrol;
  SMITrigger? ab;
  SMITrigger? bc;
  SMITrigger? cd;
  SMITrigger? de;
  SMITrigger? ef;
  SMITrigger? fg;
  SMITrigger? gh;
  SMITrigger? reset;

  int? flag=0;
  String sourc=list.first;
  String destin=list.first;
  var obj=1;
  @override
  void initState()
  {
    super.initState();
  }
  void dijkstra(int src ,int dest)
  {
    var l = List.generate(7, (i) => i);
    var graph=List.generate(7,(i)=>l);
    graph=[
      [0,4,0,0,0,0,3],
      [4,0,4,0,0,0,0],
      [0,4,0,3,0,0,0],
      [0,0,3,0,2,0,0],
      [0,0,0,2,0,5,0],
      [0,0,0,0,5,0,6],
      [3,0,0,0,0,6,0]
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
  }
  void printpath(int a,var posn,int src)
  {
    if(posn[a]==src) {
      print(posn[a]);
      trigerpath(posn[a], a);
    }
    else
    {
      printpath(posn[a],posn,src);
      print(posn[a]);
      trigerpath(posn[a], a);
    }
  }
  void trigerpath(int a,int b)
  {
    if((a==0 && b==1)||(a==1 && b==0)) ab?.fire();
    if((a==1 && b==2)||(a==2 && b==1)) bc?.fire();
    if((a==2&& b==3)||(a==3&& b==2)) cd?.fire();
    if((a==3&& b==4)||(a==4 && b==3)) de?.fire();
    if((a==4&&b==5)||(a==5 &&b==4)) ef?.fire();
    if((a==5&&b==6)||(a==6 &&b==5)) fg?.fire();
    if((a==6&&b==0)||(a==0 &&b==6)) gh?.fire();
  }
  int place(String s)
  {
    if(s=="entrance") return 0;
    if(s=="reception") return 1;
    if(s=="artifacts") return 2;
    if(s=="restroom") return 3;
    if(s=="illusions") return 4;
    if(s=="auditorium") return 5;
    if(s=="cafeteria") return 6;
    return 0;
  }
  void go(){
    // reset?.fire();
    dijkstra(place(sourc), place(destin));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Row(
              children: [
                SizedBox(width: 50,),
                DropdownButton<String>(
                  value: sourc,
                    items: list.map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(value:value,child: Text(value));
                    }).toList(),
                    onChanged: (String?value){
                    setState(() {
                      sourc=value!;
                     // dijkstra(place(sourc), place(dest));
                    });
                    }
                ),
                SizedBox(width: 50,),
                DropdownButton<String>(
                    value: destin,
                    items: list.map<DropdownMenuItem<String>>((String value){
                      return DropdownMenuItem<String>(value:value,child: Text(value));
                    }).toList(),
                    onChanged: (String?value){
                      setState(() {
                        destin=value!;
                       // dijkstra(place(sourc), place(dest));
                      });
                    }
                ),
              ],
            ),
            ElevatedButton(
                onPressed:go,
                child: Text("Go!")
            ),
            SizedBox(
              height: 500,
              width: 500,
              child: GestureDetector(
                onTap: (){},
                child:RiveAnimation.asset('assets/newmap-2.riv',
                  fit: BoxFit.fitWidth,
                  stateMachines: ["State Machine 1"],
                  onInit: (artboard){
                  _animcontrol=StateMachineController.fromArtboard(artboard, "State Machine 1");
                  if(_animcontrol==null) return;
                  artboard.addController(_animcontrol!);
                  ab=_animcontrol?.findInput<bool>("12")as SMITrigger;
                  bc=_animcontrol?.findInput<bool>("23")as SMITrigger;
                  cd=_animcontrol?.findInput<bool>("34")as SMITrigger;
                  de=_animcontrol?.findInput<bool>("45")as SMITrigger;
                  ef=_animcontrol?.findInput<bool>("56")as SMITrigger;
                  fg=_animcontrol?.findInput<bool>("67")as SMITrigger;
                  gh=_animcontrol?.findInput<bool>("71")as SMITrigger;
                  reset=_animcontrol?.findInput<bool>("reset")as SMITrigger;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

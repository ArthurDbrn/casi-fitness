import 'package:flutter/material.dart';
import 'package:fitness_tracker/models/activity.dart';

class ActivityList extends StatefulWidget{
  const ActivityList({required this.activities, super.key});

  final List<Activity> activities;

  @override
  State<ActivityList> createState() => _ActivityListState();
}

class _ActivityListState extends State<ActivityList>{
  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: widget.activities.length,
      itemBuilder: (context, index){
        final activity = widget.activities[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.green[100],
            ),
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top:6),
                      child: Text(
                        activity.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${activity.distance} meters in ${activity.time} seconds',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom:6),
                        child: Text(
                        activity.date,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(activity.type.toString().split(".")[1].toUpperCase(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),  
                ),
              ]
            )
          )
        );
      },
    );
  }
}
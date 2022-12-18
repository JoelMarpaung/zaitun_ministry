import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule/domain/entities/event.dart';
import '../../domain/entities/schedule.dart';
import '../bloc/schedule_data_bloc/schedule_data_bloc.dart';
import '../bloc/schedule_data_bloc/schedule_data_event.dart';
import '../bloc/schedule_data_bloc/schedule_data_state.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleDataBloc, ScheduleState>(
      builder: (context, state) {
        if (state is ScheduleEmpty) {
          BlocProvider.of<ScheduleDataBloc>(context)
              .add(const OnFetchDataSchedule());
          return Stack(
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              topTitle()
            ],
          );
        } else if (state is ScheduleLoading) {
          return Stack(
            children: [
              Center(
                child: CircularProgressIndicator(),
              ),
              topTitle()
            ],
          );
        } else if (state is ScheduleError) {
          return Stack(
            children: [
              Center(
                child: Text(state.message),
              ),
              topTitle()
            ],
          );
        } else if (state is ScheduleHasData) {
          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 100),
                child: buildListView(state.result),
              ),
              topTitle()
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget topTitle(){
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade900.withOpacity(0.9),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(1.0, 1.0), //(x,y)
              blurRadius: 30.0,
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Jadwal Radio',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView(Schedule data) {
    return RefreshIndicator(
      onRefresh: () async {
        // Call the onFetchDataSchedule event to refresh the data
        BlocProvider.of<ScheduleDataBloc>(context)
            .add(const OnFetchDataSchedule());
      },
      child: ListView.builder(
        itemCount: data.events.length,
        itemBuilder: (context, index) {
          String key = data.events.keys.toList()[index];
          List<Event>? events = data.events[key];
          return Column(
            children: [
              ExpansionTile(
                backgroundColor: Colors.blue.shade700,
                textColor: Colors.white,
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                collapsedBackgroundColor: Colors.blue.shade700,
                title: Text(
                  key[0].toUpperCase() + key.substring(1),
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                children: events!.map((event) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                      color: Colors.white, // set white background color
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 4,
                      child: ListTile(
                        title: Text(
                          event.name,
                          style: TextStyle(fontSize: 15),
                        ),
                        subtitle: Text(
                          '${event.startTime} - ${event.endTime}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(event.presenters.join(', ')),
                        contentPadding: const EdgeInsets.all(
                            15), // add padding inside the card
                        dense: true, // make the card act like a ListTile
                      ), // add a small shadow
                    ),
                  );
                }).toList(),
              ),
              const Divider(
                  color: Colors.blue,
                  thickness: 3,
                  indent: 5,
                  endIndent: 5,
                  height: 15), // add a divider between each expanded tile
            ],
          );
        },
      ),
    );
  }
}

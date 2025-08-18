String timeSplit(String? myTime){
  if(myTime == null){
    return '';
  }
  try{
    return "${myTime.split(":")[0]}:${myTime.split(":")[1]}";
  }catch(e){
    return '';
  }
}

String timeSplit12(String? myTime) {
  if (myTime == null || myTime.isEmpty) {
    return '';
  }
  
  try {
    // Split the input time into hours and minutes
    List<String> parts = myTime.split(":");
    int hour = int.parse(parts[0]);
    String minutes = parts[1];

    // Determine AM/PM
    String period = hour >= 12 ? 'PM' : 'AM';

    // Convert hour to 12-hour format
    hour = hour % 12;
    if (hour == 0) {
      hour = 12; // Handle midnight and noon cases
    }

    // Format the time in 12-hour format with AM/PM
    return "$hour:$minutes $period";
  } catch (e) {
    return '';
  }
}

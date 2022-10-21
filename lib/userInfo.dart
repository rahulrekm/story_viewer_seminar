import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'models/user_model.dart';

class UserInfo extends StatelessWidget{
  late final User user;
   UserInfo({required this.user,});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.0,
            backgroundColor: Colors.grey,
          backgroundImage: CachedNetworkImageProvider(user.profileImage),
        ),
        SizedBox(
          width: 10.0,
        ),
           Expanded(
            child: Text(user.name,style: TextStyle(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.bold),),
          ),
        IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.close,color: Colors.white,size: 30.0,)
        ),



      ],
    );
  }

}
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/feed_screen.dart';

import '../screens/add_post_screen.dart';

const webScreenSize = 600;

const staticProfileImage =
    "https://t4.ftcdn.net/jpg/02/15/84/43/240_F_215844325_ttX9YiIIyeaR7Ne6EaLLjMAmy4GvPC69.jpg";

const homeScreenPages = [
  FeedScreen(),
  Text('data'),
  AddPostScreen(),
  Text('data'),
  Text('data'),
];

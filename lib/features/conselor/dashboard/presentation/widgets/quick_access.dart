import 'package:apu_assignment/features/chat/presentation/screens/chat_list_screens.dart';
import 'package:apu_assignment/features/profile/presentation/screens/profile_screen.dart';
import 'package:apu_assignment/features/conselor/resources/presentation/screens/resources_screen.dart';
import 'package:flutter/material.dart';

class QuickAccess extends StatelessWidget {
const QuickAccess({super.key});
  @override
  Widget build(BuildContext context){
  return  GridView.count(
              crossAxisCount: 2,          
              shrinkWrap: true,           
              physics: const NeverScrollableScrollPhysics(), //Fixed
              mainAxisSpacing: 10,        
              crossAxisSpacing: 10,     
              childAspectRatio: 1.5,     
              children: [
                _buildQuickAccessBox(context, "Messages", Icons.message, Colors.green, const ChatListScreens(userUid: '',)), // TODO : Si Wei Change this
                _buildQuickAccessBox(context, "Resources", Icons.book, Colors.purple, const ResourceScreen()),
                _buildQuickAccessBox(context, "Profile", Icons.person, Colors.orange, const ProfileScreen()),
              ],
            );
         }

  Widget _buildQuickAccessBox(BuildContext context, String title, IconData icon, Color color, Widget targetPage) {
    return InkWell( 
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetPage),
        );
      },
      borderRadius: BorderRadius.circular(16),
    child: Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    )
    );
  }
  }
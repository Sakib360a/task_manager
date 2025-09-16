import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key, required this.color, required this.status,
  });
final Color color;
final String status;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 4,
            left: 24,
            right: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lorem Ipsum is simply dummy',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.only(right: 24),
                child: Text(
                  'stars whisper secrets across the sky time forgets nothing but forgives everything',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              SizedBox(height: 4),
              Text('Date: 09/09/2025'),
              //SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.zero,
                    width: 100,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/details_icon.png',
                          scale: 22,
                        ),
                      ),
                      //SizedBox(width: 4),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/delete_icon.png',
                          scale: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
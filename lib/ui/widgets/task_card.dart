import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.color,
    required this.status,
    required this.title,
    required this.description,
    required this.date,
    required this.onDelete,
    this.onStatusEdit,
  });

  final Color color;
  final String status;
  final String title;
  final String description;
  final String date;
  final Future<void> Function() onDelete;
  final VoidCallback? onStatusEdit;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
                widget.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(height: 4),
              Text('Date: ${widget.date}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.zero,
                    width: 100,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Text(
                      widget.status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: widget.onStatusEdit,
                        icon: Image.asset(
                          'assets/icons/details_icon.png',
                          scale: 22,
                        ),
                      ),
                      if (_isDeleting)
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator()),
                        )
                      else
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              _isDeleting = true;
                            });
                            await widget.onDelete();
                            if (mounted) {
                              setState(() {
                                _isDeleting = false;
                              });
                            }
                          },
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

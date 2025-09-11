import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc_app/core/theming/colors.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/holidays/data/holidays_model.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/holidays/logic/cubit/holidays_cubit.dart';
import 'package:lmc_app/features/for_all/drawer/drawer_navigations/holidays/logic/cubit/holidays_state.dart';

class HolidaysScreen extends StatefulWidget {
  const HolidaysScreen({Key? key}) : super(key: key);

  @override
  State<HolidaysScreen> createState() => _HolidaysScreenState();
}

class _HolidaysScreenState extends State<HolidaysScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HolidaysCubit>().fetchHolidays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Holidays'),
        backgroundColor: AppColors.lmcBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<HolidaysCubit, HolidaysState>(
        builder: (context, state) {
          if (state is HolidaysLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HolidaysSuccess) {
            return _buildSuccessView(state.holidays);
          } else if (state is HolidaysFailure) {
            return _buildErrorView(state.error);
          } else {
            return const Center(
              child: Text('Welcome to Holidays'),
            );
          }
        },
      ),
    );
  }

  Widget _buildSuccessView(HolidaysModel holidaysModel) {
    final holidays = holidaysModel.holidays ?? [];

    if (holidays.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<HolidaysCubit>().fetchHolidays();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: holidays.length,
        itemBuilder: (context, index) {
          return _buildHolidayCard(holidays[index]);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_busy,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No holidays scheduled',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for holiday announcements',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 100,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Unable to load holidays',
            style: TextStyle(
              fontSize: 18,
              color: Colors.red[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<HolidaysCubit>().fetchHolidays();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHolidayCard(Holidays holiday) {
    final isOngoing = _isHolidayOngoing(holiday);
    final isUpcoming = _isHolidayUpcoming(holiday);
    final isPast = _isHolidayPast(holiday);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: _getCardGradient(isOngoing, isUpcoming, isPast),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      holiday.name ?? 'Untitled Holiday',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _getTextColor(isOngoing, isUpcoming, isPast),
                      ),
                    ),
                  ),
                  _buildStatusChip(isOngoing, isUpcoming, isPast),
                ],
              ),
              const SizedBox(height: 12),
              
              if (holiday.description != null && holiday.description!.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.description, size: 16, color: Colors.grey[700]),
                          const SizedBox(width: 4),
                          Text(
                            'Description:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        holiday.description!,
                        style: TextStyle(
                          color: Colors.grey[800],
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.play_arrow, size: 16, color: Colors.green[700]),
                              const SizedBox(width: 4),
                              Text(
                                'Start Date:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(holiday.startDate),
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey[300],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 12),
                              Icon(Icons.stop, size: 16, color: Colors.red[700]),
                              const SizedBox(width: 4),
                              Text(
                                'End Date:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                              _formatDate(holiday.endDate),
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.white.withOpacity(0.8)),
                  const SizedBox(width: 4),
                  Text(
                    _getDurationText(holiday),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(bool isOngoing, bool isUpcoming, bool isPast) {
    String text;
    Color backgroundColor;
    Color textColor;
    IconData icon;

    if (isOngoing) {
      text = 'ONGOING';
      backgroundColor = Colors.green[600]!;
      textColor = Colors.white;
      icon = Icons.play_circle_filled;
    } else if (isUpcoming) {
      text = 'UPCOMING';
      backgroundColor = AppColors.lmcOrange;
      textColor = Colors.white;
      icon = Icons.schedule;
    } else {
      text = 'PAST';
      backgroundColor = Colors.grey[600]!;
      textColor = Colors.white;
      icon = Icons.history;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  LinearGradient _getCardGradient(bool isOngoing, bool isUpcoming, bool isPast) {
    if (isOngoing) {
      return LinearGradient(
        colors: [Colors.green[400]!, Colors.green[600]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else if (isUpcoming) {
      return LinearGradient(
        colors: [AppColors.lmcBlue, AppColors.lightLmcBlue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    } else {
      return LinearGradient(
        colors: [Colors.grey[400]!, Colors.grey[600]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );
    }
  }

  Color _getTextColor(bool isOngoing, bool isUpcoming, bool isPast) {
    return Colors.white;
  }

  bool _isHolidayOngoing(Holidays holiday) {
    if (holiday.startDate == null || holiday.endDate == null) return false;
    
    try {
      final now = DateTime.now();
      final startDate = DateTime.parse(holiday.startDate!);
      final endDate = DateTime.parse(holiday.endDate!);
      
      return now.isAfter(startDate) && now.isBefore(endDate.add(const Duration(days: 1)));
    } catch (e) {
      return false;
    }
  }

  bool _isHolidayUpcoming(Holidays holiday) {
    if (holiday.startDate == null) return false;
    
    try {
      final now = DateTime.now();
      final startDate = DateTime.parse(holiday.startDate!);
      
      return now.isBefore(startDate);
    } catch (e) {
      return false;
    }
  }

  bool _isHolidayPast(Holidays holiday) {
    if (holiday.endDate == null) return false;
    
    try {
      final now = DateTime.now();
      final endDate = DateTime.parse(holiday.endDate!);
      
      return now.isAfter(endDate.add(const Duration(days: 1)));
    } catch (e) {
      return false;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown';
    try {
      final date = DateTime.parse(dateString);
      final months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _getDurationText(Holidays holiday) {
    if (holiday.startDate == null || holiday.endDate == null) {
      return 'Duration unknown';
    }
    
    try {
      final startDate = DateTime.parse(holiday.startDate!);
      final endDate = DateTime.parse(holiday.endDate!);
      final duration = endDate.difference(startDate).inDays + 1;
      
      if (duration == 1) {
        return '1 day';
      } else {
        return '$duration days';
      }
    } catch (e) {
      return 'Duration unknown';
    }
  }
}
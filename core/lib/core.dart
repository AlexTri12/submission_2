library core;

// Utils
export 'utils/colors.dart';
export 'utils/constants.dart';
export 'utils/exception.dart';
export 'utils/failure.dart';
export 'utils/state_enum.dart';
export 'utils/text_styles.dart';
export 'utils/mapper/list_mapper.dart';
export 'utils/mapper/mapper.dart';
export 'utils/mapper/nullable_input_list_mapper.dart';
export 'utils/mapper/nullable_output_list_mapper.dart';

// Bloc
export 'package:core/bloc/state/search_state.dart';
export 'package:core/bloc/state/detail_state.dart';
export 'package:core/bloc/state/now_playing_state.dart';
export 'package:core/bloc/state/popular_state.dart';
export 'package:core/bloc/state/top_rated_state.dart';
export 'package:core/bloc/state/watchlist_state.dart';
export 'package:core/bloc/state/detail_recommendation_state.dart';
export 'package:core/bloc/state/detail_watchlist_status.dart';

export 'package:core/bloc/event/search_event.dart';
export 'package:core/bloc/event/detail_event.dart';
export 'package:core/bloc/event/now_playing_event.dart';
export 'package:core/bloc/event/popular_event.dart';
export 'package:core/bloc/event/top_rated_event.dart';
export 'package:core/bloc/event/watchlist_event.dart';
export 'package:core/bloc/event/detail_recommendation_event.dart';
export 'package:core/bloc/event/detail_watchlist_event.dart';

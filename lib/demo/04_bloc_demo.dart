import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'shared/follow_card.dart';

// ===== EVENT =====
sealed class FollowEvent {
  const FollowEvent();
}

final class FollowToggled extends FollowEvent {
  const FollowToggled();
}

// ===== STATE (Equatable: dua state dengan isi sama dianggap sama) =====
class FollowState extends Equatable {
  const FollowState({this.isFollowing = false, this.followers = 1200});

  final bool isFollowing;
  final int followers;

  FollowState copyWith({bool? isFollowing, int? followers}) => FollowState(
        isFollowing: isFollowing ?? this.isFollowing,
        followers: followers ?? this.followers,
      );

  @override
  List<Object> get props => [isFollowing, followers];
}

// ===== BLOC: event masuk → state keluar =====
class FollowBloc extends Bloc<FollowEvent, FollowState> {
  FollowBloc() : super(const FollowState()) {
    on<FollowToggled>((event, emit) {
      final following = !state.isFollowing;
      emit(state.copyWith(
        isFollowing: following,
        followers: state.followers + (following ? 1 : -1),
      ));
    });
  }
}

void main() => runApp(
      MaterialApp(
        theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
        home: BlocProvider(
          create: (_) => FollowBloc(),
          child: const BlocDemo(),
        ),
      ),
    );

class BlocDemo extends StatelessWidget {
  const BlocDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocListener: untuk side effect (Snackbar)
    return BlocListener<FollowBloc, FollowState>(
      listenWhen: (prev, curr) => prev.isFollowing != curr.isFollowing,
      listener: (context, state) => showFollowSnack(context, state.isFollowing),
      child: Scaffold(
        appBar: AppBar(title: const Text('4 · Bloc')),
        body: Center(
          // BlocBuilder: menggambar UI dari state
          child: BlocBuilder<FollowBloc, FollowState>(
            builder: (context, state) => FollowCard(
              name: 'Fakhry Firdaus',
              followers: state.followers,
              isFollowing: state.isFollowing,
              onFollowPressed: () =>
                  context.read<FollowBloc>().add(const FollowToggled()),
            ),
          ),
        ),
      ),
    );
  }
}

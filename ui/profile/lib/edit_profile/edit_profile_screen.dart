import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_ui/edit_profile/edit_profile_bloc.dart';
import 'package:profile_ui/edit_profile/edit_profile_state.dart';
import 'package:profile_ui/edit_profile/filmow_login_webview.dart';

class EditProfileScreen extends StatefulWidget {
  final EditProfileCubit cubit;

  const EditProfileScreen({super.key, required this.cubit});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _usernameController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    final state = widget.cubit.state;
    _usernameController = TextEditingController(
      text: state is EditProfileReady ? state.username : '',
    );
    _bioController = TextEditingController(
      text: state is EditProfileReady ? state.bio : '',
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _startFilmowImport() async {
    final result = await Navigator.of(context).push<FilmowLoginResult>(
      MaterialPageRoute(builder: (_) => const FilmowLoginWebview()),
    );
    if (result == null || !mounted) return;

    widget.cubit.importFromSource(
      source: 'filmow',
      username: result.username,
      cookies: result.cookies,
    );
  }

  Future<void> _onClose() async {
    final updatedProfile = await widget.cubit.saveIfChanged();
    if (mounted) {
      Navigator.of(context).pop(updatedProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          icon: const Icon(Icons.close),
          onPressed: _onClose,
        ),
        title: Text(l10n?.profileEditProfile ?? ''),
        centerTitle: true,
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) async {
          if (didPop) return;
          await _onClose();
        },
        child: BlocProvider.value(
          value: widget.cubit,
          child: BlocBuilder<EditProfileCubit, EditProfileState>(
            builder: (context, state) => switch (state) {
              EditProfileLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              EditProfileError(:final message) => MuuvieEmptyState(
                  title: l10n?.emptyStateErrorTitle ?? '',
                  message: message,
                ),
              EditProfileReady(
                :final photoUrl,
                :final isScraping,
              ) =>
                Expanded(
                  child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const SizedBox(height: 32),
                            _PhotoSection(
                              photoUrl: photoUrl,
                              colorScheme: colorScheme,
                              textTheme: textTheme,
                              l10n: l10n,
                              onChangePhoto: () =>
                                  widget.cubit.onPhotoUrlChanged(''),
                            ),
                            const SizedBox(height: 32),
                            _ProfileTextField(
                              controller: _usernameController,
                              label: l10n?.editProfileUsernameLabel ?? '',
                              placeholder:
                                  l10n?.editProfileUsernamePlaceholder ?? '',
                              onChanged: widget.cubit.onUsernameChanged,
                            ),
                            const SizedBox(height: 16),
                            _ProfileTextField(
                              controller: _bioController,
                              label: l10n?.editProfileBioLabel ?? '',
                              placeholder:
                                  l10n?.editProfileBioPlaceholder ?? '',
                              onChanged: widget.cubit.onBioChanged,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 32),
                            _ImportSection(
                              isScraping: isScraping,
                              onImportFilmow: _startFilmowImport,
                              onImportLetterboxd: () {},
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),
            },
          ),
        ),
      ),
    );
  }
}

class _ImportSection extends StatelessWidget {
  final bool isScraping;
  final VoidCallback onImportFilmow;
  final VoidCallback onImportLetterboxd;

  const _ImportSection({
    required this.isScraping,
    required this.onImportFilmow,
    required this.onImportLetterboxd,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Importar dados',
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: isScraping ? null : onImportFilmow,
            icon: const Icon(Icons.download),
            label: const Text('Importar dados do Filmow'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: isScraping ? null : onImportLetterboxd,
            icon: const Icon(Icons.download),
            label: const Text('Importar dados do Letterboxd'),
          ),
        ),
      ],
    );
  }
}

class _PhotoSection extends StatelessWidget {
  final String photoUrl;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final AppLocalizations? l10n;
  final VoidCallback onChangePhoto;

  const _PhotoSection({
    required this.photoUrl,
    required this.colorScheme,
    required this.textTheme,
    required this.l10n,
    required this.onChangePhoto,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Semantics(
            label: l10n?.editProfileChangePhoto ?? '',
            button: true,
            child: GestureDetector(
              onTap: onChangePhoto,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: colorScheme.secondaryContainer,
                    backgroundImage:
                        photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
                    child: photoUrl.isEmpty
                        ? Icon(
                            Icons.person,
                            size: 52,
                            color: colorScheme.onSecondaryContainer,
                          )
                        : null,
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: onChangePhoto,
            child: Text(
              l10n?.editProfileChangePhoto ?? '',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      );
}

class _ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final ValueChanged<String> onChanged;
  final int maxLines;

  const _ProfileTextField({
    required this.controller,
    required this.label,
    required this.placeholder,
    required this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          textInputAction:
              maxLines > 1 ? TextInputAction.newline : TextInputAction.next,
          style: TextStyle(color: colorScheme.onSurface),
          cursorColor: colorScheme.primary,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.primary),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}

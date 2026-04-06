import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reviews/review_details/review_details_bloc.dart';
import 'package:reviews/review_details/review_details_state.dart';

class ReviewDetailsScreen extends StatelessWidget {
  final ReviewDetailsCubit cubit;
  final String movieTitle;
  final String reviewDate;
  final double rating;
  final int posterColorIndex;
  const ReviewDetailsScreen({
    super.key,
    required this.cubit,
    required this.movieTitle,
    required this.reviewDate,
    required this.rating,
    required this.posterColorIndex,
  });

  Color _posterColor(ColorScheme colorScheme) => switch (posterColorIndex % 4) {
    0 => colorScheme.tertiaryContainer,
    1 => colorScheme.primaryContainer,
    2 => colorScheme.secondaryContainer,
    _ => colorScheme.surfaceContainerHighest,
  };

  static String _reviewBody(String title) => switch (title) {
    'Dune: Part Two' =>
    'Denis Villeneuve\'s sequel surpasses its predecessor in almost every way. '
        'The sweeping desert landscapes and thunderous sound design create an immersive world that '
        'demands to be seen on the biggest screen possible. Chalamet and Zendaya carry the weight '
        'of the story with conviction, while the action sequences are among the most breathtaking '
        'in recent science fiction cinema.\n\n'
        'The adaptation makes bold choices that deepen the thematic resonance of Herbert\'s vision '
        'without losing the spectacle. A rare blockbuster that treats its audience as intelligent.',
    'Oppenheimer' =>
    'Nolan\'s most ambitious film yet is a staggering achievement in filmmaking. '
        'The IMAX sequences depicting the Trinity test are genuinely awe-inspiring, and Cillian Murphy '
        'delivers a career-defining performance as the conflicted physicist.\n\n'
        'The non-linear structure initially feels disorienting but ultimately serves the story beautifully, '
        'mirroring Oppenheimer\'s own fractured psychology. At three hours, it never drags. A genuine '
        'masterpiece that will be studied for decades.',
    'Poor Things' =>
    'Lanthimos constructs a darkly comic fairy tale that is unlike anything else released this year. '
        'Emma Stone is extraordinary, embodying Bella\'s rapid intellectual and emotional development '
        'with fearless physicality and wit.\n\n'
        'The production design is an imaginative feast, blending Victorian aesthetics with surrealist '
        'flourishes. Some viewers may find its provocations exhausting, but for those on its wavelength, '
        'it is wickedly funny and surprisingly moving.',
    'The Zone of Interest' =>
    'Glazer\'s Holocaust drama is one of the most formally radical films in recent memory. '
        'By refusing to show the horror directly and instead focusing on the mundane domestic life '
        'of Höss and his family, the film implicates the viewer in disturbing ways.\n\n'
        'The sound design does much of the horrifying work. A challenging, essential work that '
        'demands patience but rewards it with devastating effect.',
    'Society of the Snow' =>
    'Bayona\'s survival epic is a brutal, respectful tribute to the Andes survivors. '
        'The film is technically stunning, recreating the harsh mountain environment with '
        'oppressive authenticity, while the ensemble cast grounds the story in human dignity.\n\n'
        'Where other survival films might sensationalize, this one reflects. It is sometimes '
        'difficult to watch, but it is ultimately a film about hope and the bonds that sustain us.',
    'Past Lives' =>
    'Celine Song\'s debut feature is quietly devastating. The film traces the relationship '
        'between two childhood friends across twenty-four years with extraordinary restraint and '
        'emotional intelligence.\n\n'
        'Greta Lee and Teo Yoo give performances of remarkable subtlety. The final scene, which '
        'is almost entirely composed of faces and silence, is one of the most heartbreaking '
        'sequences of recent cinema. A deeply personal and universal film.',
    'Anatomy of a Fall' =>
    'Triet\'s Palme d\'Or winner is a gripping legal thriller that is also a devastating '
        'portrait of a marriage. Sandra Hüller is extraordinary as a woman whose guilt or '
        'innocence the film deliberately leaves ambiguous.\n\n'
        'The courtroom scenes crackle with tension, and the script is mercilessly intelligent '
        'in the way it dissects how we construct narratives about other people\'s lives. '
        'One of the most sophisticated films of the year.',
    'The Holdovers' =>
    'Alexander Payne\'s warm, funny character piece is the kind of old-fashioned quality '
        'filmmaking that rarely gets made anymore. Paul Giamatti is at his curmudgeonly best, '
        'matched stride for stride by Da\'Vine Joy Randolph in an Oscar-winning performance.\n\n'
        'The film takes its time establishing its three central characters before bringing '
        'them together, and the patience pays off in a final act of genuine emotional '
        'generosity. A deeply satisfying film.',
    'The Brutalist' =>
    'Brady Corbet\'s three-and-a-half-hour epic is a genuine feat of ambition. '
        'Adrien Brody anchors the film as a Hungarian-Jewish architect who emigrates to America '
        'after the war, only to find the promised land full of its own compromises.\n\n'
        'The VistaVision cinematography is stunning, and the film\'s meditation on art, '
        'survival, and the American dream feels urgent and timeless.',
    'Anora' =>
    'Sean Baker\'s Palme d\'Or winner is a raucous, tender, and ultimately heartbreaking '
        'film about a young woman who marries a Russian oligarch\'s son on a whim.\n\n'
        'Mikey Madison is a revelation in the lead role, carrying the film through tonal '
        'shifts from comedy to chaos to genuine pathos. The final scene is extraordinary.',
    _ =>
    'A compelling and thoughtfully crafted film that rewards attentive viewing. '
        'The performances are uniformly strong, and the direction displays a confident '
        'command of tone and pacing.\n\n'
        'While not without its flaws, this is exactly the kind of cinema that reminds you '
        'why films matter. Recommended.',
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final posterColor = _posterColor(colorScheme);

    return BlocProvider.value(
      value: cubit,
      child: BlocBuilder<ReviewDetailsCubit, ReviewDetailsState>(
        builder: (context, state) => switch (state) {
          ReviewDetailsLoading() => const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
          ReviewDetailsError() => Scaffold(
            body: Center(child: Text(state.message)),
          ),
          ReviewDetailsSuccess() => Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExcludeSemantics(
                    child: Container(
                      width: double.infinity,
                      height: 220,
                      color: posterColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieTitle,
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Semantics(
                              label:
                              '${rating % 1 == 0 ? rating.toInt() : rating} out of 5 stars',
                              child: Row(
                                children: List.generate(5, (starIndex) {
                                  final isFilled =
                                      starIndex < rating.floor();
                                  final isHalf =
                                      !isFilled && starIndex < rating;
                                  return Icon(
                                    isHalf
                                        ? Icons.star_half
                                        : (isFilled
                                        ? Icons.star
                                        : Icons.star_border),
                                    size: 18,
                                    color: colorScheme.onTertiaryContainer,
                                  );
                                }),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              reviewDate,
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          l10n.reviewDetailsBodyTitle,
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _reviewBody(movieTitle),
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        },
      ),
    );
  }
}

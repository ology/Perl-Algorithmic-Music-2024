#!/usr/bin/env perl
use strict;
use warnings;

use MIDI::Util qw(setup_score set_chan_patch);
use Music::Scales qw(get_scale_MIDI);

my $score = setup_score(bpm => 120);

$score->synch(
  sub { bass($score) },
  sub { treble($score) },
) for 1 .. 4;

$score->write_score("$0.mid");

sub bass {
  my ($score) = @_;

  set_chan_patch($score, 0, 35);

  my @pitches = (
    get_scale_MIDI('C', 2, 'pentatonic'),
  );

  for my $n (1 .. 4) {
    my $pitch = $pitches[int rand @pitches];
    $score->n('hn', $pitch);
  }
}

sub treble {
  my ($score) = @_;

  set_chan_patch($score, 1, 0);

  my @pitches = (
    get_scale_MIDI('C', 4, 'major'),
    get_scale_MIDI('C', 5, 'major'),
  );

  for my $n (1 .. 4) {
    my $pitch = $pitches[int rand @pitches];
    $score->n('qn', $pitch);
  }
}

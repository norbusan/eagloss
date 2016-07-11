#!/usr/bin/perl

$^W = 1;
use strict;

use Text::CSV;

my $p = Text::CSV->new({ binary => 1 } )
  or die "Cannot use CSV: ".Text::CSV->error_diag ();
open my $fh, "<:encoding(utf8)", "books.csv" or die "error opening books.csv: $!";

open my $out, ">:encoding(utf8)", "books.bib" or die "error opening books.bib: $!";

# get rid of header
$p->getline($fh);
while (my $row = $p->getline( $fh ) ) {
  my $id = $row->[0];
  # name,hanzi,pinyin,notone,gloss,other,othernotone,description,inglossary
  my $hanzi  = $row->[1];
  my $pinyin = $row->[2];
  my $notone = $row->[3];
  my $gloss  = $row->[4];
  my $other  = $row->[5];
  my $othernotone = $row->[6];
  my $description = $row->[7];
  $description =~ s/\\comma\\ /, /g;
  $description =~ s/\\comma/,/g;
  my $inglossary = $row->[9];
  printf $out '@eabook{' . $id . ",\n";
  printf $out "  hanzi = \{$hanzi\},\n" if $hanzi;
  printf $out "  pinyin = \{$pinyin\},\n" if $pinyin;
  printf $out "  notone = \{$notone\},\n" if $notone;
  printf $out "  gloss = \{$gloss\},\n" if $gloss;
  printf $out "  other = \{$other\},\n" if $other;
  printf $out "  othernotone = \{$othernotone\},\n" if $othernotone;
  printf $out "  description = \{$description\},\n" if $description;
  printf $out "  inglossary = \{$inglossary\},\n" if $inglossary;
  printf $out "\}\n\n";
}



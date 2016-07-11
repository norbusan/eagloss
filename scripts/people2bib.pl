#!/usr/bin/perl

$^W = 1;
use strict;

use Text::CSV;

my $p = Text::CSV->new({ binary => 1 } )
  or die "Cannot use CSV: ".Text::CSV->error_diag ();
open my $fh, "<:encoding(utf8)", "people.csv" or die "error opening people.csv: $!";

open my $out, ">:encoding(utf8)", "people.bib" or die "error opening people.bib: $!";

# get rid of header
$p->getline($fh);
while (my $row = $p->getline( $fh ) ) {
  my $id = $row->[0];
  # hanzi,pinyin,notone,other,othernotone,wadegiles,description,index,inglossary
  my $hanzi  = $row->[1];
  my $pinyin = $row->[2];
  my $notone = $row->[3];
  my $other  = $row->[4];
  my $othernotone = $row->[5];
  my $wadegiles = $row->[6];
  my $description = $row->[7];
  $description =~ s/\\comma\\ /, /g;
  $description =~ s/\\comma/,/g;
  my $index = $row->[8];
  my $inglossary = $row->[9];
  printf $out '@person{' . $id . ",\n";
  printf $out "  hanzi = \{$hanzi\},\n" if $hanzi;
  printf $out "  pinyin = \{$pinyin\},\n" if $pinyin;
  printf $out "  notone = \{$notone\},\n" if $notone;
  printf $out "  other = \{$other\},\n" if $other;
  printf $out "  othernotone = \{$othernotone\},\n" if $othernotone;
  printf $out "  wadegiles = \{$wadegiles\},\n" if $wadegiles;
  printf $out "  description = \{$description\},\n" if $description;
  printf $out "  index = \{$index\},\n" if $index;
  printf $out "  inglossary = \{$inglossary\},\n" if $inglossary;
  printf $out "\}\n\n";
}



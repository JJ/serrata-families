#!/usr/bin/env raku

use JSON::Fast;

my %tractors = from-json slurp( "data-raw/colleganza-tractors.json");
my %stans = from-json slurp( "data-raw/colleganza-stans.json");

my $both = %tractors.keys() ∩ %stans.keys();

for $both.keys -> $family {
    say "$family ", %tractors{$family}, " ", %stans{$family};
}

my $only-stans = %stans.keys() ⊖ $both;

say $only-stans;

my $only-tractors = %tractors.keys() ⊖ $both;

say $only-tractors;

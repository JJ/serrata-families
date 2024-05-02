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

my @family-type= [];
@family-type.push: ["Family","Type"];
for $both.keys() -> $family {
    if ( $family ∈  $only-stans ) {
        @family-type.push: [$family, "Stans"];
    } elsif ( $family ∈  $only-tractors ) {
        @family-type.push: [$family, "Tractor" ];
    } else {
        @family-type.push: [$family, "Both" ];
    }
}

spurt("data-raw/colleganza-family-types.csv", @family-type.map( *.join(";")).join("\n"));

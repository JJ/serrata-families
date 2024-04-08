#!/usr/bin/env raku

use JSON::Fast;

my @family-date = "data-raw/families-data.txt".IO.lines;

my %dates-for-family;

for @family-date -> $line {
    my ( $beginning, $end ) = $line.split( "-" );

    my @fragments = $beginning.split(/\s+/);
    my $start = @fragments.pop;
    my $family = @fragments.join(" ");

    %dates-for-family{$family} = (
        start => $start,
        end => $end
    );
}

spurt("data-raw/families-great-council-date.json", to-json %dates-for-family);

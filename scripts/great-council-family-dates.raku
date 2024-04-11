#!/usr/bin/env raku

use JSON::Fast;

my @family-date = "data-raw/families-data.txt".IO.lines;

my %dates-for-family;

for @family-date -> $line {
    my ( $beginning, $end ) = $line.split( "-" );

    my @fragments = $beginning.split(/\s+/);
    my $start = @fragments.pop;
    my $family = @fragments.join(" ");

    if ( $family ~~ /\,/ ) {
        $family ~~ /\s* $<family-name> = [.+?] \s+ $<date> = [ \d+ ]\,/;
        say $<family-name>, ", ", $<date>;
        $family = ~$<family-name>;
        $start = ~$<date>;
    }

    %dates-for-family{$family} = (
        start => $start,
        end => $end
    );
}

spurt("data-raw/families-great-council-date.json", to-json %dates-for-family);

my @family-dates-csv = ["Family;Start;End\n"];
for %dates-for-family.keys() -> $family {
    my %dates = %dates-for-family{$family};
    @family-dates-csv.push: tclc($family) ~ "; " ~ %dates<start> ~ ";" ~
%dates<end> ~
            "\n";
}

spurt("data-raw/families-great-council-date.csv", @family-dates-csv);

#!/usr/bin/env raku

use Text::CSV;
use JSON::Fast;

my @rows = csv( in=> "data-raw/contract-family-year.csv", :headers("auto") );

my %stans-for;
my %tractors-for;
my $families = Set();
my %last-year-for;
my %total-contracts-for;

for @rows[0..*] -> %row {
    my $family = %row<Family>;
    $families ∪= $family;
    if %last-year-for{$family}:!exists {
        %last-year-for{$family} = %row<Year>
    } elsif %last-year-for{$family} < %row<Year> {
        %last-year-for{$family} = %row<Year>;
    }
    %total-contracts-for{$family}++;
}

say %last-year-for;
say %total-contracts-for;

# spurt( "data-raw/colleganza-families.json", to-json @all-families );

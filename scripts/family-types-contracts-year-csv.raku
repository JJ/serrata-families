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
    if %row{'Contract Type'} eq "stan" {
        %stans-for{$family}++;
    } else {
        %tractors-for{$family}++;
    }
}

my @contract-summary;
@contract-summary.push: ["Family","Total Contracts","Role","Last Year"];
for $families.keys() -> $family {
    my $role;
    if ( %stans-for{$family}:exists and %tractors-for{$family}:exists ) {
        $role = "both";
    } elsif (%stans-for{$family}:exists) {
        $role = "stan";
    } else {
        $role = "tractor";
    }
    @contract-summary.push: [$family, %total-contracts-for{$family}, $role,
                             %last-year-for{$family}];
}

csv( out=> "data-raw/contract-data-families.csv", in => @contract-summary);

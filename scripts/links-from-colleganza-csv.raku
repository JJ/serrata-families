#!/usr/bin/env raku

use Text::CSV;
use JSON::Fast;

my @rows = csv( in=> "data-raw/venice_colleganza.csv", :encoding("latin1"),
        :headers("auto") );

my @all-families;
my @all-pairs;
my %stans;
my %tractors;
my $gc-families = Set.new();
my %years-contracts;
my @self-loops;
@self-loops.push: ["Families", "Year"];
for @rows[0..*] -> %row {
    my @families = [];
    my $tractor-families = Set();
    my $stan-families = Set();
    for <tractor_familyname tractor_2_familyname stans_familyname stans_2_familyname> -> $key {
        my Str $std-name = "";
        if (%row{$key ~ "_std"}) {
            $std-name = %row{$key ~ "_std"}
        } elsif (%row{$key ~ "_italian"}) {
            $std-name = %row{$key ~ "_italian"}
        }

        if (%row{$key ~ "_std_gc"}) {
            $gc-families ∪= %row{$key ~ "_std_gc"};
        }

        if ($std-name ne "" and $std-name ne "unknown") {
            @families.push: $std-name;

            if $key ~~ /tractor/ {
                $tractor-families ∪= $std-name;
                if ( %tractors{$std-name} < %row<year> ) {
                    %tractors{$std-name} = %row<year>;
                }

                if ( ! %years-contracts{$std-name} ) {
                    %years-contracts{$std-name} = [];
                }
                %years-contracts{$std-name}.push: ["tractor", %row<year>];
            }

            if $key ~~ /stans/ {
                $stan-families ∪= $std-name;
                if ( %stans{$std-name} < %row<year> ) {
                    %stans{$std-name} = %row<year>;
                }

                if ( !%years-contracts{$std-name} ) {
                    %years-contracts{$std-name} = [];
                }
                %years-contracts{$std-name}.push: ["stan", %row<year>];

            }
        }
    }

    if $tractor-families ∩ $stan-families != ∅ {
        say %row;
        say $tractor-families ∩ $stan-families;
        @self-loops.push: [ $tractor-families ∩ $stan-families, %row<year> ];
    }
    @families = @families.grep: * ne "unknown";
    @all-families.push: @families;
    if (@families.elems >  1) {
        for @families.combinations(2) -> @pair {
            @all-pairs.push: [|@pair, %row<year>];
        }
    }
}

spurt( "data-raw/colleganza-families.json", to-json @all-families );
spurt( "data-raw/great-council-families.json", to-json $gc-families.keys());
spurt( "data-raw/colleganza-tractors.json", to-json %tractors);
spurt( "data-raw/colleganza-stans.json", to-json %stans);
spurt( "data-raw/colleganza-type-contract.json", to-json %years-contracts);
csv( out=> "data-raw/colleganza-pairs-date.csv", in => @all-pairs);
csv( out=> "data-raw/self-loop-families-colleganza.csv", in => @self-loops);

my @contracts-family-year = [];
@contracts-family-year.push: ["Family","Contract Type", "Year"];
my @contracts-changes = [];
@contracts-changes.push: ["Family","First","Last","Flips","Percentage"];
for %years-contracts.keys -> $family {
    my @contracts = %years-contracts{$family}.sort: *[1];
    for @contracts -> @contract {
        @contracts-family-year.push: [ $family, |@contract ];
    }

    my $flips = 0;
    if (@contracts.elems > 1) {
        for 1 .. @contracts.elems-1 -> $i {
            $flips++ if @contracts[$i][0] ne @contracts[$i - 1][0];
        }
    }
    @contracts-changes.push: [$family, @contracts[0][0], @contracts[*-1][0],
                              $flips, $flips/@contracts.elems ];
}

csv( out => "data-raw/contract-family-year.csv", in=> @contracts-family-year);
csv( out => "data-raw/contract-family-flips.csv", in=> @contracts-changes);

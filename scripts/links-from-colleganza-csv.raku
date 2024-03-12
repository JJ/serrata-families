#!/usr/bin/env raku

use Text::CSV;
use JSON::Fast;

my @rows = csv( in=> "data-raw/venice_colleganza.csv", :encoding("latin1"),
        :headers("auto") );

my @all-families;
my @all-pairs;
my $gc-families = Set.new();
for @rows[0..*] -> %row {
    my @families = [];
    for <tractor_familyname tractor_2_familyname stans_familyname stans_2_familyname> -> $key {
        if (%row{$key ~ "_std"}) {
            @families.push: %row{$key ~ "_std"}
        } elsif (%row{$key ~ "_italian"}) {
            @families.push: %row{$key ~ "_italian"}
        }
        if (%row{$key ~ "_std_gc"}) {
            $gc-families ∪= %row{$key ~ "_std_gc"};
        }
    }
    @families = @families.grep: * ne "unknown";
    @all-families.push: @families;
    next if (@families.elems <= 1);

    for @families.combinations( 2 ) -> @pair {
        next unless @pair;
        @all-pairs.push: [|@pair, %row<year>];
    }
}

spurt( "data-raw/colleganza-families.json", to-json @all-families );
spurt( "data-raw/great-council-families.json", to-json $gc-families.keys());
csv( out=> "data-raw/colleganza-pairs-date.csv", in => @all-pairs);

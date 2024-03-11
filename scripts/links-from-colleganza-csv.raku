#!/usr/bin/env raku

use Text::CSV;
use JSON::Fast;

my @rows = csv( in=> "data/venice_colleganza.csv", :encoding("latin1"),
        :headers("auto") );

my @all-families;
my @all-pairs;
for @rows[0..*] -> %row {
    my @families = [];
    for <tractor_familyname tractor_2_familyname stans_familyname stans_2_familyname> -> $key {
        if (%row{$key ~ "_std_gc"}) {
            @families.push: %row{$key ~ "_std_gc"}
        } elsif (%row{$key ~ "_italian"}) {
            @families.push: %row{$key ~ "_italian"}
        }
    }
    @all-families.push: @families;
    next if (@families.elems <= 1);

    for @families.combinations( 2 ) -> @pair {
        next unless @pair;
        @all-pairs.push: [|@pair, %row<year>];
    }
}

spurt( "data/colleganza-families.json", to-json @all-families );
csv( out=> "data/colleganza-pairs-date.csv", in => @all-pairs);

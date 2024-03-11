#!/usr/bin/env raku

use Text::CSV;

my @rows = csv( in=> "data/venice_colleganza.csv", :encoding("latin1"),
        :headers("auto") );

for @rows[0..*] -> %row {
    my @families = [];
    for <tractor_familyname tractor2_familyname stans_familyname stans2_familyname> -> $key {
        if (%row{$key ~ "_std_gc"}) {
            @families.push: %row{$key ~ "_std_gc"}
        } elsif (%row{$key ~ "_italian"}) {
            @families.push: %row{$key ~ "_italian"}
        }
    }
    say @families;
    next if (@families.elems <= 1);

    for @families.combinations( 2 ) -> @pair {
        next unless @pair;
        say @pair.map("\"" ~ * ~ "\"").join(","),",", %row<year>;
    }
}

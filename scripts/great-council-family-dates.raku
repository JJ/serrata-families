#!/usr/bin/env raku

use JSON::Fast;

my @family-date = "data-raw/families-data.txt".IO.lines;

my %dates-for-family;

my %normalizations = ( "Balestrieri 1301– dopo" => "Balestrieri",
                       "Benzon (s. agostin)" => "Banzon",
                       "Benzon (s. vidal)" => "Banzon",
                       "Boldù" => "Boldu",
                       "Brisi (brizi)" => "Brizi",
                       "Avanzago (d')" => "D'Avanzago",
                       "Canal (da)" => "Canal",
                       "Da fano" => "Da Fano",
                       "Dalla scala" => "Dalla Scala",
                       "Dalle sevole" => "Dalle Sevole",
                       "D'equilo" => "D'Equilo",
                       "Donà" => "Donato",
                       "Fontana (dalla)" => "Dalla Fontana",
                       "Griego (grego)" => "Grego",
                       "Polini nel" => "Polini",
                       "Maistrorso" => "Mastrorso",
                       "Molin" => "Da Molin",
                       "Mosto (da)" => "Mosto",
                       "Mula (da)" => "Da Mula",
                       "Stanier" => "Staniardo",
                       "Thomado" => "Tomato",
                       "Tolonegi (tanolico)" => "Tolonegi",
                       "Orso" => "Urso", # Orso is actually correct
                       "Zen" => "Zeno"
);

for @family-date -> $line {
    my ( $beginning, $end ) = $line.split( "-" );

    my @fragments = $beginning.split(/\s+/);
    my $start = @fragments.pop;
    my $family = @fragments.join(" ");

    if ( $family ~~ /\,/ ) {
        $family ~~ /\s* $<family-name> = [.+?] \s+ $<date> = [ \d+ ]\,/;
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
    my $ucfirst-family = tclc($family);
    if %normalizations{$ucfirst-family} {
        say "Normalizing $ucfirst-family";
        $ucfirst-family = %normalizations{$ucfirst-family};
    }
    @family-dates-csv.push: $ucfirst-family ~ "; " ~ %dates<start> ~ ";" ~
%dates<end> ~
            "\n";
}

spurt("data-raw/families-great-council-date.csv", @family-dates-csv);

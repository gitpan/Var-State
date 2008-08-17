#!perl

use strict;
use warnings;
use Var::State;
use Test::More;

plan tests => 9;

for my $type (qw/scalar array hash/) {
    for my $i (0..2) {
        is(eval "state_$type()", $i, "state_$type()=$i");
    }
}

sub state_scalar {
    my $x = 0;
    state $x;
    return $x++;
}

sub state_array {
    my @array = (0);
    state @array;
    return $array[0]++;
}

sub state_hash {
    my %hash = (x => 0);
    state %hash;
    return $hash{x}++;
}


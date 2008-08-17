
#==================
package Var::State;
#==================

use strict;
use warnings;
use Devel::Caller   qw/caller_vars/;
use Devel::LexAlias qw/lexalias/;
use PadWalker       qw/var_name/;

our $VERSION = 0.02;
my %__state_cache;

sub state { #=================================================================

    my $var  = (caller_vars(0))[0];
    my $name = var_name(1, $var);
    my $key  = join(";", (caller(0))[1,2], # caller file and linenumber
                         (caller(1))[0,3], # caller package and sub-name
                         $name,            # caller variable name
               );

    die "variable has no name!" unless(defined $name);

    if(exists $__state_cache{$key}) {
        lexalias(1, $name, $__state_cache{$key});
    }
    else { 
        $__state_cache{$key} = $var;
    }

    return;
}

sub import { #================================================================
    my $parent = caller(1);
    no strict 'refs';
    *{"${parent}::state"} = \&state;
    return;
}

#=============================================================================
1;

=head1 NAME

Var::State - state [variable]; in perl 5.8 - sort-of...

=head1 VERSION

0.02

=head1 SYNOPSIS

 use Var::State;

 sub foo {
     my $i = 0;
     state $i;
     return $i++;
 }

 print foo() for(0..10); # should print 0 to 10

=head1 FUNCTIONS

=head2 state(var)

IMPORTANT: READ BUGS AND LIMITATIONS!

Will make "var" (@var, $var, %var) static.

=head2 import

Will import C<state()> into the current namespace.

=head1 BUGS AND LIMITATIONS

Need to add state as a keyword, so you don't have to declare the variable
with my() first!
This exact problem breakes compatibility with 5.10's state, and therefor
t/11-state-5.10.t is not included in the test-suite - yet.

Please report any bugs or feature requests to
C<bug-var-state at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Var-State>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 AUTHOR

Jan Henning Thorsen, C<< <pm at flodhest.net> >>

=head1 COPYRIGHT & LICENSE

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

Copyright (c) 2007 Jan Henning Thorsen

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

=cut

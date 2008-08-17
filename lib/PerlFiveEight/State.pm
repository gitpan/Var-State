
#============================
package PerlFiveEight::State;
#============================

use strict;
use warnings;
use Devel::Caller   qw/caller_vars/;
use Devel::LexAlias qw/lexalias/;
use PadWalker       qw/var_name/;

our $VERSION = 0.2;
my %data;

sub state { #=================================================================
    die "state() takes only one arg!\n" unless(@_ == 1);

    my $var  = (caller_vars)[0];
    my $name = var_name(1, $var);
    my $key  = join ";", (caller(1))[3], $name;

    unless(exists $data{$key}) {
        $data{$key} = $var;
    }
    else { 
        lexalias(1, $name, $data{$key});
    }

    return;
}

sub import { #================================================================
    no strict 'refs';
    my $parent = caller(1);
    *{"${parent}::state"} = \&state;
}

#=============================================================================
1;

=head1 NAME

PerlFiveEight::State - state() in perl 5.8 (sort of...)

=head1 VERSION

0.2

=head1 SYNOPSIS

 use PerlFiveEight::State;

 sub foo {
     my $i = 0;
     state $i;
     return $i++;
 }

 print foo() for(0..10); # should print 0 to 10

=head1 FUNCTIONS

=head2 state(var)

Will make "var" (@var, $var, %var) static.

=head2 import

Will import &state into the current namespace.

=head1 AUTHOR

Jan Henning Thorsen, C<< <pm at flodhest.net> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-docsis-perl at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=DOCSIS-ConfigFile>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc DOCSIS::ConfigFile

You can also look for information at
L<http://search.cpan.org/dist/DOCSIS-ConfigFile>

=head1 ACKNOWLEDGEMENTS

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

DOCSIS is a registered trademark of Cablelabs, http://www.cablelabs.com

This module got its inspiration from the program docsis, http://docsis.sf.net.

=cut

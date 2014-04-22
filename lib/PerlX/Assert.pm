use 5.008001;
use strict;
use warnings;
no warnings qw( uninitialized void once );

package PerlX::Assert;

our $AUTHORITY = 'cpan:TOBYINK';
our $VERSION   = '0.900_01';

our $NO_KEYWORD_API;

my ($impl, $import);
sub import
{
	$import ||= do {
		$impl = eval {
			die if $NO_KEYWORD_API;
			require PerlX::Assert::Keyword;
			'PerlX::Assert::Keyword';
		}
		|| do {
			require PerlX::Assert::DD;
			'PerlX::Assert::DD';
		};
		$impl->can('import');
	};
	shift @_;
	unshift @_, $impl;
	goto $import;
}

sub should_be_active
{
	shift;
	my $active = 0+!!( $_[0] eq '-check' );
	$ENV{$_} && $active++ for qw/
		AUTHOR_TESTING
		AUTOMATED_TESTING
		EXTENDED_TESTING
		RELEASE_TESTING
	/;
	$active;
}

__PACKAGE__
__END__

=pod

=encoding utf-8

=for stopwords backported

=head1 NAME

PerlX::Assert - yet another assertion keyword

=head1 SYNOPSIS

   use PerlX::Assert;
   
   assert { 1 >= 10 };

=head1 DESCRIPTION

PerlX::Assert is a framework for embedding assertions in Perl code.
Under normal circumstances, assertions are not checked; they are
optimized away at compile time.

However if, at compile time, any of the following environment variables
is true, assertions are checked, and if they fail, throw an exception.

=over

=item *

C<AUTHOR_TESTING>

=item *

C<AUTOMATED_TESTING>

=item *

C<EXTENDED_TESTING>

=item *

C<RELEASE_TESTING>

=back

That is, assertions will only typically be checked when the test suite
is being run on the authors' machine, or being run by CPAN smoke testers.

You can also force assertions to be checked using:

   use PerlX::Assert -check;

There are four syntaxes for expressing assertions:

   assert EXPR;
   assert { BLOCK };
   assert "name", EXPR;
   assert "name" { BLOCK };

Assertions can be named, which is probably a good idea because this
module (and the rest of Moops) screws up Perl's reporting of line
numbers. Names must be a quoted string (single or double quotes, or
the C<q> or C<qq> quote-like operators); general expressions are not
supported because L<Text::Balanced> is used to parse the assertion
name. An assertion is a statement, so must be followed by a semicolon
unless it's the last statement in a block.

PerlX::Assert was originally distributed as part of L<Moops>, but was
fairly independent of the rest of it, and has been spun off as a
separate release, and backported to Perl 5.8.1.

Assertions that span multiple lines are very likely to cause problems
on versions of Perl prior to 5.12. If the C<assert> keyword, the
entire name, and the start of the expression or block are all on the
same line, this should be sufficient.

=head1 BUGS

Please report any bugs to
L<http://rt.cpan.org/Dist/Display.html?Queue=PerlX-Assert>.

=head1 SEE ALSO

L<Devel::Assert>, L<Carp::Assert>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013-2014 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

=pod

=encoding utf-8

=head1 PURPOSE

Check that the C<assert> keyword's L<Devel::Declare>-based
implementation, even on newer Perls.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013-2014 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

++$PerlX::Assert::NO_KEYWORD_API;
(my $file = __FILE__) =~ s/03dd/02kwapi/;
do($file);

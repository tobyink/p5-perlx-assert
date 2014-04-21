
my $new_perl = ($] >= 5.014);
my $backend  = $new_perl ? 'Keyword::Simple' : 'Devel::Declare';
my $extended = $ENV{AUTOMATED_TESTING} || $ENV{EXTENDED_TESTING};

$meta->{prereqs}{runtime}{requires}{$backend} =
	$meta->{prereqs}{runtime}{suggests}{$backend};

if ($new_perl and $extended and $meta->{version} =~ /_/)
{
	$meta->{prereqs}{test}{requires}{'Moops'} = '0.030';
}

package FFI::Platypus::Record::StringArray;

use strict;
use warnings;
use 5.008001;
use FFI::Platypus 0.96;
use constant _ptr_size => FFI::Platypus->new->sizeof('opaque');

# ABSTRACT: Array of strings for your FFI record
# VERSION

=head1 SYNOPSIS

 my $a = FFI::Platypus::Record::StringArray->new(qw( foo bar baz ));
 my $opaque = $a->opaque;

=head1 DESCRIPTION

Experimental interface for an array of C strings, useful for FFI record
classes.

=head1 CONSTRUCTOR

=head2 new

 my $a = FFI::Platypus::Record::StringArray->new(@a);

Creates a new array of C strings.

=cut

my $ffi;

sub new
{
  my $class = shift;

  $ffi ||= FFI::Platypus->new;

  my $perl_array = [map { defined $_ ? "$_" : undef } @_];
  my $array_size = _ptr_size * @_;
  my $type       = "record($array_size)";

  my $self = bless {
    perl_array => $perl_array,
    c_array    => $ffi->cast( 'string[]' => $type, $perl_array),
    type       => $type,
  }, $class;
}

=head1 METHODS

=head2 opaque

 my $opaque = $a->opaque;

Returns the opaque pointer to the array of C strings.

=cut

sub opaque
{
  my($self) = @_;
  my $type = $self->{type};
  $self->{opaque} ||= $ffi->cast( $type => 'opaque', $self->{c_array});
}

=head2 size

 my $size = $a->size;

Returns the number of elements in the array of C strings.

=cut

sub size
{
  my($self) = @_;
  scalar @{ $self->{perl_array} };
}

=head2 element

 my $element = $a->element($index);

Returns the string in the array of C strings at the given index.

=cut

sub element
{
  my($self, $index) = @_;
  $self->{perl_array}->[$index];
}

1;

package FFI::Platypus::Record::StringArray;

use strict;
use warnings;
use 5.008001;
use FFI::Platypus;
use constant _ptr_size => FFI::Platypus->new->sizeof('opaque');

# ABSTRACT: Array of strings for your FFI record
# VERSION

=head1 SYNOPSIS

 my $a = FFI::Platypus::Record::StringArray->new(qw( foo bar baz ));
 my $opaque = $a->opaque;

=head1 DESCRIPTION

Experimental interface for an array of C strings.

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

  my $self = bless {
    perl_array => $perl_array,
    c_array    => $ffi->cast( 'string[]' => "record($array_size)", $perl_array),
    array_size => $array_size,
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
  my $array_size = $self->{array_size};
  $self->{opaque} ||= $ffi->cast( "record($array_size)" => 'opaque', $self->{c_array});
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

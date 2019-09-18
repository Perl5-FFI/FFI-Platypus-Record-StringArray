package FFI::Platypus::Record::StringArray;

use strict;
use warnings;
use 5.008001;
use FFI::Platypus::Memory qw( strdup calloc free );
use constant _ptr_size => FFI::Platypus->new->sizeof('opaque');

# ABSTRACT: Array of strings for your FFI record
# VERSION

=head1 SYNOPSIS

 my $a = FFI::Platypus::Record::StringArray->new(qw( foo bar baz ));
 my $opaque = $a->opaque;

=head1 DESCRIPTION

Experimental interface for an array of C strings, useful for FFI record
classes.

The Platypus record class doesn't easily support an array of strings,
and trying to use an C<opaque> type to implement this is possible but more
than a little arcane.  This class provides an interface for creating
a C array of strings which can be used to provide an C<opaque> pointer
than can be used by an L<FFI::Platypus::Record> object.

Care needs to be taken!  Because Perl has no way of knowing if/when
the opaque pointer is no longer being used by C, you have to make
sure that the L<FFI::Platypus::Record::StringArray> instance remains
in scope for as long as the C<opaque> pointer is in use by C.

=head1 CONSTRUCTOR

=head2 new

 my $a = FFI::Platypus::Record::StringArray->new(@a);

Creates a new array of C strings.

=cut

my $ffi;

sub new
{
  my $class = shift;

  $ffi ||= FFI::Platypus->new( lib => [undef] );

  my $size       = @_;
  my $array      = [map { defined $_ ? strdup($_) : undef } @_, undef];
  my $opaque     = calloc($size, _ptr_size);

  $ffi->function(
    memcpy => [ 'opaque', "opaque[$size]", 'size_t' ] => 'opaque',
  )->call($opaque, $array, $size * _ptr_size);

  my $self = bless {
    array => $array,
    opaque => $opaque,
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
  $self->{opaque};
}

=head2 size

 my $size = $a->size;

Returns the number of elements in the array of C strings.

=cut

sub size
{
  my($self) = @_;
  scalar @{ $self->{array} } - 1;
}

=head2 element

 my $element = $a->element($index);

Returns the string in the array of C strings at the given index.

=cut

sub element
{
  my($self, $index) = @_;
  $ffi->cast( 'opaque' => 'string', $self->{array}->[$index] );
}

sub DESTROY
{
  my($self) = @_;
  free($_) for grep { defined $_ } @{ $self->{array} };
  free($self->{opaque});
}

1;

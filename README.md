# FFI::Platypus::Record::StringArray [![Build Status](https://travis-ci.org/PerlFFI/FFI-Platypus-Record-StringArray.svg)](http://travis-ci.org/PerlFFI/FFI-Platypus-Record-StringArray)

Array of strings for your FFI record

# SYNOPSIS

```perl
my $a = FFI::Platypus::Record::StringArray->new(qw( foo bar baz ));
my $opaque = $a->opaque;
```

# DESCRIPTION

Experimental interface for an array of C strings, useful for FFI record
classes.

The Platypus record class doesn't easily support an array of strings,
and trying to use an `opaque` type to implement this is possible but more
than a little arcane.  This class provides an interface for creating
a C array of strings which can be used to provide an `opaque` pointer
than can be used by an [FFI::Platypus::Record](https://metacpan.org/pod/FFI::Platypus::Record) object.

Care needs to be taken!  Because Perl has no way of knowing if/when
the opaque pointer is no longer being used by C, you have to make
sure that the [FFI::Platypus::Record::StringArray](https://metacpan.org/pod/FFI::Platypus::Record::StringArray) instance remains
in scope for as long as the `opaque` pointer is in use by C.

# CONSTRUCTOR

## new

```perl
my $a = FFI::Platypus::Record::StringArray->new(@a);
```

Creates a new array of C strings.

# METHODS

## opaque

```perl
my $opaque = $a->opaque;
```

Returns the opaque pointer to the array of C strings.

## size

```perl
my $size = $a->size;
```

Returns the number of elements in the array of C strings.

## element

```perl
my $element = $a->element($index);
```

Returns the string in the array of C strings at the given index.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2019 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

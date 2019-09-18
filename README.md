# FFI::Platypus::Record::StringArray [![Build Status](https://secure.travis-ci.org/Perl5-FFI/FFI-Platypus-Record-StringArray.png)](http://travis-ci.org/Perl5-FFI/FFI-Platypus-Record-StringArray)

Array of strings for your FFI record

# SYNOPSIS

    my $a = FFI::Platypus::Record::StringArray->new(qw( foo bar baz ));
    my $opaque = $a->opaque;

# DESCRIPTION

Experimental interface for an array of C strings, useful for FFI record
classes.

# CONSTRUCTOR

## new

    my $a = FFI::Platypus::Record::StringArray->new(@a);

Creates a new array of C strings.

# METHODS

## opaque

    my $opaque = $a->opaque;

Returns the opaque pointer to the array of C strings.

## size

    my $size = $a->size;

Returns the number of elements in the array of C strings.

## element

    my $element = $a->element($index);

Returns the string in the array of C strings at the given index.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2019 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

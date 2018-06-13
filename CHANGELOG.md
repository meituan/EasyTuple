# Changelog
All notable changes to this project will be documented in this file.

## [1.1.1] - 2018-06-13

### Fixed

- fix compile warning which named tuple's property is block
- fix  compile errors which named tuple's property is id<SomeProtocol>

## [1.1.0] - 2018-05-24

### Added

- named tuple
- you can create a named tuple with XXXNamedTupleMake
- named tuple have all tuple features

### Changed

- dictionary-like description

## [1.0.0] - 2017-09-27

## Added

- ZTuple macro to get a tuple
- using ordinal number properties to access item
- using subscripts to access items
- using for-in to access itmes
- support NSCopy protocol
- get count using '- (NSUInteger)count'
- take some items and drop some items to get a new tuple
- extend an item
- join two tuples
- convert a tuple to an array or vice versa an array to a tuple
- support tvOS and watchOS
- create a new tuple with +[ZTupleBase tupleWithCount:]

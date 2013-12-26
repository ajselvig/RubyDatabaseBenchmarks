# Ruby Database Benchmarks

These are some informal, unscientific benchmarks of accessing MongoDB and RethinkDB from Ruby.
The usual qualifiers apply: benchmarks are all flawed and you should take them with a grain of salt.

## Libraries

The current libraries being used are

* Moped (MongoDB low level driver)
* Mongoid (MongoDB ODM)
* Rethink (RethinkDB official driver)
* NoBrainer (RethinkDB ODM)

## Usage

Clone the project, run

	bundle install

and then

	bundle exec rake run

You need to have MongoDB and RethinkDB installed and running on the default ports.

## Description

The benchmarks are very simple. Only one document type is used (shown here in Mongoid schema):

	class Post
      include Mongoid::Document
      include Mongoid::Timestamps
      field :title, type: String
      field :body, type: String
      field :posted_at, type: Date
    end

For each library, a set of posts are inserted into the database.
Then some posts are read from the database using a random sampling of the inserted ids.
Finally, some updates are made to the posts.

After each set of operations, the time is measured and averaged to come up with an approximate execution time for each operation.

This is meant to be a benchmark of simple, individual operations. There are no indexes or batch operations involved.

# Latest Results

These are the latest results on my development machine (MacBook Pro with 2.4 GHz Core i5, 8 GB RAM, HDD):

	Performing 1000 inserts, 1000 reads, and 1000 updates.
    ruby 1.9.3p194 (2012-04-20 revision 35410) [x86_64-darwin12.2.0]

    :: Moped ::
    * db version v2.0.6, pdfile version 4.5 (safe: true)
    Total insert time: 0.74 seconds (1358.9 inserts/second)
    Total read time: 0.74 seconds (132187.7 reads/second)
    Total update time: 0.74 seconds (1352.7 updates/second)

    :: Mongoid ::
    Total insert time: 2.36 seconds (424.2 inserts/second)
    Total read time: 2.36 seconds (1005.0 reads/second)
    Total update time: 2.73 seconds (366.9 updates/second)

    Moped performs inserts at 320.3%, reads at 13152.7%, and updates at 368.6% the speed of Mongoid.

    :: Rethink ::
    * rethinkdb 1.10.0 (CLANG 5.0 (clang-500.2.79)) (durability: soft)
    Total insert time: 26.47 seconds (37.8 inserts/second)
    Total read time: 26.47 seconds (50.3 reads/second)
    Total update time: 29.55 seconds (33.8 updates/second)

    :: NoBrainer ::
    Total insert time: 28.94 seconds (34.6 inserts/second)
    Total read time: 28.94 seconds (19.5 reads/second)
    Total update time: 120.62 seconds (8.3 updates/second)

    Rethink performs inserts at 109.3%, reads at 258.6%, and updates at 408.2% the speed of NoBrainer.

# License

The MIT License (MIT)

Copyright (c) 2013 Andy Selvig

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
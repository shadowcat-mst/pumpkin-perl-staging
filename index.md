---
layout: default
description: "Pumpkin-perl-staging : Staging repostiory for the Pumpkin Perl patchset"
title: Pumpkin-perl-staging
---

### What

There still seems to be some confusion over exactly what I'm proposing
here, so the first step is to get that as clear as possible. Here's the
run down:

  1. I want to add a qualifier to the name of perl5 to make it clear that it has its own identity independent of the perl6 project.

  2. I propose as that qualifier 'Pumpkin' since this is the perl release managed by the pumpking, the holder of the patch pumpkin.

  3. I additionally propose that the 5 be elided from non technical references
     made from here on in - i.e. that while $] will stil be 5.something, our
     public facing material will say simply 'Pumpkin Perl'.

  4. This would be a renaming of the current production perl codebase;
     the changes to the 'perl' binary itself would be only those required to
     make -v and -V accurately reflect the name.

  5. This proposal neither endorses nor precludes any other technical change,
     but considers such changes to be out of the scope of this changeset.

  6. This is not a proposal for a fork. The intention is to land a changeset
     onto the existing blead, likely as soon after 5.18 ships as everything can
     be put into place.

  7. Other than the -v/-V changes, the changeset would be expected to contain
     only documentation updates to reflect the new name; technical disruption
     should be minimal, if there is any at all.

  8. The binary will still be called 'perl'. You can already install it as
     'pumpkin' if you wish, and as such there is no requirement to change the
     default.

  9. I am serious about other technical changes being out of scope. I
     encourage people to continue to discuss what defaults they would like to
     have in some future release, revision or distribution of perl but I am
     trying to relabel the bikeshed here; whether to build a second story and
     what colour to paint it is a separate conversation.

  10. This proposal's purpose is clarity of identity, no more and no less.
      It aims to provides a name that refers specifically to the Perl that people
      have been using for a quarter of a century, and frees us from the namespace
      collision problem that we're currently suffering from. That is all it does,
      and I consider that to be a feature.

### Why

Since people clearly have a lot of different things they would like to see,
and there have been a significant number of proposals within the same area
of late, I'm going to lay out exactly why I believe that you, dear reader,
should be in support of this specific proposal:

If you believe that perl5 is a language with its own identity, community
and future independently of perl6:

You should support this proposal because it will help clarify this fact to
the outside world, and give us a solid place to stand that belongs to us
from which to build that future.

If you believe that perl5 should have the capacity to release its own major
versions:

You should support this proposal because the perl7 idea has already been
publically stated to be unacceptable, whereas I can state with confidence
that neither rjbs, our pumpking, nor Larry, our creator, will veto this
proposal outright when the time comes.

If you believe that perl5 should rename away from the word perl entirely:

You should support this proposal because it will provide you with the
opportunity to refer to the language as 'Pumpkin', with a logo to go
with the name, and while you might prefer to have the word 'perl' dropped
entirely rather than needing to elide it, such a preference is not
currently a viable thing to propose so this is the closest you're going to get.

If you believe that perl5 doesn't need a name change at all:

You should still support this proposal because it will put an end to the
repeated conversations about whether we should rename while still leaving
 you with a binary where 'use v5.16;' and friends still work exactly how you
expect, and a language that still has 'Perl' in the name.

If you believe that perl5 requires radical reinvention:

You should support this proposal because it provides us with our own identity
and versioning, within which radical reinvention can then be proposed since
there will no longer be any externally enforced ceiling to our versioning
and aspirations.

If you believe that perl5 needs to develop a strong narrative:

You should support this proposal because a narrative needs to be formed around
a name, and in the process of renaming we as a community can discuss and
develop the narrative that we want to use around this new name once the
renaming is completed.

If you believe that perl5 requires a new implementation to take us forwards:

You should support this proposal because by providing the current
implementation with its own name, we allow alternative implementations to
also have their own name and identity without linguistic complications,
leading to a fair technical playing field within which they can prove
themselves.

If you want developers new to our language to learn how to write code
in the style preferred in this century:

You should support this proposal because Pumpkin Perl is a new name to
type into google, and that provides us with an opportunity to ensure that
the results returned from such a search teach modern perl rather than
FormMail.PL era PERL.

If you want to be able to release code that makes use of the excellent
feature additions made over the past several years:

You should support this proposal because "requires Pumpkin Perl version 20"
is a much easier thing to explain than "this needs perl 5.20, and no that
doesn't mean perl 6 anything will work, and and ...".

If you believe that perl5 is awesome and want to keep using it for the
next decade or three:

You should support this proposal because it represents the best possible
option whose present and future existence falls within our light cone; because
it will represent a stake in the ground that declares that we exist, that
we're proud to belong to this community, proud to be a part of this story,
and above all proud to use the language that our pumpkings have guided and
nurtured on our behalf down through the years.

### How

More easily than you might think, actually:

    $ ~/pumpkin/bin/perl -v
    This is Pumpkin Perl, version 17, subversion 9, built for x86_64-linux-gnu

Of course, that was the easy part. The medium part will be working out which
references in the documentation need to be changed, and adding the relevant
edits to the changeset. Then the hard part will be ... well, there's more than
one hard part. One is taking a completed changeset to the volunteers who
develop perl and responding and reacting to the suggestions they make and the
concerns they raise such that we can actually land this changeset on blead.
Since I've already committed a significant amount of time and effort to the
responding and reacting process, I fully intend to continue to do so as we
get closer to landed, although I'm certainly not going to complain if other
contributors choose to help out.

A second hard part is figuring out the required promotional materials and what
else we'll need to change - but the inestimable Sebastian Riedel is already
thinking about logo ideas (and while he can be a trifle controversial at
times, I think Mojolicious' success at design is rather difficult to refute);
the perl.org website is already on github so there's plenty of people who could
have a go at that; and worst case scenario I know where the Perl Foundation's
marketing chair lives and I can go make a visit bearing bribes and/or an axe.

The third hard part ... is, I suspect, figuring out all the other things that
I haven't thought of yet. I'm sure spotting a bunch of things I haven't thought
of will be easy, mind you, but getting as close to all of them as possible
will probably be a little trickier. However, I have a pretty reasonable
level of belief that the community will come to my aid there; pointing out
my stupid mistakes is as much of a tradition for many people as throwing
stuffed toys at my head during the YAPC State of the Velociraptor keynote,
after all.

### A contributed checklist

Since I seem to be significantly making lists in this post, I may as well
also cover the best checklist for such a proposal that I've seen contributed
to the discussion by somebody else - <a href="http://modernperlbooks.com/mt/2013/02/practical-questions-about-marketing-announcements.html">the one from chromatic's last blog
post</a>.

  > What is this trying to address?

This proposal is intended to address the confusion of identity inherent in the
namespace collison that exists for 'perl 5' with respect to 'perl 6'.

  > Does it meet the needs of real users?

The >100 real users that I've spoken to about this via IRC, email and
comments have almost all been either broadly in favour of a renaming
exercise (albeit some desiring a more drastic such exercise, which
cases I outline above with explanations why this is the closest to
their desires that is currently practicable); considered a renaming
exercise to be positive but not the most pressing need (for whom I have
outlined above why the needs they indicate are both important to me and
positively served by achieving this first); and in a few cases indicated
that they don't see it as useful but without considering it to be actively
harmful - or at least without providing a specific argument for why it's
actively harmful, which leaves me with very little I can do about it.

  > If so, who are those users? Have you talked to them?

They're core contributors, cpan authors, community regulars, perl
newbies, perl6 community members, systems administrators, network
administrators, development managers, four pumpkings, and Larry Wall.

  > When can the users take advantage of the change?

Hopefully as of next year's major release, since the window for controversial
patches has passed for this years, and in any case I think we're going to want
that long to get all our ducks in a row.

  > Who is available to do the work? Are those people willing to do the work?

I am. A number of core contributors are. A number of longstanding community
leaders are. I'm pretty sure we'll be able to pick up more people as we go
along; I've never had too much of a problem shouting 'well volunteered' at
people and making it stick.

In short, I'm confident we'll have enough people to get it done.

  > What will it cost to do the work?

A far from insubstantial amount of blood, sweat, tears and elbow grease, and
sufficient beer to keep me and others going through the process; I'd imagine
we can self fund on this front, though.

  > What are the opportunity costs of doing the work?

I'm not entirely sure, because I can't speak for the other people that will
be involved as to what they'd be doing instead.

I am however very sure that as chromatic says, this comes up about every
six to eight months, and I expect to recoup my personal effort within two
years or so of not having to keep having the same worn out conversation
that wears me out as well significantly out of proportion to how long it
actually takes to have (and no, ignoring said conversation is not a viable
option for me; perl is my community and I won't just ignore people's
concerns).

  > When will we start seeing the benefits of doing the work?

Once the changeset lands on blead we can start using the name (and once
we have one, the logo) pretty much immediately when talking about things;
one of the reasons for the choice of name was that even before we have
a release officially called 'Pumpkin Perl' we can talk about using the
pumpking's perl, which is, after all, what many of us have been doing for
the entire time we've been using perl at all.

The rest of the benefits will percolate through over time.

### In summary

This proposal is feasible.

Within the relatively narrow scope that I am attempting to cover, there is
no other currently extant proposal that is better along any of the axes
people have expressed that they consider important and is also feasible.

This proposal will help. It won't solve everything. It isn't a silver bullet.
But it would be a significant improvement over the status quo, and I am
confident that it can actually be implemented and accepted.
